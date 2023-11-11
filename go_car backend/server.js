const express = require('express')
const app = express();
const cors = require('cors'); 
require('./utils/db')
const bodyparser = require('body-parser')
const carRouter = require('./routes/carRoute');
const PORT = 3007;
//    MiddleWares
app.use(cors()); 
app.use(bodyparser.json());
app.use('/api' , carRouter);

app.listen(PORT ,() => {
    console.log("Server is running on the port" , PORT);
})

