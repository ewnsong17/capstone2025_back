// index.js

console.log("Hello, world!");

// 예시: 간단한 HTTP 서버 설정 (Express 사용)
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
