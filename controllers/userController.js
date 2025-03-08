// controllers/userController.js
const userService = require('../services/userService');

class UserController {
  // 컨트롤러 처리
  async getSignUp(req, res) {
    try {
      const { id, pwd } = req;
  //    const users = await mainService.getUsers(); // 서비스에서 데이터를 가져옴
      res.status(200).json({result: true});
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }


  async getLogin(req, res) {
    try {
      const { id, pwd } = req;
  //    const users = await mainService.getUsers(); // 서비스에서 데이터를 가져옴
      res.status(200).json({result: true});
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }

  async getLogout(req, res) {
    try {
  //    const users = await mainService.getUsers(); // 서비스에서 데이터를 가져옴
      res.status(200).json({result: true});
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }

  async getReviews(req, res) {
    try {
  //    const users = await mainService.getUsers(); // 서비스에서 데이터를 가져옴
      res.status(200).json({result: true, review_list: {}});
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }


  async getFavorite(req, res) {
    try {
      const { pkg_id } = req;
  //    const users = await mainService.getUsers(); // 서비스에서 데이터를 가져옴
      res.status(200).json({result: true});
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }
}

module.exports = new UserController();
