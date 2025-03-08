// index.js

// utils
const config = require('./utils/config');
//const db = require('./utils/db');

// routes
const mainRoutes = require('./routes/mainRoutes');
const serachRoutes = require('./routes/searchRoutes');
const userRoutes = require('./routes/userRoutes');

// express
const express = require('express');
const app = express();
const port = config.server.port;
app.use(express.json());

console.info(`express 모듈로 ${port} 포트 서버 오픈을 시작합니다.`);

// middle-ware
app.use((req, res, next) => {
  console.log(`Request: ${req.method} ${req.url}`);
  next();  //
});

app.use('/main', mainRoutes);
app.use('/search', serachRoutes);
app.use('/user', userRoutes);

console.info(`API routes module 로드되었습니다.`);

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(port, () => {
  console.info(`서버가 ${port} 포트로 연결되었습니다.`);
});
