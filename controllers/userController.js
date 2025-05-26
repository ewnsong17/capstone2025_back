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
      const { email, password, birthday, name } = req.body;
      console.log(email, password, birthday, name);
      if (email == null || password == null) {
        throw new Error('올바르지 않은 ID 또는 PWD 입니다.');
      }
      const user = await userService.getSignUp(email, password, birthday, name);
      res.status(200).json({ result: true, user: user });

    } catch (error) {
      res.status(500).json({ result: false, exception: error.message });
    }
  }

  /**
   * 유저 로그인 처리
   * @param {*} req 
   * @param {*} res 
   */
  async getLogin(req, res) {
    try {
      const { email, password } = req.body;
      if (!email || !password) {
        return res.status(400).json({ result: false, exception: '이메일 또는 비밀번호가 누락되었습니다.' });
      }
      const user = await userService.getLogin(email, password);
      if (!user) {
        return res.status(401).json({ result: false, exception: '이메일 또는 비밀번호가 올바르지 않습니다.' });
      }
      req.session.user = user;
      res.status(200).json({ result: true });
    } catch (error) {
      res.status(500).json({ result: false, exception: error.message });
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
        res.status(200).json({ result: true });
      });
    } catch (error) {
      res.status(500).json({ result: false, exception: error.message });
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
      if (user != null) {
        const review_list = await userService.getReviewList(user.id); // 서비스에서 데이터를 가져옴
        res.status(200).json({ result: true, review_list: review_list });
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({ result: false, exception: error.message });
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
        res.status(200).json({ result: result });
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({ result: false, exception: error.message });
    }
  }

  /**
   * 유저 리뷰 수정
   * @param {*} req 
   * @param {*} res 
   */
  async modifyReview(req, res) {
    try {
      const user = req.session.user;
      const { id, comment } = req.body;
      if (user != null && id != null && comment != null) {
        const result = await userService.modifyReview(user.id, id, comment); // 서비스에서 데이터를 가져옴
        res.status(200).json({ result: result });
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({ result: false, exception: error.message });
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
        res.status(200).json({ result: result });
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({ result: false, exception: error.message });
    }
  }

  /**
   * 내 여행 리스트
   * @param {*} req 
   * @param {*} res 
   */
  async getMyTrips(req, res) {
    try {
      const user = req.session.user;
      if (user != null) {
        const trip_list = await userService.getMyTripList(user.id); // 서비스에서 데이터를 가져옴
        res.status(200).json({ result: true, trip_list: trip_list });
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({ result: false, exception: error.message });
    }
  }

  /**
   * 내 여행 추가
   * @param {*} req 
   * @param {*} res 
   */
  async addMyTrip(req, res) {
    try {
      const user = req.session.user;
      const { name, type, start_date, end_date, country } = req.body;
      if (user != null && name != null && start_date != null && end_date != null && country != null) {
        const result = await userService.addMyTrip(user.id, name, type, start_date, end_date, country); // 서비스에서 데이터를 가져옴
        res.status(200).json({ result: result });
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({ result: false, exception: error.message });
    }
  }

  /**
   * 내 여행 도시 추가
   * @param {*} req 
   * @param {*} res 
   */
  async addMyTripPlace(req, res) {
    console.log("📥 받은 req.body:", req.body);
    try {
      const user = req.session.user;
      const { id, name, place, reg_date } = req.body;
      if (user != null && id != null && place != null && reg_date != null) {
        const result = await userService.addMyTripPlace(id, name, place, reg_date); // 서비스에서 데이터를 가져옴
        res.status(200).json({ result: result });
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({ result: false, exception: error.message });
    }
  }

  /**
   * 내 여행 삭제
   * @param {*} req 
   * @param {*} res 
   */
  async removeMyTrip(req, res) {
    try {
      const user = req.session.user;
      const { id } = req.body;
      if (user != null && id != null) {
        const result = await userService.removeMyTrip(id, user.id); // 서비스에서 데이터를 가져옴
        res.status(200).json({ result: result });
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({ result: false, exception: error.message });
    }
  }

  /**
   * 내 여행 도시 삭제
   * @param {*} req 
   * @param {*} res 
   */
  async removeMyTripPlace(req, res) {
    try {
      const user = req.session.user;
      const { id } = req.body;
      if (user != null && id != null) {
        const result = await userService.removeMyTripPlace(id); // 서비스에서 데이터를 가져옴
        res.status(200).json({ result: result });
      } else {
        throw new Error('로그인 정보가 존재하지 않습니다.');
      }
    } catch (error) {
      res.status(500).json({ result: false, exception: error.message });
    }
  }
}

module.exports = new UserController();
