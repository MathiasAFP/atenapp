const championshipModel = require("../models/championshipModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

async function createChampionshipController(req, res) {
    const {name, numberPositions, subject, topic, subTopic, code} = req.body;
    try {
        
    } catch (error) {
        res.status(500).json({message:"Erro ao criar campeonato"});
    }
    
}

module.exports = {createChampionshipController};