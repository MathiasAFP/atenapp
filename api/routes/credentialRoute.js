const express = require('express');
const router = express.Router();
const credentialController = require('../controllers/credentialController');

// routes mounted at /credential

router.post('/signup', credentialController.credentialControllerSignup);// POST to /signup using the controller: credentialControllerSignup
router.post('/login', credentialController.credentialControllerLogin);// POST to /login using the controller: credentialControllerLogin


module.exports = router;