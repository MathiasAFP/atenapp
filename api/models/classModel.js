const db = require("../db");

async function createClass(name, teachercode, studentcode, schoolcode) {
    return new Promise((resolve, reject) => {
        const query = "INSERT INTO class (name, teachercode, studentcode, schoolcode) VALUES (?,?,?,?)";
        db.query(query, [name, teachercode, studentcode, schoolcode], (error, result) => {
        if (error) {
            console.error("MySQL error:", error);
            return reject(error);
        }
        else {
            return resolve(result);
        }
        })
    })
}

async function enterClass(name, code, userId) {
    return new Promise((resolve, reject) => {
        const query1 = "SELECT * FROM class WHERE name = ?";
        
        db.query(query1, [name], (error1, result1) => {
            if (error1) {
                return reject(error1);
            }
            
            if (result1.length === 0) {
                return reject(new Error("Turma não encontrada"));
            }

            const turma = result1[0]; 
            const classId = turma.id; 

            const queryTeacher = "INSERT INTO teacherclass (teacher_id, class_id) VALUES (?,?)";
            const queryStudent = "INSERT INTO studentclass (student_id, class_id) VALUES (?,?)";

            if (code == turma.teachercode) {
                db.query(queryTeacher, [userId, classId], (error3, result3) => {
                    if (error3) return reject(error3);
                    return resolve(result3);
                });
            } 
            else if (code == turma.studentcode) {
                db.query(queryStudent, [userId, classId], (error4, result4) => {
                    if (error4) return reject(error4);
                    return resolve(result4);
                });
            } 
            else {
                return reject(new Error("Código de acesso inválido"));
            }
        });
    });
}

async function getSchoolClass(userId, userType) {
    return new Promise((resolve, reject) => {
        if (userType == "student") {
            const query = "SELECT classid FROM studentclass WHERE studentid = ?";
            const classesId = db.query(query, [userId], (error, result) => {
                if (error) {
                    return reject(error);
                }
            })
            const query2 = "SELECT name FROM class WHERE id = ?";
            db.query(query2, [classesId], (error, result) => {
                if (error) {
                    return reject(error);
                } else {
                    return resolve(result);
                }
            })
        }

        else if (userType == "teacher") {
            const query = "SELECT classid FROM teacherclass WHERE teacherid = ?";
            const classesId = db.query(query, [userId], (error, result) => {
                if (error) {
                    return reject(error);
                }
            })
            const query2 = "SELECT name FROM class WHERE id = ?";
            db.query(query2, [classesId], (error, result) => {
                if (error) {
                    return reject(error);
                } else {
                    return resolve(result);
                }
            })
        }

        else if (userType == "school"){
            const query = "SELECT name FROM class WHERE schoolcode = ?";
            const classesId = db.query(query, [userId], (error, result) => {
                if (error) {
                    return reject(error);
                }
                else{
                    return resolve(result);
                }
            })
        }

        else{
            return reject(error);
        }
    })
}

module.exports = {
    createClass,
    enterClass,
    getSchoolClass
}