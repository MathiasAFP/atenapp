// basicDataModel.js (corrigido)
const db = require("../db");

async function userBasicDataLoader(id, userType) {
  return new Promise((resolve, reject) => {
    // 1) pega o leagueId da relação userleague
    const query1 = `SELECT leagueId FROM userleague WHERE userId = ?`;
    db.query(query1, [id], (error1, result1) => {
      if (error1) return reject(error1);
      if (!result1 || result1.length === 0) {
        // usuário sem liga
        return resolve({ name: null, leagueId: null, leagueType: null });
      }
      const leagueId = result1[0].leagueId;

      // 2) pega o tipo/nome da liga usando o leagueId
      const query2 = `SELECT type FROM league WHERE id = ?`;
      db.query(query2, [leagueId], (error2, result2) => {
        if (error2) return reject(error2);
        const leagueType = (result2 && result2.length > 0) ? result2[0].type : null;

        // 3) pega o nome do usuário (ou student/teacher etc) na tabela correta
        const query3 = `SELECT name FROM \`${userType}\` WHERE id = ?`;
        db.query(query3, [id], (error3, result3) => {
          if (error3) return reject(error3);
          const name = (result3 && result3.length > 0) ? result3[0].name : null;

          // retorna um objeto organizado
          resolve({ name: name, leagueId: leagueId, leagueType: leagueType });
        });
      });
    });
  });
}

module.exports = { userBasicDataLoader };
