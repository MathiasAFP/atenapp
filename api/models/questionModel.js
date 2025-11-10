const db = require("../db");

async function getQuestionByAllModel(subTopic, difficulty, howMany) {
  return new Promise((resolve, reject) => {
    const query = `SELECT * FROM question WHERE subTopic = ? AND difficulty = ? LIMIT ?`;

    db.query(query, [subTopic, difficulty, howMany], (error, result) => {
      if (error) {
        return reject(error);
      }
      return resolve(result && result.length > 0 ? result : []);
    });
  });
}

async function addPoints(userId, leagueId, points) {
  //verificar quanto pontos tem se baseando na tabela userleague(userId, leagueId, points)
  //outra query pra adicionar 1 ponto a essa coluna nessa relação
}

async function getQuestionInfoModel() {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM content";
    db.query(query, (error, result) => {
      if (error) {
        return reject(error);
      }
      return resolve(result);
    })
  })
}

module.exports = { getQuestionByAllModel, getQuestionInfoModel};
