const db = require("../db");

// Em questionModel.js

async function getQuestionByAllModel(subTopicName, difficultyString, howMany) {
  return new Promise((resolve, reject) => {
    // Esta query agora usa JOIN
    const query = `
      SELECT q.* FROM atena.question AS q
      JOIN atena.content AS c ON q.subtopic = c.id
      WHERE c.subtopic = ? 
      AND q.difficulty = ?
      LIMIT ?;
    `;

    // Os parâmetros agora são os nomes/strings corretos
    db.query(query, [subTopicName, difficultyString, howMany], (error, result) => {
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
