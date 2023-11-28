const Car = require('../models/car');
const booking = require('../models/BookCar');
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

async function updateAvailabilty(req,res) {
  try{
    const{id} = req.params;
    const updated = await Car.findByIdAndUpdate(id,req.body, {new : true});
    res.json(updated);
  }
  catch(err) {
    res.status(500).json({error : err.message});
  }
}

  
async function BookCar(req,res) {
  try {
    const newbooking = await booking.create(req.body); 
    res.status(201).json(newbooking); 
  }
  catch (error) {
    res.status(500).json({error : error})
  }
}  

async function getcarById(req, res) {
  const{ id } = req.params;
  try {
    const cars = await Car.findById(id);
    
    if (!cars) {
      return res.status(404).json({ error: 'Car not found' });
    }

    res.json(cars);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
}

  
module.exports = {
    createCar,
    getAllcars,
    updateAvailabilty,
    BookCar,
    getcarById
}