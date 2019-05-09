const child_process = require('child_process');
const mergeStream = require('merge-stream');
const express = require('express');
const serveIndex = require('serve-index');

const PUBLIC_FOLDER = 'public';

const app = express();

app.use('/', express.static(PUBLIC_FOLDER), serveIndex(PUBLIC_FOLDER));

app.get('/download', (req, res) => {
  const { id } = req.query;
  const { stderr, stdout } = child_process.spawn('youtube-dl', [
    '--format',
    'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio/best',
    '--output',
    `./${PUBLIC_FOLDER}/%(title)s.%(ext)s`,
    `https://www.youtube.com/watch?v=${id}`,
  ]);
  mergeStream(stderr, stdout).pipe(res);
});

app.listen(process.env.HTTP_PORT || 80, () => {
  console.log('Listening...');
});
