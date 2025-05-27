// config.js
const config = {
    server: {
      ip: '192.168.171.126',
			port: 3000,
    },
    db: {
      host: 'localhost',     // MySQL 서버의 호스트 주소
      user: 'root',          // MySQL 사용자명
      password: 'csedbadmin',  // MySQL 비밀번호
      database: 'capstone',   // 사용할 데이터베이스명
      port: 3306             // MySQL 포트 (기본값 3306)
    },
    ai: {
      api_key: 'AIzaSyD-XwBrgWkScmOmQu0WTYAyHtcyzWXk04E',
    }
  };
  
  module.exports = config;