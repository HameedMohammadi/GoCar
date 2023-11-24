const express = require('express');
const router = express.Router();
const userController = require('../controller/userController');

// Create a new user
router.post('/user', userController.createUser);
// update the user
router.put('/user/:id' , userController.updateUser);
// delete the user
router.delete('/user/:id' , userController.deleteUser);
//get all user
router.get('/user' , userController.getAllusers);
// get user by id
router.get('/user/:id' , userController.getUserById);
// login the user
router.post('/login' , userController.login);
// append the rentalHistory list
router.post('/user/:id/renthistory' , userController.rentHistory);

module.exports = router