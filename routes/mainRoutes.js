// routes/mainRoutes.js
const express = require('express');
const router = express.Router();
const mainController = require('../controllers/mainController');

// API 라우팅
router.post('/banners', (req, res) => mainController.getBanners(req, res));
router.post('/packages', (req, res) => mainController.getPackages(req, res));
router.post('/places', (req, res) => mainController.getPlaces(req, res));
router.post('/test', (req, res) => mainController.getTest(req, res));

module.exports = router;
