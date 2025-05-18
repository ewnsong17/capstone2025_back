// services/mainService.js
const db = require('../utils/db'); // DB 연결
const User = require('../structs/user');
const Review = require('../structs/review');
const crypto = require('crypto');

class UserService {

  /**
   * 유저 회원가입 DB INSERT 처리
   * @param {*} name 
   * @param {*} pwd 
   * @param {*} image 
   * @param {*} birthday 
   * @returns 
   */
  async getSignUp(name, pwd, image, birthday) {
    try {
      const duplicateChk = await db.query(
        'SELECT COUNT(*) cnt FROM `user_info` WHERE `name` = ?', [name]);
      
      if (duplicateChk.length && duplicateChk[0]['cnt']) {
        throw new Error('이미 존재하는 ID입니다.');
      }

      const hass_pwd = crypto.createHash('sha256').update(pwd).digest('hex');

      const results = await db.query(
        'INSERT INTO `user_info` (`name`, `password`, `image`, `birthday`) VALUES (?, ?, ?, ?)', [name, hass_pwd, image, birthday]); // 데이터 조회
      return results.insertId > 0;
    } catch (err) {
      console.error('쿼리 실행 실패:', err);
      throw new Error(err.message);
    }
  }
  
  /**
   * 유저 로그인 SELECT 처리
   * @param {*} name 
   * @param {*} pwd 
   * @returns 
   */
  async getLogin(name, pwd) {
    try {
      const results = await db.query(
        'SELECT * FROM `user_info` WHERE `name` = ?', [name]); // 데이터 조회

      const hass_pwd = crypto.createHash('sha256').update(pwd).digest('hex');

      for (var result of results) {
        if (result.password == hass_pwd) {
          return new User(result.id, result.name, result.image, result.birthday);
        }
      }

      return null;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    }
  }

  /**
   * 유저 리뷰 리스트 가져오기
   * @param {*} user_id 
   * @returns 
   */
  async getReviewList(user_id) {
    try {
      const results = await db.query("SELECT re.id, inf.name, inf.price, inf.start_date, inf.end_date,\
         inf.country, re.rate, re.comment FROM `user_review` re INNER JOIN package_info inf ON (re.package_id = inf.id) WHERE `user_id` = ?", [user_id]); // 데이터 조회

      const review_list = [];

      for (var result of results) {
        review_list.push(new Review(result.id, result.name, result.price, result.start_date, result.end_date, result.country, result.rate, result.comment));
      }

      return review_list;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    }
  }

  /**
   * 유저 찜 추가 / 삭제 하기
   * @param {*} user_id 
   * @param {*} pkg_id 
   * @returns 
   */
  async addFavorite(user_id, pkg_id) {
    try {
      const duplicateChk = await db.query(
        'SELECT COUNT(*) cnt FROM `user_favorites` WHERE `user_id` = ? AND `package_id` = ?', [user_id, pkg_id]);
      
      var results = {};
      if (duplicateChk.length && duplicateChk[0]['cnt']) {
        // 이미 찜목록에 있으면 삭제 처리
        results = await db.query(
          'DELETE FROM `user_favorites` WHERE `user_id` = ? AND `package_id` = ?', [user_id, pkg_id]); // 데이터 조회
      } else {
        // 없으면 추가 처리
        results = await db.query(
          'INSERT INTO `user_favorites` (`user_id`, `package_id`) VALUES (?, ?)', [user_id, pkg_id]); // 데이터 조회
      }
      console.log(results);

      return results.affectedRows > 0;
    } catch (err) {
      console.error('쿼리 실행 실패:', err);
      throw new Error(err.message);
    }
  }
}

module.exports = new UserService();
