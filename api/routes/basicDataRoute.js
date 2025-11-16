const express = require('express');
const router = express.Router();
const basicDataController = require('../controllers/basicDataController');
const jwtMiddlewareController = require('../controllers/otherControllers/jwtMiddlewareController');

// routes mounted at /basicdata

router.post('/userbasicdata', jwtMiddlewareController.jwtMiddleware, basicDataController.userBasicDataLoader);
router.post('/generalbasicdata', jwtMiddlewareController.jwtMiddleware, basicDataController.generalBasicData);

module.exports = router;