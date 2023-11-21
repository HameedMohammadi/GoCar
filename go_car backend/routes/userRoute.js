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
// login the user
router.post('/login' , userController.login)
module.exports = router