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
async function updateAvailabilty(req, res) {  
    try {
      const { id } = req.params;
      const { avail } = req.body;
  
      const car = await Car.findByIdAndUpdate(
        id,
        { avail: avail }, // Specify the field and its new value
        { new: true }
      );
  
      if (!car) {
        return res.status(404).json({ error: 'Car not found' });
      }
  
      res.json({ message: 'Car availability updated successfully', car });
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
  
  
  
module.exports = {
    createCar,
    getAllcars,
    updateAvailabilty
}