const express = require('express');
const router = express.Router();
const bookingController = require('../controller/bookingController');

//get all user
router.get('/bookCar' ,  bookingController.getAllbookings);
router.get('/bookCar/:id' ,  bookingController.getbookingById);


module.exports = router