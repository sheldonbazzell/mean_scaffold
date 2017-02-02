var mongoose = require('mongoose');
mongoose.Promise = global.Promise;
var Schema   = mongoose.Schema,
    userSchema = new Schema({
    	name: {type: String},
 },{timestamps:true});
 	  mongoose.model('USer', userSchema)
