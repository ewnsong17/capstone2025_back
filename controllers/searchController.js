// controllers/searchController.js
const searchService = require('../services/searchService'); // 서비스 레이어 호출

class SearchController {
  // 컨트롤러 처리
  async getFilters(req, res) {
    try {
  //    const users = await userService.getUsers(); // 서비스에서 데이터를 가져옴
      res.status(200).json({result: true, filter_list: ['콘서트', '뮤지컬']});
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }


  async getResults(req, res) {
    try {
      const { type, price } = req;
  //    const users = await userService.getUsers(); // 서비스에서 데이터를 가져옴
      res.status(200).json({result: true, result_list: {}});
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }
}

module.exports = new SearchController();