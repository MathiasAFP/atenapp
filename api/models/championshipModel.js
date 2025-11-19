const db = require("../db");

async function createChampionshipModel(name, participantcode, admcode, id, userType) {
  let championshipId = "";
  new Promise((resolve, reject) => {
    const query1 = "INSERT INTO championship (name, participantcode, admcode) VALUES (?,?,?)";
    db.query(query1, [name, participantcode, admcode], (error1, result1) => {
      if (error1) {
        return reject(error1);
      }

      else if(result1){
        const query2 = "SELECT id FROM championship WHERE name = ?";
        db.query(query2, [id], (error2, result2) => {
          if (error2) {
            return reject(error2)
          }
          else{
            championshipId = result2
          }
        })
      }

      else if (userType == "school") {
        const query3 = "INSERT INTO schoolchampionship (schoolid, championshipid) VALUES (?, ?)";
        db.query(query3, [id, championshipId], (error3, result3)=>{
          if (error3) {
            return reject(error3);
          } else {
            return resolve(result3);
          }
        })
      }

      else{
        const query4 = "INSERT INTO teacherchampionship (teacherid, championshipid) VALUES (?, ?)";
        db.query(query4, [id, championshipId], (error4, result4)=>{
          if (error4) {
            return reject(error4);
          } else {
            return resolve(result4);
          }})
      }
    })
  })
}

async function searchChampionshipModel(params) {
  new Promise((resolve, reject) => {
    
  })
}

async function enterChampionshipModel(params) {
  new Promise((resolve, reject) => {
    
  })
}

async function createChampionshipEventModel(params) {
  
}

async function excludeChampionshipModel(championshipName, id, userType) {
  new Promise((resolve, reject) => {
    
    const query1 = "SELECT id FROM school WHERE name = ?";
    const championshipId = db.query(query1, [championshipName], (error1, result1) => {
      if (error1) {
        return reject(error1);
      }
    })

    if (userType == "school") {
      const query2 = "DELETE FROM schoolchampionship WHERE (schoolid, championshipid) VALUES (?, ?)";
      db.query(query2, [id, championshipId], (error2, result2) => {
        if (error2) {
          return reject(error2);
        }
      const query3 = "DELETE FROM championship WHERE id = ?";
      db.query(query3, [championshipId], (error3, result3) => {
        if (error3) {
          return reject(error3);
        }
        else{
          return resolve(result3);
        }
      })
      })
    }

    else{
      const query4 = "DELETE FROM teacherchampionship WHERE (teacherid, championshipid) VALUES (?, ?)";
      db.query(query4, [id, championshipId], (error4, result4) => {
        if (error4) {
          return reject(error4);
        }
      const query5 = "DELETE FROM championship WHERE id = ?";
      db.query(query5, [championshipId], (error5, result5) => {
        if (error5) {
          return reject(error5);
        }
        else{
          return resolve(result5);
        }
      })
      })
    }
  })
}

module.exports = {
  createChampionshipModel,
  searchChampionshipModel,
  enterChampionshipModel,
  createChampionshipEventModel,
  excludeChampionshipModel
};
