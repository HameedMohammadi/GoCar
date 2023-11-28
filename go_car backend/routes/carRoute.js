const express = require('express');
const router = express.Router();
const carController = require('../controller/carController');

// Create a new car
router.post('/car', carController.createCar);
//get all user
router.get('/car' ,  carController.getAllcars);
// update the rent Status of the car
router.put('/car/:id', carController.updateAvailabilty);
// Book a Car
router.post('/BookCar' , carController.BookCar);
// get car by carID
router.get('/car/:id' ,  carController.getcarById);



module.exports = router