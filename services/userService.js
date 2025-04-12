// services/mainService.js

class UserService {

  /**
   * 유저 회원가입 DB INSERT 처리
   * @param {*} id 
   * @param {*} pwd 
   * @returns 
   */
  async getSignUp(id, pwd) {
    try {
      const duplicateId = await this.db.query(
        'SELECT COUNT(*) cnt FROM `user_info` WHERE `name` = ?', [id]);
      
      if (duplicateId.length && duplicateId[0]['cnt']) {
        throw new Error('이미 존재하는 ID입니다.');
      }

      const results = await this.db.query(
        'INSERT INTO `user_info` (`name`, `password`) VALUES (?, ?)', [id, pwd]); // 데이터 조회
      return results.insertId > 0;
    } catch (err) {
      console.error('쿼리 실행 실패:', err);
      throw new Error(err.message);
    }
  }
  
  /**
   * 유저 로그인 SELECT 처리
   * @param {*} id 
   * @param {*} pwd 
   * @returns 
   */
  async getLogin(id, pwd) {
    try {
      const results = await this.db.query(
        'SELECT * FROM `user_info` WHERE `id` = ? AND `password` = PASSWORD(?)', [id, pwd]); // 데이터 조회
      return results;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    }
  }
}

module.exports = new UserService();
