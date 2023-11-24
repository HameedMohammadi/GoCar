const mongoose = require('mongoose')
const userSchema = mongoose.Schema({
    name : String,
    email : String,
    phonenumber : String,
    emergencycontact : String,
    password : String,
    cnic : String,
    dob : String,
    rentalhistory : [String],
    license : Boolean,
} , {timestamps:true});


module.exports = mongoose.model('User' , userSchema);



