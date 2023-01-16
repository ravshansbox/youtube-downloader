1. Start a minimal working container using

`docker run -d -p 8080:80 -v $PWD:/public ravshansbox/youtube-downloader`

2. Trigger a download using curl

`curl "http://localhost:8080/download?id=XqZsoesa55w"`

3. Navigate to <http://localhost:8080> in the browser.
