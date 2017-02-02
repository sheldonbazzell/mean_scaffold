var mongoose = require('mongoose'),
  USer = mongoose.model('USer');
 
function usersController() {
  this.index = function(req,res) {
     USer.find({}, function(err,users) {
       if(err) { res.json(err); }
       else { res.json(users); }
     })
  }
 
  this.create = function(req,res) {
     var USer = new USer(req.body);
     USer.save(function(err) {
       if(err) { res.json(err); }
       else { res.redirect('/users'); }
     })
  }
 
  this.show = function(req,res) {
     USer.findOne({_id:req.params.id}, function(err,user) {
       if(err) { res.json(err); }
       else { res.json(user); }
     })
  }
 
  this.update = function(req,res) {
     USer.update({_id:req.params.id}, req.body, function(err,user) {
       if(err) { res.json(err); }
       else { res.json(user); }
     })
  }
 
  this.destroy = function(req,res) {
     USer.remove({_id:req.params.id}, function(err,user) {
       if(err) { res.json(err); }
       else { res.json(user); }
     })
  }
}
module.exports = new usersController()
