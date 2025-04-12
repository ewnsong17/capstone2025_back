// db.js
const mysql = require('mysql2/promise');
const config = require('./config');

class DB {
  constructor() {
    this.pool = mysql.createPool({
      host: config.db.host,  // MySQL 서버의 호스트 주소
      user: config.db.user,       // MySQL 사용자명
      password: config.db.password,  // MySQL 비밀번호
      database: config.db.database,  // 사용할 데이터베이스명
      port: config.db.port, // 포트
      waitForConnections: true,
      connectionLimit: 10,  // 풀에서 최대 연결 수
      queueLimit: 0,        // 요청 대기열 제한 (0이면 무제한)
    });
  }

  // 쿼리 실행
  async query(sql, params = []) {
    const [rows] = await this.pool.execute(sql, params);
    return rows;
  }
}

const db = new DB();
module.exports = db;
