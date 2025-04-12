// controllers/mainController.js
const mainService = require('../services/mainService'); // 서비스 레이어 호출

class MainController {
  // 컨트롤러 처리
  async getBanners(req, res) {
    try {
  //    const users = await mainService.getUsers(); // 서비스에서 데이터를 가져옴
      res.status(200).json({result: true, banner_list: ['/banner_ex_1.png', 'banner_ex_2.png']});
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }


  async getPackages(req, res) {
    try {
  //    const users = await mainService.getUsers(); // 서비스에서 데이터를 가져옴
      res.status(200).json({result: true, package_list: ['/banner_ex_1.png', 'banner_ex_2.png']});
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }

  async getPlaces(req, res) {
    try {
  //    const users = await mainService.getUsers(); // 서비스에서 데이터를 가져옴
      res.status(200).json({result: true, inner: ['서울', '인천'], outer: ['영국', '프랑스']});
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }
}

module.exports = new MainController();
