// db.js
const mysql = require('mysql2');
const config = require('./config');

class DB {
  constructor() {
    this.connection = mysql.createConnection({
      host: config.db.host,  // MySQL 서버의 호스트 주소
      user: config.db.user,       // MySQL 사용자명
      password: config.db.password,  // MySQL 비밀번호
      database: config.db.database,  // 사용할 데이터베이스명
      port: config.db.port, // 포트
    });
  }

  // MySQL 연결
  connect() {
    return new Promise((resolve, reject) => {
      this.connection.connect((err) => {
        if (err) {
          console.error('MySQL 서버 연결에 실패했습니다:', err);
          reject(err);
        } else {
          console.log('MySQL에 성공적으로 연결되었습니다!');
          resolve(this.connection);
        }
      });
    });
  }

  // 쿼리 실행
  query(sql) {
    return new Promise((resolve, reject) => {
      this.connection.query(sql, (err, results) => {
        if (err) {
          reject(err);
        } else {
          resolve(results);
        }
      });
    });
  }

  // 연결 종료
  close() {
    this.connection.end();
  }
}

module.exports = DB;
