// services/mainService.js
const db = require('../utils/db'); // DB 연결

class MainService {
  constructor() {
    this.db = new db(); // DB 클래스 인스턴스화
  }

  async getUsers() {
    try {
      await this.db.connect(); // DB 연결
      const results = await this.db.query('SELECT * FROM users'); // 데이터 조회
      const userList = results.map((row) => ({
        id: row.id,
        name: row.name,
        email: row.email,
      }));
      this.db.close(); // DB 연결 종료
      return userList;
    } catch (err) {
      console.error('쿼리 실행 실패:', err);
      throw new Error('데이터베이스 오류');
    }
  }
}

module.exports = new MainService();
