const express = require('express');
const router = express.Router();
const carController = require('../controller/carController');

// Create a new car
router.post('/car', carController.createCar);
//get all user
router.get('/car' ,  carController.getAllcars);

module.exports = router