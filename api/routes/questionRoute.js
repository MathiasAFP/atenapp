const express = require('express');
const router = express.Router();
const questionController = require('../controllers/questionController');
const jwtMiddlewareController = require('../controllers/otherControllers/jwtMiddlewareController');

router.post('/getquestion', jwtMiddlewareController.jwtMiddleware, questionController.getQuestionController);
router.post('/getquestioninfo', jwtMiddlewareController.jwtMiddleware, questionController.getQuestionInfoController);

module.exports = router;