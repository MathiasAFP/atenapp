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

module.exports = { getQuestionByAllModel };
