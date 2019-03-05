FROM alpine
RUN apk add nodejs npm youtube-dl
RUN mkdir public
COPY package.json .
RUN npm install --no-package-lock --production
COPY ./src ./src
CMD ["node", "src/index.js"]
