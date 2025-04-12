// controllers/userController.js
const userService = require('../services/userService');

class UserController {
  // 컨트롤러 처리

  /**
   * 유저 회원 가입 시도
   * @param {*} req 
   * @param {*} res 
   */
  async getSignUp(req, res) {
    try {
      const { id, pwd } = req.body;
      console.log(id, pwd);
      if (id == null || pwd == null) {
        throw new Error('올바르지 않은 ID 또는 PWD 입니다.');
      }
      const result = await userService.getSignUp(id, pwd);
      res.status(200).json({result: result});
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }

  /**
   * 유저 로그인 처리
   * @param {*} req 
   * @param {*} res 
   */
  async getLogin(req, res) {
    try {
      const { id, pwd } = req;
      const users = await userService.getLogin(id, pwd);
      if (users.length) {
        user = users[0];
      }
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
