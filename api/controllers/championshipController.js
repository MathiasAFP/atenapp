const championshipModel = require("../models/championshipModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();


async function createChampionshipController(req, res) {
    const { id, userType } = req.userData;
    const { name, participantcode, admcode } = req.body;
    try {
        if(await championshipModel.createChampionshipModel(name, participantcode, admcode, id, userType)){
            res.status(200).json({message:"Campeonato criado com sucesso"});
        }
        else{
            res.status(500).json({message:"Erro ao criar campeonato"});
        }
    } catch (error) {
        res.status(500).json({message:"Erro crítico!"});
    }
}

async function excludeChampionshipController(req, res) {
    const { id, userType } = req.userData;
    const { championshipName } = req.body;
    try {
        if (await championshipModel.excludeChampionshipModel(championshipName, id, userType)) {
            return res.status(200).json({message:"Campeonato excluído"});
        }
        else{
            return res.status(500).json({message:"Falha ao excluir campeonato"});
        } 
    } catch (error) {
        return res.status(500).json({message:"Erro crítico"});
    }
}

async function searchChampionshipController(req, res) {
    const { id, userType } = req.userData;
    const {name} = req.body;
    
}

async function enterChampionshipController(req, res) {
    const { id, userType } = req.userData;
    const {name, code} = req.body;
}

async function createChampionshipEventController(req, res) {
    const { id, userType } = req.userData;
    
}

async function getChampionships(req, res) {
    const { id, userType } = req.userData;

}

module.exports = {
    createChampionshipController,
    searchChampionshipController,
    enterChampionshipController,
    createChampionshipEventController,
    getChampionships,
    excludeChampionshipController
};