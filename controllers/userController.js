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
      const { id, pwd, image, birthday } = req.body;
      console.log(id, pwd, image, birthday);
      if (id == null || pwd == null) {
        throw new Error('올바르지 않은 ID 또는 PWD 입니다.');
      }
      const result = await userService.getSignUp(id, pwd, image, birthday);
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
   * 유저 리뷰 리스트
   * @param {*} req 
   * @param {*} res 
   */
  async getReviews(req, res) {
    try {
      const user = req.session.user;
      const { state } = req.body;
      if (user != null && state != null) {
        const review_list = await userService.getReviewList(user.id, state); // 서비스에서 데이터를 가져옴
        res.status(200).json({result: true, review_list: review_list});
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }
  
  /**
   * 유저 리뷰 추가
   * @param {*} req 
   * @param {*} res 
   */
  async addReview(req, res) {
    try {
      const user = req.session.user;
      const { pkg_id, rate, comment } = req.body;
      if (user != null && pkg_id != null && rate != null && comment != null) {
        const result = await userService.addReview(user.id, pkg_id, rate, comment); // 서비스에서 데이터를 가져옴
        res.status(200).json({result: result});
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }
  
  /**
   * 유저 리뷰 삭제
   * @param {*} req 
   * @param {*} res 
   */
  async removeReview(req, res) {
    try {
      const user = req.session.user;
      const { id } = req.body;
      if (user != null && id != null) {
        const result = await userService.removeReview(id, user.id); // 서비스에서 데이터를 가져옴
        res.status(200).json({result: result});
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }
  
  /**
   * 내 여행 리스트
   * @param {*} req 
   * @param {*} res 
   */
  async getFavorites(req, res) {
    try {
      const user = req.session.user;
      if (user != null) {
        const favorite_list = await userService.getFavoriteList(user.id); // 서비스에서 데이터를 가져옴
        res.status(200).json({result: true, favorite_list: favorite_list});
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }
  
  /**
   * 내 여행 추가
   * @param {*} req 
   * @param {*} res 
   */
  async addFavorite(req, res) {
    try {
      const user = req.session.user;
      const { name, type, start_date, end_date, country } = req.body;
      if (user != null && name != null && start_date != null && end_date != null && country != null) {
        const result = await userService.addFavorite(user.id, name, type, start_date, end_date, country); // 서비스에서 데이터를 가져옴
        res.status(200).json({result: result});
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({result: false, exception: error.message});
    }
  }
  
  /**
   * 내 여행 삭제
   * @param {*} req 
   * @param {*} res 
   */
  async remoiveFavorite(req, res) {
    try {
      const user = req.session.user;
      const { id } = req.body;
      if (user != null && id != null) {
        const result = await userService.removeFavorite(id, user.id); // 서비스에서 데이터를 가져옴
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
