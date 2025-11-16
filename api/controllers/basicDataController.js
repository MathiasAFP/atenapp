const basicDataModel = require("../models/basicDataModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

async function userBasicDataLoader(req, res) {
    const { id, userType } = req.userData;

    try {
        const nameLeagueName = await basicDataModel.userBasicDataLoader(id, userType);
        return res.status(200).json({ message: nameLeagueName });
    } catch (error) {
        console.error('Erro em userBasicDataLoader:', error);
        return res.status(500).json({ message: "Erro ao obter dados do usuário." });
    }
}

async function generalBasicData(req, res) {
    const { id, userType } = req.userData;
    try {
        if (userType == "user") {
            const generalBasicDataAnswer = await basicDataModel.userGeneralBasicDataModel(id);
            return res.status(200).json({message:generalBasicDataAnswer});
        }
        else if (userType == "student") {
            const generalBasicDataAnswer = await basicDataModel.studentGeneralBasicDataModel(id);
            return res.status(200).json({message:generalBasicDataAnswer});
        }
        else if (userType == "teacher") {
            const generalBasicDataAnswer = await basicDataModel.teacherGeneralBasicDataModel(id);
            return res.status(200).json({message:generalBasicDataAnswer});
        }
        else {
            const generalBasicDataAnswer = await basicDataModel.schoolGeneralBasicDataModel(id);
            return res.status(200).json({message:generalBasicDataAnswer});
        }

    } catch (error) {
        res.status(500).json({message:"Erro ao buscar dados do usuário"})
    }
}

module.exports = {userBasicDataLoader, generalBasicData};