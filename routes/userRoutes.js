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

router.post('/myTripList', (req, res) => userController.getMyTrips(req, res));
router.post('/myTripAdd', (req, res) => userController.addMyTrip(req, res));
router.post('/myTripAddPlace', (req, res) => userController.addMyTripPlace(req, res));
router.post('/myTripRemove', (req, res) => userController.removeMyTrip(req, res));
router.post('/myTripRemovePlace', (req, res) => userController.removeMyTripPlace(req, res));

module.exports = router;