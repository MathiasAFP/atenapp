const db = require("../db");

async function credentialModelWhichSchool(school_name) {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM school WHERE name = ?";
    db.query(query, [school_name], (error, result) => {
      if (error) {
        return reject(500);
      }
      if (result.length > 0) {
        return resolve(result[0]);
      } else {
        return reject(500);
      }
    });
  });
}

async function credentialModelTeacherSignup(name, email, password) {
  return new Promise((resolve, reject) => {
    const query = "INSERT INTO teacher name = ? AND email = ? AND password = ?";
    db.query(query, [name, email, password], (error, result) => {
      if (error) {
        return reject(500);
      }
      else {
        return resolve(200);
      }
    });
  });
}

async function credentialModelStudentSignup(name, email, password) {
  return new Promise((resolve, reject) => {
    const query = "INSERT INTO student name = ? AND email = ? AND password = ?";
    db.query(query, [name, email, password], (error, result) => {
      if (error) {
        return reject(500);
      }
      else {
        return resolve(200);
      }
    });
  });
}

async function credentialModelSearchTeacher(name) {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM teacher WHERE name = ?";
    db.query(query, [name], (error, result) => {
      if (error) {
        return reject(500);
      }
      if (result.length > 0) {
        return resolve(result[0]);
      } else {
        return reject(500);
      }
    });
  });
}

async function credentialModelSearchStudent(name) {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM student WHERE name = ?";
    db.query(query, [name], (error, result) => {
      if (error) {
        return reject(500);
      }
      if (result.length > 0) {
        return resolve(result[0]);
      } else {
        return reject(500);
      }
    });
  });
}

async function credentialModelDoSchoolTeacherRelation(school_id, teacher_id) {
  return new Promise((resolve, reject) => {
    const query = "INSERT INTO schoolteacher school_id = ? AND teacher_id = ?";
    db.query(query, [school_id, teacher_id], (error, result) => {
      if (error) {
        return reject(500);
      }
      else {
        return resolve(200);
      }
    });
  });
}

async function credentialModelDoSchoolStudentRelation(school_id, student_id) {
  return new Promise((resolve, reject) => {
    const query = "INSERT INTO schoolteacher school_id = ? AND teacher_id = ?";
    db.query(query, [school_id, student_id], (error, result) => {
      if (error) {
        return reject(500);
      }
      else {
        return resolve(200);
      }
    });
  });
}

module.exports = {credentialModelWhichSchool, credentialModelTeacherSignup, credentialModelStudentSignup, credentialModelSearchTeacher, credentialModelSearchStudent, credentialModelDoSchoolTeacherRelation, credentialModelDoSchoolStudentRelation};