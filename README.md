1. Start a minimal working container using

`
docker run -d -p 8080:80 ravshansbox/youtube-downloader
`

2. Trigger a download using curl

`
curl http://localhost:8080/download\?url\=https://www.youtube.com/watch\?v\=2Vv-BfVoq4g
`

3. Navigate to <http://localhost:8080> in the browser.
