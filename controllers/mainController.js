// controllers/mainController.js
const mainService = require('../services/mainService'); // 서비스 레이어 호출

class MainController {
  // 컨트롤러 처리
  async getBanners(req, res) {
    try {
      const banner_list = await mainService.getMainImageList('banner'); // 서비스에서 데이터를 가져옴
      res.status(200).json({result: true, banner_list: banner_list});
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }


  async getPackages(req, res) {
    try {
      const package_list = await mainService.getMainImageList('package'); // 서비스에서 데이터를 가져옴
      res.status(200).json({result: true, package_list: package_list});
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }

  async getPlaces(req, res) {
    try {
      const {inner_list, outer_list} = await mainService.getPlaceList(); // 서비스에서 데이터를 가져옴
      console.log(inner_list, outer_list);
      res.status(200).json({result: true, inner: inner_list, outer: outer_list});
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }
}

module.exports = new MainController();
