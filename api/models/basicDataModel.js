const db = require("../db");

async function championshipExists(name) {
  new Promise((resolve, reject) => {
    const query = "SELECT * FROM championship WHERE name = ?";
    db.query(query, [name], (error, result) => {
      if (error) {
        return reject;
      }
      else{
        return resolve(result);
      }
    })
  })
}

async function createChampionship(name, numberPositions, subject, topic, subTopic, code) {
  new Promise((resolve, reject) => {
    const query = "INSERT INTO championship (name, numberPositions, subject, topic, subTopic, code) VALUES (?,?,?,?,?,?)";
    db.query(query, [name, numberPositions, subject, topic, subTopic, code], (error, result) => {
      if (error) {
        return reject;
      }
      else{
        return resolve(result);
      }
    })
  })
}

module.exports = { championshipExists,
  createChampionship
};
