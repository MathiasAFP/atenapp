const db = require("../config");

async function getSubjectsModel() {
    return new Promise((resolve, reject) => {
        const query1 = "SELECT name FROM subject";
        db.query(query1, [], (error1, result1) => {
            if (error1) {
                return reject(false);
            }
            return resolve(result1);
        })
    })
}

async function getTopicModel(subject){
    return new Promise((resolve, reject) => {
        const queryOne = "SELECT id FROM subject WHERE name = ?";
        const queryTwo = "SELECT * FROM topic WHERE subject_id = ?";
        db.query(queryOne,[subject],(errorOne, resultOne) => {
            if (errorOne) {
                return reject(false);
            }
            db.query(queryTwo,[resultOne[0].id],(errorTwo, resultTwo) => {
                if (errorTwo) {
                    return reject(false);
                }
                return resolve(resultTwo);
            })
        })
    })
}

async function getSubTopicModel(topic){
    return new Promise((resolve, reject) => {
        const queryOne = "SELECT id FROM topic WHERE name = ?";
        const queryTwo = "SELECT * FROM subtopic WHERE topic_id = ?";
        db.query(queryOne,[topic],(errorOne, resultOne) => {
            if (errorOne) {
                return reject(false);
            }
            db.query(queryTwo,[resultOne[0].id],(errorTwo, resultTwo) => {
                if (errorTwo) {
                    return reject(false);
                }
                return resolve(resultTwo);
            })
        })
    })
}

module.exports = {
    getSubjectsModel,
    getTopicModel,
    getSubTopicModel
}