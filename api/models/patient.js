const mongoose = require('mongoose');

const patientSchema = new mongoose.Schema({
  fullname: String,
  gender: String,
  phone: String,
  email: String,
  nic: String,
  address: String,
  username: String,
  password: String,


  // Add fields for General Patient Information
  generalInfo: {
    gender: {type:String},
    birthDate: { type: String }, // Date of birth (string or Date object)
    height: { type: Number }, // Height in cm
    weight: { type: Number }, // Weight in kg
    reasonForVisit: { type: String }, // Reason for visit
  },
});



module.exports = mongoose.model('Patient', patientSchema);