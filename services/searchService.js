// services/mainService.js
const db = require('../utils/db'); // DB 연결
const ai = require('../utils/ai');
const Package = require('../structs/package');
const Move = require('../structs/move');

class SearchService {

  /**
   * 필터 리스트 가져오기
   * @returns 
   */
  async getFilterList() {
    try {
      const results = await db.query(
        'SELECT * FROM `search_filter_list`'); // 데이터 조회

      var filter_list = [];

      for (var result of results) {
        filter_list.push(result.type);
      }

      return filter_list;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    }
  }

  /**
   * 패키지 리스트 가져오기
   * @param {*} type 
   * @param {*} min_price 
   * @param {*} max_price 
   * @returns 
   */
  async getPackageList(type, min_price, max_price) {
    try {
      const results = await db.query("SELECT * FROM `package_info` WHERE `type` = ? AND `price` >= ? AND `price` <= ? ORDER BY `id` DESC", [type, min_price, max_price]); // 데이터 조회

      const package_list = [];

      for (var result of results) {
        package_list.push(new Package(result.id, result.name, result.type, result.price, result.start_date, result.end_date, result.country, result.image, result.url));
      }

      return package_list;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    }
  }

  /**
   * AI 답변 가져오기
   * @param {*} start_date 
   * @param {*} end_date 
   * @param {*} city 
   * @Param {*} taste
   * @returns 
   */
  async getAskAI(start_date, end_date, city, taste) {
    try {
      return await ai.runPrompt(start_date, end_date, city, taste);
    } catch (err) {
      console.error(err);
      throw new Error(err);
    }
  }

  /**
   * 항공/ 숙소 가져오기
   * @param {*} type 
   * @param {*} place 
   * @param {*} date 
   * @returns 
   */
  async getMoveList(type, place, date) {
    try {
      const results = await db.query("SELECT * FROM move_info WHERE `type` = ? AND `place` = ? AND `date` = ? ORDER BY `id` DESC", [type, place, date]); // 데이터 조회

      const package_list = [];

      for (var result of results) {
        package_list.push(new Move(result.id, result.place, result.name, result.price, result.date));
      }

      return package_list;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    }
  }
}

module.exports = new SearchService();
