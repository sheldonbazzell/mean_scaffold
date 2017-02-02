var mongoose = require('mongoose'),
  User = mongoose.model('User');
 
function usersController() {
  this.index = function(req,res) {
     User.find({}, function(err,users) {
       if(err) { res.json(err); }
       else { res.json(users); }
     })
  }
 
  this.create = function(req,res) {
     var User = new User(req.body);
     User.save(function(err) {
       if(err) { res.json(err); }
       else { res.redirect('/users'); }
     })
  }
 
  this.show = function(req,res) {
     User.findOne({_id:req.params.id}, function(err,user) {
       if(err) { res.json(err); }
       else { res.json(user); }
     })
  }
 
  this.update = function(req,res) {
     User.update({_id:req.params.id}, req.body, function(err,user) {
       if(err) { res.json(err); }
       else { res.json(user); }
     })
  }
 
  this.destroy = function(req,res) {
     User.remove({_id:req.params.id}, function(err,user) {
       if(err) { res.json(err); }
       else { res.json(user); }
     })
  }
}
module.exports = new usersController()
var mongoose = require('mongoose'),
  User = mongoose.model('User');
 
function usersController() {
  this.index = function(req,res) {
     User.find({}, function(err,users) {
       if(err) { res.json(err); }
       else { res.json(users); }
     })
  }
 
  this.create = function(req,res) {
     var User = new User(req.body);
     User.save(function(err) {
       if(err) { res.json(err); }
       else { res.redirect('/users'); }
     })
  }
 
  this.show = function(req,res) {
     User.findOne({_id:req.params.id}, function(err,user) {
       if(err) { res.json(err); }
       else { res.json(user); }
     })
  }
 
  this.update = function(req,res) {
     User.update({_id:req.params.id}, req.body, function(err,user) {
       if(err) { res.json(err); }
       else { res.json(user); }
     })
  }
 
  this.destroy = function(req,res) {
     User.remove({_id:req.params.id}, function(err,user) {
       if(err) { res.json(err); }
       else { res.json(user); }
     })
  }
}
module.exports = new usersController()
var mongoose = require('mongoose'),
  User = mongoose.model('User');
 
function usersController() {
  this.index = function(req,res) {
     User.find({}, function(err,users) {
       if(err) { res.json(err); }
       else { res.json(users); }
     })
  }
 
  this.create = function(req,res) {
     var User = new User(req.body);
     User.save(function(err) {
       if(err) { res.json(err); }
       else { res.redirect('/users'); }
     })
  }
 
  this.show = function(req,res) {
     User.findOne({_id:req.params.id}, function(err,user) {
       if(err) { res.json(err); }
       else { res.json(user); }
     })
  }
 
  this.update = function(req,res) {
     User.update({_id:req.params.id}, req.body, function(err,user) {
       if(err) { res.json(err); }
       else { res.json(user); }
     })
  }
 
  this.destroy = function(req,res) {
     User.remove({_id:req.params.id}, function(err,user) {
       if(err) { res.json(err); }
       else { res.json(user); }
     })
  }
}
module.exports = new usersController()
var mongoose = require('mongoose'),
  User = mongoose.model('User');
 
function usersController() {
  this.index = function(req,res) {
     User.find({}, function(err,users) {
       if(err) { res.json(err); }
       else { res.json(users); }
     })
  }
 
  this.create = function(req,res) {
     var User = new User(req.body);
     User.save(function(err) {
       if(err) { res.json(err); }
       else { res.redirect('/users'); }
     })
  }
 
  this.show = function(req,res) {
     User.findOne({_id:req.params.id}, function(err,user) {
       if(err) { res.json(err); }
       else { res.json(user); }
     })
  }
 
  this.update = function(req,res) {
     User.update({_id:req.params.id}, req.body, function(err,user) {
       if(err) { res.json(err); }
       else { res.json(user); }
     })
  }
 
  this.destroy = function(req,res) {
     User.remove({_id:req.params.id}, function(err,user) {
       if(err) { res.json(err); }
       else { res.json(user); }
     })
  }
}
module.exports = new usersController()
