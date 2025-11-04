const express = require('express');
const router = express.Router();
const championshipController = require('../controllers/championshipController');
const jwtMiddlewareController = require('../controllers/otherControllers/jwtMiddlewareController');

// routes mounted at /championship

router.post('/getquestion', jwtMiddlewareController.jwtMiddleware, championshipController.createChampionshipController);

module.exports = router;