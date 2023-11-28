const booking = require('../models/BookCar');
const { param } = require('../routes/bookingRoute');

async function getAllbookings (req,res) {
    try{
        const bookings = await booking.find();
        res.json(bookings);
    }
    catch (err) {
        res.status(500).json({error : err.message});
    }
}

async function getbookingById(req, res) {
    const{ id } = req.params;
    try {
      const bookings = await booking.findById(id);
      
      if (!bookings) {
        return res.status(404).json({ error: 'Booking not found' });
      }
  
      res.json(bookings);
    } catch (err) {
      res.status(500).json({ error: err.message });
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
  
module.exports = {
    BookCar,
    getAllbookings,
    getbookingById
}