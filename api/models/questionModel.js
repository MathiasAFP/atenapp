const db = require("../db");

async function getQuestionByAllModel(subject, topic, subTopic, difficulty, howMany) {
  return new Promise((resolve, reject) => {
    const query = `
      SELECT * 
      FROM question 
      WHERE subject = ? 
        AND topic = ? 
        AND subTopic = ? 
        AND difficulty = ?
      LIMIT ?
    `;

    db.query(query, [subject, topic, subTopic, difficulty, howMany], (error, result) => {
      if (error) {
        return reject(error);
      }
      return resolve(result && result.length > 0 ? result : []);
    });
  });
}

async function verifyUserLeague(userId) {
  
}

async function addStandardLeague(id) {
  //usar isso aqui dentro de credentials pra quando fizer o signup já ser adicionado na liga de ferro
}

async function existLeagues(league) {
  //verificar se tem ligas disponíveis daquele tipo, se não tem retorna e executa o createNewLeague, se tem, insertUserNewLeague
}

async function createNewLeague(league) {
  
}

async function insertUserNewLeague(id, nextLeague) {
  
}
/*
CREATE TABLE userChampionship (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    championship_id INT NOT NULL,
    points INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (championship_id) REFERENCES championships(id)
);
*/



module.exports = { getQuestionByAllModel, verifyUserLeague };
