const express = require('express');
const router = express.Router();
const leagueController = require('../controllers/leagueController');
const jwtMiddleware = require('../controllers/otherControllers/jwtMiddlewareController');


// routes mounted at /league

router.post('/leagueupgrade', jwtMiddleware.jwtMiddleware, leagueController.leagueUpgrade);
router.post('/getcompetitorsleague', jwtMiddleware.jwtMiddleware, leagueController.getCompetitorsLeague);


module.exports = router;