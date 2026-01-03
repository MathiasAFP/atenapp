const db = require("../models/lessonModel");

async function getSubjectsController(req, res) {
    const {id, userType} = req.user;
    try {
        const subjects = await db.getSubjectsModel();
        if (subjects) {
            console.log(subjects);
            return res.status(200).json({msg:subjects});
        }
    } catch (error) {
        return res.status(500).json({msg:"Erro crítico"});
    }
}

async function getTopicController(req, res) {
    const {subject} = req.body;
    try {
        const topics = await db.getTopicModel(subject);
        console.log(topics);
        return res.status(200).json({ok:true, msg:topics});
    } catch (error) {
        console.log(error);
        return res.status(500).json({ok:false,msg:"Erro crítico"});
    }
}

async function getSubTopicController(req, res) {
    const {topic} = req.body;
    try {
        const subTopics = await db.getSubTopicModel(topic);
        console.log(subTopics)
        return res.status(200).json({msg:subTopics});
    } catch (error) {
        console.log(error);
        return res.status(500).json({msg:"Erro crítico"});
    }
}

module.exports = {
    getSubjectsController,
    getTopicController,
    getSubTopicController
}