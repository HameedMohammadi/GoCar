const User = require('../models/user');
const jwt = require('jsonwebtoken'); 
const { param } = require('../routes/userRoute');
const nodemailer = require('nodemailer');
const crypto = require('crypto');

async function createUser (req ,res) {
    try {
        const newuser = await User.create(req.body); 
        res.status(201).json(newuser); 
    }
    catch (error) {
        res.status(500).json({error : error})
    }
}

async function updateUser (req , res) {
    try{
        const {id} = req.params;
        const updateUser = await User.findByIdAndUpdate(id,req.body,{new: true});
        res.json(updateUser);
    }
    catch (err) {
        res.status(500).json({error : err.message});
    }
}

async function deleteUser (req , res) {
    try {
        const {id} = req.params;
        await User.findByIdAndRemove(id);
        res.sendStatus(204).json({message : "Deleted Successfully"});
    }
    catch (err) {
        res.status(500).json({error : err.message});
    }
}
async function getUserById(req, res) {
    const{ id } = req.params;
    try {
      const user = await User.findById(id);
      
      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }
  
      res.json(user);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
    
async function getAllusers (req,res) {
    try{
        const users = await User.find();
        res.json(users);
    } 
    catch (err) {
        res.status(500).json({error : err.message});
    }
}


 
async function forgetpassword (req,res) {
    const { email } = req.body;
    const token = crypto.randomBytes(20).toString('hex');
    const resetLink = `https://localhost:3007/reset_password?token=${token}`;
    const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: 'ammadaslam07@gmail.com', 
            pass: '26687858Ru' 
            } 
    });
    const mailOptions = {
        from: 'ammadaslam07@gmail.com',
        to: email,
        subject: 'Password Reset',
        html: `Click <a href="${resetLink}">here</a> to reset your password. This link is valid for a limited time.`
    }
    try {
        const info = await transporter.sendMail(mailOptions);
        res.status(200).json({message : 'Password reset email sent'});
    }
    catch (error) {
        res.status(500).json({error : 'Failed to send'});
    }   
}


async function rentHistory (req,res) {
    const { id } = req.params;
    const {newbooking }  = req.body;
    try {
        const user = await User.findById(id);
        if (!user) {
            return { success: false, message: 'User not found' };
        }
        user.rentalhistory.push(newbooking); 
        await user.save(); 
        res.status(200).json({ message: 'Item added to the list successfully', updatedUser: user });

    }
    catch (error) {
        res.status(500).json({ error: error.message });
    }
}

async function login (req,res,next) {
    const {name , password} = req.body;
    try{
        const user = await User.findOne ({name});
        if (!user) return res.status(404).json({error : 'User not found'}); 
        if (user.password != password) return res.status(401).json({error : 'Invalid Credentials'});
        var token = GenerateToken(user)
        return res.status(200).json({
            message : 'Logged in successfully' ,
            userName : name ,
            userid : user.id,
            token : token
        });
    }
    catch (err) {
        res.status(500).json({error : err.message});
    }
}

function GenerateToken(user) {
    const payload = {
        id: user._id,
    };
    const token = jwt.sign(payload, "adsfasdfjkh$#asdfasdf.adsfxc");
    return token;
};



module.exports = {
    createUser,
    updateUser,
    deleteUser,
    getAllusers,
    login ,
    getUserById,
    rentHistory,
    forgetpassword
}