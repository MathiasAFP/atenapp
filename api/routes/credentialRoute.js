const express = require('express');
const router = express.Router();
const credentialController = require('../controllers/credentialController');

router.post('/signup', credentialController.SignUpController);
router.post('/login', credentialController.LoginController);


module.exports = router;