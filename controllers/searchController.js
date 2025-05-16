// controllers/searchController.js
const searchService = require('../services/searchService'); // 서비스 레이어 호출

class SearchController {
  // 컨트롤러 처리
  async getFilters(req, res) {
    try {
      const filter_list = await searchService.getFilterList(); // 서비스에서 데이터를 가져옴
      res.status(200).json({result: true, filter_list: filter_list});
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }


  async getResults(req, res) {
    try {
      const { type, min_price, max_price } = req.body;
      if (type != null && min_price != null && max_price != null) {
        const package_list = await searchService.getPackageList(type, min_price, max_price); // 서비스에서 데이터를 가져옴
        res.status(200).json({result: true, result_list: package_list});
      } else {
        throw new Error('올바른 타입 또는 가격이 아닙니다.');
      }
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }


  async getAskAI(req, res) {
    try {
      const { start_date, end_date, city } = req.body;
      if (start_date != null && end_date != null && city != null) {
        const answer = await searchService.getAskAI(start_date, end_date, city); // 서비스에서 데이터를 가져옴
        res.status(200).json({result: true, answer: answer});
      } else {
        throw new Error('올바른 질문 형식이 아닙니다.');
      }
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }
}

module.exports = new SearchController();