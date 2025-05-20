// services/mainService.js
const db = require('../utils/db'); // DB 연결
const User = require('../structs/user');
const Review = require('../structs/review');
const MyTrip = require('../structs/trip');
const Place = require('../structs/place');
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
   * @param {*} state 
   * @returns 
   */
  async getReviewList(user_id, state) {
    try {
      results = [];
      if (state == 'mine') {
        results = await db.query("SELECT re.id, inf.id as `package_id`, inf.name, '-1' as price, inf.start_date, inf.end_date,\
          inf.country, re.rate, re.comment FROM `user_review` re INNER JOIN `my_trip_info` inf ON (re.id = inf.id) WHERE inf.`user_id` = ?", [user_id]); // 데이터 조회
      } else {
        results = await db.query("SELECT re.id, inf.id as `package_id`, inf.name, inf.price, inf.start_date, inf.end_date,\
         inf.country, re.rate, re.comment FROM `user_review` re INNER JOIN `package_info` inf ON (re.id = inf.id) WHERE `user_id` = ?", [user_id]); // 데이터 조회
      }

      const review_list = [];

      for (var result of results) {
        review_list[result.id] = (new Review(result.id, result.package_id, result.price, result.start_date, result.end_date, result.country, result.rate, result.comment));
      }

      return review_list;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    }
  }

  /**
   * 리뷰 추가
   * @param {*} user_id 
   * @param {*} pkg_id 
   * @param {*} rate 
   * @param {*} comment 
   * @returns 
   */
  async addReview(user_id, pkg_id, rate, comment) {
    try {
      const results = await db.query("INSERT INTO `user_review` (`id`, `user_id`, `package_id`, `rate`, `comment`) VALUES (DEFAULT, ?, ?, ?, ?)", [user_id, pkg_id, rate, comment]); // 데이터 조회
      return results != null;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    } finally {
      return false;
    }
  }

  /**
   * 리뷰 삭제
   * @param {*} id 
   * @param {*} user_id 
   * @returns 
   */
  async removeReview(id, user_id) {
    try {
      const results = await db.query("DELETE FROM `user_review` WHERE `id` = ? AND `user_id` = ?", [id, user_id]); // 데이터 조회

      return results != null;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    } finally {
      return false;
    }
  }

  /**
   * 내 여행 리스트 가져오기
   * @param {*} user_id 
   * @returns 
   */
  async getMyTripList(user_id) {
    try {
      const results = await db.query("SELECT tr.id AS tid, tr.name AS tname, tr.type, tr.start_date, tr.end_date, tr.country, pl.id AS pid, pl.name AS pname, pl.place, pl.reg_date\
         FROM `my_trip_info` tr LEFT JOIN my_trip_place_info pl ON (tr.id = pl.trip_id) WHERE `user_id` = ?", [user_id]); // 데이터 조회

      const trip_list = {};

      for (var result of results) {
        // 없으면 트립 부터 추가
        if (trip_list[result.tid] === undefined) {
          trip_list[result.tid] = (new MyTrip(result.tname, result.type, result.price, result.start_date, result.end_date, result.country));
          trip_list[result.tid]['place_list'] = {};
        }

        if (result.pid != null) {
          trip_list[result.tid]['place_list'][result.pid] = new Place(result.pname, result.place, result.reg_date);
        }
      }

      return trip_list;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    }
  }

  /**
   * 내 여행 추가
   * @param {*} user_id 
   * @param {*} name 
   * @param {*} start_date 
   * @param {*} end_date 
   * @param {*} country 
   * @returns 
   */
  async addMyTrip(user_id, name, type, start_date, end_date, country) {
    try {
      const results = await db.query("INSERT INTO `my_trip_info` (`id`, `user_id`, `name`, `type`, `start_date`, `end_date`, `country`) VALUES (DEFAULT, ?, ?, ?, ?, ?, ?)",
         [user_id, name, type, start_date, end_date, country]); // 데이터 조회
      return results != null;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    } finally {
      return false;
    }
  }

  /**
   * 내 여행 도시 추가
   * @param {*} id 
   * @param {*} name 
   * @param {*} place 
   * @param {*} reg_date 
   * @returns 
   */
  async addMyTripPlace(id, name, place, reg_date) {
    try {
      const results = await db.query("INSERT INTO `my_trip_place_info` (`id`, `trip_id`, `name`, `place`, `reg_date`) VALUES (DEFAULT, ?, ?, ?, ?)",
         [id, name, place, reg_date]); // 데이터 조회
      return  results != null;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    } finally {
      return false;
    }
  }

  /**
   * 내 여행 삭제
   * @param {*} id 
   * @param {*} user_id 
   * @returns 
   */
  async removeMyTrip(id, user_id) {
    try {
      const results = await db.query("DELETE FROM `my_trip_info` WHERE `id` = ? AND `user_id` = ?", [id, user_id]); // 데이터 조회

      return results != null;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    } finally {
      return false;
    }
  }
}

module.exports = new UserService();
