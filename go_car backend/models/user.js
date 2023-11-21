const mongoose = require('mongoose')
const userSchema = mongoose.Schema({
    name : String,
    email : String,
    phonenumber : Number,
    emergencycontact : Number,
    password : String,
    cnic : Number,
    dob : String,
    rentalhistory : [String],
    license : Boolean,
} , {timestamps:true});


module.exports = mongoose.model('User' , userSchema);



