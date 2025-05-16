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
      const { id, pwd } = req.body;
      console.log(id, pwd);
      const user = await userService.getLogin(id, pwd);
      if (user != null) {
        req.session.user = user;
        res.status(200).json({result: true});
      } else {
        throw new Error('유저 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }

  /**
   * 유저 로그아웃 처리
   * @param {*} req 
   * @param {*} res 
   */
  async getLogout(req, res) {
    try {
      req.session.destroy((err) => {
        if (err) {
          throw new Error(err);
        }
        res.status(200).json({result: true});
      });
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }
  
  /**
   * 유저 리뷰 처리
   * @param {*} req 
   * @param {*} res 
   */
  async getReviews(req, res) {
    try {
      const user = req.session.user;
      if (user != null) {
        const review_list = await userService.getReviewList(user.id); // 서비스에서 데이터를 가져옴
        res.status(200).json({result: true, review_list: review_list});
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }

  /**
   * 유저 저장 처리
   * @param {*} req 
   * @param {*} res 
   */
  async getFavorite(req, res) {
    try {
      const { pkg_id } = req.body;
      const user = req.session.user;
      if (user != null) {
        const result = await userService.addFavorite(user.id, pkg_id); // 서비스에서 데이터를 가져옴
        res.status(200).json({result: result});
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }
}

module.exports = new UserController();
