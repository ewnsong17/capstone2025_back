// services/mainService.js

class MainService {

  async getUsers() {
    try {
      const results = await this.db.query('SELECT * FROM users'); // 데이터 조회
      const userList = results.map((row) => ({
        id: row.id,
        name: row.name,
        email: row.email,
      }));
      return userList;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류');
    }
  }
}

module.exports = new MainService();
