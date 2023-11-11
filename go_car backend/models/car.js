const mongoose = require('mongoose')
const carSchema = mongoose.Schema({
    model : String,
    company : String,
    number : String,
    carType : String,
    current_location : String,
    year : Number,
    color : String,
    price : Number,
    imageURl : String,
    isRotated : Boolean,
    carRating : Number,
    carpower : Number,
    people : String,
    bags : String,
} , {timestamps:true});

module.exports = mongoose.model('Car' , carSchema);



