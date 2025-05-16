// index.js

// utils
const config = require('./utils/config');

// routes
const mainRoutes = require('./routes/mainRoutes');
const serachRoutes = require('./routes/searchRoutes');
const userRoutes = require('./routes/userRoutes');


// express
const express = require('express');
const session = require('express-session');
const FileStore = require('session-file-store')(session);

const multer = require('multer');
const upload = multer();
const cors = require('cors');

const app = express();
const port = config.server.port;
app.use(express.json());
app.use(cors());

console.info(`express 모듈로 ${port} 포트 서버 오픈을 시작합니다.`);

// middle-ware
app.use((req, res, next) => {
  console.log(`Request: ${req.method} ${req.url}`);
  next(); // 미들웨어 처리
});

// 세션 미들웨어 설정
app.use(session({
  store: new FileStore({ 
    path: './sessions',  // 세션을 저장할 디렉터리 경로 설정
    ttl: 86400,          // 세션 파일의 만료 시간 (초 단위)
    retries: 0,          // 세션 파일 읽기 실패 시 재시도 횟수
  }),
  secret: 'capstone',         // 세션 암호화 키
  resave: false,              // 세션이 수정되지 않아도 다시 저장할지 여부
  saveUninitialized: true,    // 초기화되지 않은 세션도 저장할지 여부
  cookie: { secure: false }   // HTTPS 사용 시 true로 설정, 개발 환경에서는 false
}));

app.use('/main', upload.none(), mainRoutes);
app.use('/search', upload.none(), serachRoutes);
app.use('/user', upload.none(), userRoutes);

console.info(`API routes module 로드되었습니다.`);

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(port, () => {
  console.info(`서버가 ${port} 포트로 연결되었습니다.`);
});
