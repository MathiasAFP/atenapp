const basicDataModel = require("../models/basicDataModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

async function userBasicDataLoader(req, res) {
    const { context } = req.body;
    const { id, userType } = req.userData;

    try {
        const nameLeagueName = await basicDataModel.userBasicDataLoader(id, userType);
        return res.status(200).json({ message: nameLeagueName });
    } catch (error) {
        console.error('Erro em userBasicDataLoader:', error);
        return res.status(500).json({ message: "Erro ao obter dados do usuário." });
    }
}


module.exports = {userBasicDataLoader};