const mongoose = require('mongoose')
const bookCarSchema = mongoose.Schema({
    car_id : String,
    bookingDays : String,
    user_id : String,
    price : String
} , {timestamps:true});

module.exports = mongoose.model('BookCar' , bookCarSchema);


    
