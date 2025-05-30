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
   * @param {*} email 
   * @param {*} password 
   * @param {*} name 
   * @param {*} birthday 
   * @returns 
   */
  async getSignUp(email, password, birthday, name) {
    try {
      // 중복 체크: email 기준
      const duplicateChk = await db.query(
        'SELECT COUNT(*) cnt FROM `user_info` WHERE `email` = ?', [email]);

      if (duplicateChk.length && duplicateChk[0]['cnt']) {
        throw new Error('이미 존재하는 이메일입니다.');
      }

      // 비밀번호 해시 처리
      const hass_password = crypto.createHash('sha256').update(password).digest('hex');

      // 데이터 삽입: email, password, birthday, name 컬럼
      const results = await db.query(
        'INSERT INTO `user_info` (`email`, `password`, `birthday`, `name`) VALUES (?, ?, ?, ?)',
        [email, hass_password, birthday, name]
      );
      return results.insertId > 0;
    } catch (err) {
      console.error('쿼리 실행 실패:', err);
      throw new Error(err.message);
    }
  }

  /**
   * 유저 로그인 SELECT 처리
   * @param {*} email 
   * @param {*} password 
   * @returns 
   */
  async getLogin(email, password) {
    try {
      const results = await db.query(
        'SELECT * FROM `user_info` WHERE `email` = ?', [email]);

      const hass_password = crypto.createHash('sha256').update(password).digest('hex');

      for (var result of results) {
        if (result.password === hass_password) {
          // User 구조체가 email, birthday, name 등을 받도록 수정 필요할 수 있음
          return new User(result.id, result.name, result.email, result.birthday);
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
      const results = await db.query(
        `SELECT re.id, inf.id AS place_id, inf.name, inf.place, inf.reg_date, re.rate, re.comment
       FROM user_review re
       JOIN my_trip_place_info inf ON re.target_id = inf.id
       JOIN my_trip_info trip ON inf.trip_id = trip.id
       WHERE re.user_id = ?`, 
        [user_id]
      );

      const review_list = {};
      for (const result of results) {
        review_list[result.id] = new Review(
          result.id, result.place_id, result.name, result.place,
          result.reg_date, result.rate, result.comment
        );
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
   * @param {*} id 
   * @param {*} rate 
   * @param {*} comment 
   * @returns 
   */
  async addReview(user_id, id, rate, comment) {
    try {
      const results = await db.query("INSERT INTO `user_review` (`id`, `user_id`, `target_id`, `rate`, `comment`) VALUES (DEFAULT, ?, ?, ?, ?)", [user_id, id, rate, comment]); // 데이터 조회
      return results != null;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    }
  }

  /**
   * 내여행 리스트 가져오기
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
   * 리뷰 수정
   * @param {*} user_id 
   * @param {*} id 
   * @param {*} comment 
   * @returns 
   */
  async modifyReview(user_id, id, comment) {
    try {
      const results = await db.query("UPDATE `user_review` SET `comment` = ? WHERE `id` = ? AND `user_id` = ?", [comment, id, user_id]); // 데이터 조회
      return results != null;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
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
      return results != null;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
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
    }
  }

  /**
   * 내 여행 도시 삭제
   * @param {*} id 
   * @returns 
   */
  async removeMyTripPlace(id) {
    try {
      const results = await db.query("DELETE FROM `my_trip_place_info` WHERE `id` = ?",
        [id]); // 데이터 조회
      return results != null;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    }
  }
}

module.exports = new UserService();