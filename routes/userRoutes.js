// routes/userRoutes.js
const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// API 라우팅
router.post('/signup', (req, res) => userController.getSignUp(req, res));
router.post('/login', (req, res) => userController.getLogin(req, res));
router.post('/logout', (req, res) => userController.getLogout(req, res));
router.post('/reviewList', (req, res) => userController.getReviews(req, res));
router.post('/reviewAdd', (req, res) => userController.addReview(req, res));
router.post('/reviewRemove', (req, res) => userController.removeReview(req, res));
router.post('/favorite', (req, res) => userController.getFavorite(req, res));

module.exports = router;