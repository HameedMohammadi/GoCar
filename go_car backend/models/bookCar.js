const mongoose = require('mongoose')
const bookCarSchema = mongoose.Schema({
    car_id : String,
    bookingDays : Number,
    user_id : String
} , {timestamps:true});

module.exports = mongoose.model('BookCar' , bookCarSchema);


    
