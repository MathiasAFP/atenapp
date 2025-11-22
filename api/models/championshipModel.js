const db = require("../db");

async function createChampionshipModel(name, code, id, userType) {
  return new Promise((resolve, reject) => {

    if (userType === "school") {

      const query1 = `
        INSERT INTO championship (name, code, teacherid, schoolid)
        VALUES (?, ?, ?, ?)
      `;

      db.query(query1, [name, code, 0, id], (error1, result1) => {
        if (error1) {
          return reject(error1);
        }
        return resolve(result1);
      });

    } 
    
    else {

      const query2 = `
        SELECT school_id FROM schoolteacher WHERE teacher_id = ?
      `;

      db.query(query2, [id], (error2, result2) => {
        if (error2) return reject(error2);

        if (!result2 || result2.length === 0) {
          return reject("Professor não vinculado a nenhuma escola");
        }

        const schoolId = result2[0].school_id;

        const query3 = `
          INSERT INTO championship (name, code, teacherid, schoolid)
          VALUES (?, ?, ?, ?)
        `;

        db.query(query3, [name, code, id, schoolId], (error3, result3) => {
          if (error3) return reject(error3);
          return resolve(result3);
        });
      });
    }
  });
}

async function enterChampionshipModel(name, code, id) {
  return new Promise((resolve, reject) => {
    const query1 = "SELECT * FROM championship WHERE name = ?";
    db.query(query1, [name], (error1, result1) => {
      if (error1) {
        return reject(error1);
      } else {
        if (code == result1.code) {
          const query2 = "INSERT INTO studentchampionship (studentid, championshipid) VALUES (?,?)";
          db.query(query2, [id, result1.id], (error2, result2) => {
            if (error2) {
              return reject(error2);
            } else {
              return resolve(result2);
            }
          })
        } else {
          return reject("Os códigos não batem")
        }
      }
    })
  })
}

async function getStudentChampionshipsModel(id, userType) {
  return new Promise((resolve, reject) => {
    if (userType == "student") {
      const query1 = "SELECT championshipid FROM studentchampionship";
      db.query(query1, [id], (error1, result1) => {
        if (error1) {
          return reject(error1);
        } else {
          const query2 = "SELECT * FROM championship WHERE id = ?";
          db.query(query2, [result1], (error2, result2) => {
            if (error2) {
              return reject(error2);
            } else {
              return resolve(result2);
            }
          })
        }
      })
    } else if (userType == "teacher") {
      const query3 = "SELECT * FROM championship WHERE teacherid = ?";
      db.query(query3, [id], (error3, result3) => {
        if (error3) {
          return reject(error3);
        } else {
          return resolve(result3);
        }
      })
    }
    else{
      const query4 = "SELECT * FROM championship WHERE schoolid = ?";
      db.query(query4, [id], (error4, result4) => {
        if (error4) {
          return reject(error4);
        } else {
          return resolve(result4);
        }
      })
    }
  })
}

module.exports = {
  createChampionshipModel,
  enterChampionshipModel,
  getStudentChampionshipsModel
};
