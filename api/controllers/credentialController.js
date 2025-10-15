const credentialModel = require("../models/credentialModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

async function SignUpController(req, res) {
    const {name, email, password, cod} = req.body;
    
    try{
      const IsSchool = await credentialModel.IsSchool(cod)
      const IsTeacher = await credentialModel.IsTeacher(name, cod)

      if (IsSchool == 200) {
        
      }
      if (IsTeacher == 200) {
        
      }
        
    }
    catch{
        res.status(500).json({message: "UserSignUpControllerError"});
    }
    
};

async function LoginController(req, res) {
  const { name, email, password, cod } = req.body;
  try {
    const user = await credentialModel.UserLoginModel(name, email);
    const match = await bcrypt.compare(password, user.password);
    if (match) {
      const token = jwt.sign({'name':name, 'email':email}, process.env.JWT_SECRET, {expiresIn:'1h'});

      res.status(200).json({ token:token });
    } else {
      res.status(500).json({ message: "UserLoginControllerError" });
    }
  } catch (err) {
    res.status(500).json({ message: "UserLoginControllerError" });
  }
}


module.exports = {SignUpController, LoginController};