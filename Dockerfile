FROM alpine as youtube-dl
RUN apk add --no-cache curl
RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
RUN chmod a+rx /usr/local/bin/youtube-dl

FROM alpine as node
RUN apk add --no-cache nodejs

FROM node as npm
RUN apk add --no-cache npm
COPY package.json package-lock.json ./
RUN npm install --no-cache --production

FROM node
RUN apk add --no-cache ffmpeg python
COPY --from=youtube-dl /usr/local/bin/youtube-dl /usr/local/bin/youtube-dl
COPY --from=npm node_modules node_modules
COPY ./src ./src
RUN mkdir public
CMD ["node", "src/index.js"]
