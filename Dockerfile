FROM alpine AS yt-dlp
RUN apk add --no-cache curl
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
RUN chmod a+rx /usr/local/bin/yt-dlp

FROM node:lts-alpine AS npm
RUN apk add --no-cache npm
COPY package.json package-lock.json ./
RUN npm install --no-cache --production

FROM node:lts-alpine
RUN apk add --no-cache ffmpeg python3
COPY --from=yt-dlp /usr/local/bin/yt-dlp /usr/local/bin/yt-dlp
COPY --from=npm node_modules node_modules
COPY ./src ./src
CMD ["node", "src/index.mjs"]
