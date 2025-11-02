const championshipModel = require("../models/championshipModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

async function createChampionshipController(req, res) {
    const {name, numberPositions, subject, topic, subTopic, code} = req.body;
    try {
        if (await championshipModel.championshipExists(name)) {
            res.status(500).json({message:"Esse campeonato já existe e está em andamento, tente outro nome"});
        }
        else{
            if(await championshipModel.createChampionship(name, numberPositions, subject, topic, subTopic, code)){
                res.status(200).json({message:"Campeonato criado com sucesso"});
            }
        }
    } catch (error) {
        res.status(500).json({message:"Erro ao criar campeonato"});
    }
    
}

module.exports = {createChampionshipController};