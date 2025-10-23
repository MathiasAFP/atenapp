const jwt = require('jsonwebtoken');

async function jwtMiddleware(req, res, next) {
    const authHeader = req.headers.authorization; 
    
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({ message: 'Token de autenticação não fornecido ou inválido.' });
    }

    const token = authHeader.split(' ')[1]; 
    
    try {
        const tokenData = jwt.verify(token, process.env.JWT_SECRET);
        
        const { name, userType } = tokenData;

        req.userData = { name, userType }; 

        next();

    } catch (err) {
        return res.status(403).json({ message: 'Token inválido ou expirado.' });
    }
}

module.exports = { jwtMiddleware };