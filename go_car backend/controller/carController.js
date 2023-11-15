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
async function getAllcars (req,res) {
    try{
        const cards = await Car.find();
        res.json(cards);
    }
    catch (err) {
        res.status(500).json({error : err.message});
    }
}

module.exports = {
    createCar,
    getAllcars
}