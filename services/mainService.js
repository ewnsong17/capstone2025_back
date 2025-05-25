// services/mainService.js
const db = require('../utils/db'); // DB 연결

class MainService {

  /**
   * 필터 리스트 가져오기
   * @param {*} type 
   * @returns 
   */
  async getMainImageList(type) {
    try {
      const results = await db.query('SELECT * FROM `main_image_list` WHERE `type` = ?', [type]); // 데이터 조회

      var image_list = [];

      for (var result of results) {
        image_list.push(result.image_url);
      }

      return image_list;
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    }
  }

  /**
   * 여행 국가 & 도시 리스트 가져오기
   * @returns 
   */
  async getPlaceList() {
    try {
      const results = await db.query('SELECT * FROM `search_city_list`'); // 데이터 조회

      var inner_list = [];
      var outer_list = [];

      for (var result of results) {
        if (result.type == 'inner') {
          inner_list.push(result.value);
        } else if (result.type == 'outer') {
          outer_list.push(result.value);
        }
      }

      return {inner_list, outer_list};
    } catch (err) {
      console.error(err);
      throw new Error('데이터베이스 오류가 발생하여 처리하지 못했습니다.');
    }
  }
}

module.exports = new MainService();