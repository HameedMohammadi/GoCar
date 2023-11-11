const Car = require('../models/car');
const { param } = require('../routes/carRoute');


async function createCar (req ,res) {
    try {
        const newcar = await Car.create(req.body); 
        res.status(201).json(newcar); 
    }
    catch (error) {
        res.status(500).json({error : error})
    }
}

module.exports = {
    createCar
}