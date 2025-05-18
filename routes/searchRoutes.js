// routes/searchRoutes.js
const express = require('express');
const router = express.Router();
const searchController = require('../controllers/searchController');

// API 라우팅
router.post('/filters', (req, res) => searchController.getFilters(req, res));
router.post('/results', (req, res) => searchController.getResults(req, res));
router.post('/askAI', (req, res) => searchController.getAskAI(req, res));
router.post('/moves', (req, res) => searchController.getMoves(req, res));

module.exports = router;
