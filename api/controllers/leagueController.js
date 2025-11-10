const questionModel = require("../models/questionModel");
const basicDataModel = require("../models/basicDataModel");
const leagueModel = require("../models/leagueModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

async function leagueUpgrade(req, res) {
    const {userId, userType} = req.userData;
    const leagues = ["Iron", "Bronze", "Silver", "Gold"];
    try {
        const userLeague = await questionModel.verifyUserLeague(userId);
        const nextLeague = leagues.indexOf(userLeague) + 1;
        if (nextLeague >= leagues.length) {
            return res.status(500).json({message:"Você está na maior liga possível!"})
        }
        const leagueId = await leagueModel.existLeagues(nextLeague);
            if (!leagueId) {
                await leagueModel.createNewLeague(nextLeague);
                const newLeagueId = await leagueModel.existLeagues(nextLeague);
                await leagueModel.addUserLeague(userId, newLeagueId);
            }
            else{
                await leagueModel.addUserLeague(userId, leagueId);
            }
    } catch (error) {
        
    }
    
}

async function getCompetitorsLeague(req, res) {
  const { id, userType } = req.userData;

  try {
    const userLeague = await basicDataModel.userBasicDataLoader(id, userType);

    const leagueId = userLeague.leagueId;


    const competitors = await leagueModel.getCompetitorsLeague(leagueId);
    return res.status(200).json({ message: competitors });
  } catch (error) {
    console.error("getCompetitorsLeague error:", error);
    return res.status(500).json({ message: "Erro ao buscar competidores" });
  }
}


module.exports = {leagueUpgrade, getCompetitorsLeague}