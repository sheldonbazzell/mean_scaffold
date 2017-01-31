#!/bin/bash

echo -n "Enter your Project Name and press [ENTER]: "
read project_name
mkdir $project_name
cd $project_name
mkdir ./server
mkdir ./server/config
mkdir ./server/models
mkdir ./server/controllers
touch ./server.js
touch ./server/config/routes.js
touch ./server/config/mongoose.js


#  /==================================================/  #
#						mongoose.js 					 # 
#  /==================================================/  #

echo " var mongoose = require('mongoose'), " >> ./server/config/mongoose.js
echo " 	       fs = require('fs'), " >> ./server/config/mongoose.js
echo " 	     path = require('path'); " >> ./server/config/mongoose.js
echo ' mongoose.connect("mongodb://localhost/'$project_name'"); ' >> ./server/config/mongoose.js
echo " var models_path = path.join(__dirname, './../models'); " >> ./server/config/mongoose.js
echo " fs.readdirSync( models_path ).forEach( function(file) { " >> ./server/config/mongoose.js
echo "   if( file.indexOf('.js') >= 0 ) { " >> ./server/config/mongoose.js
echo "	   require( models_path + '/' + file ); " >> ./server/config/mongoose.js
echo "   } " >> ./server/config/mongoose.js
echo " }) " >> ./server/config/mongoose.js



#  /==================================================/  #
#						server.js 						 # 
#  /==================================================/  #

echo " var express = require('express'), " >> ./server.js
echo "     bp      = require('body-parser'), " >> ./server.js
echo "     path    = require('path'), " >> ./server.js
echo "     port    = process.env.PORT || 8000, " >> ./server.js
echo "     app     = express(); " >> ./server.js
echo " app.use( express.static( path.join( __dirname, 'client' ))); " >> ./server.js
echo " app.use( express.static( path.join( __dirname, 'bower_components' ))); " >> ./server.js
echo " app.use( bp.json() ); " >> ./server.js
echo " require('./server/config/mongoose.js'); " >> ./server.js
echo " require('./server/config/routes.js')(app); " >> ./server.js
echo " app.listen( port, function() { " >> ./server.js
echo "   console.log( 'server running on port ${ port }' ) " >> ./server.js
echo " }); " >> ./server.js

if [ -f ./package.json ]; then
	echo "Already installed"
else
	npm init -y
	npm install express mongoose body-parser --save
fi
if [ -f ./bower.json ]; then
	echo "Already installed"
else
	yes '' | bower init
	bower install angular angular-route --save
fi


#  /==================================================/  #
#						MODELS 							 # 
#  /==================================================/  #

declare -a models_array
function pushModel() {
	echo -n "Enter your Model Name and press [ENTER]: "
	read model_name
	models_array+=('model' $model_name)
}
pushModel

function pushAttributes() {
	echo -n "Enter Attribute NAME and press [ENTER]: "
	read attr_name
	models_array+=('a_name' $attr_name)
	echo -n "Enter Attribute TYPE and press [ENTER]: "
	read attr_type
	models_array+=('a_type' $attr_type)
	echo -n "Another Attribute? Type no to exit"
	read another_attr
	if ! [ $another_attr == 'no' ]; then
		pushAttributes
	else
		echo -n "Another Model? Type no to exit"
			read another_model
			if ! [ $another_model == 'no' ]; then
				pushModel
				pushAttributes
			fi
	fi
}
pushAttributes


for f in "${!models_array[@]}"; do
	length=${#models_array[@]}
	if [ "${models_array[$f]}" == 'model' ]; then
		currmodel="${models_array[$f+1]}"
		currmodel="${models_array[$f+1]}"
		touch ./server/models/"$currmodel".js
		echo "var mongoose = require('mongoose');" >> ./server/models/"$currmodel".js
		echo "mongoose.Promise = global.Promise;" >> ./server/models/"$currmodel".js
		echo "var Schema   = mongoose.Schema," >> ./server/models/"$currmodel".js
		echo "    "$currmodel"Schema = new Schema({" >> ./server/models/"$currmodel".js
		continue
	fi
	if [ "${models_array[$f]}" == 'a_name' ]; then
		echo "    	"${models_array[$f+1]}": {type: "${models_array[$f+3]}"}," >> ./server/models/"$currmodel".js
	fi
	if [ "${models_array[$f+1]}" == 'model' ] || [ "$f" == "$(( length-1 ))" ]; then
		echo " },{timestamps:true});" >> ./server/models/"$currmodel".js
		echo " 	  mongoose.model(""'"$currmodel"'"", "$currmodel"Schema)" >> ./server/models/"$currmodel".js
	fi
done


#  /==================================================/  #
#						CONTROLLERS 					 # 
#  /==================================================/  #

for f in "${!models_array[@]}"; do
	# printf "%s\t%s\n" "$f" "${models_array[$f]}"
	controller_name="$currmodel"'s'
	touch ./server/controllers/$controller_name.js
	length=${#models_array[@]}
	if [ "${models_array[$f]}" == 'model' ]; then
		currmodel="${models_array[$f+1]}"
		controller_name="$currmodel"'s'
		parens="()"
		touch ./server/controllers/$controller_name.js
		echo "var mongoose = require('mongoose')," >> ./server/controllers/"$controller_name".js
		echo " " $currmodel "= mongoose.model(""'"$currmodel"'"");" >> ./server/controllers/"$controller_name".js
		echo " " >> ./server/controllers/"$controller_name".js
		echo "function" $controller_name"Controller"$parens" {" >> ./server/controllers/"$controller_name".js
		echo "  this.index = function(req,res) {" >> ./server/controllers/"$controller_name".js
		echo "     "$currmodel".find({}, function(err,"$currmodel"s) {" >> ./server/controllers/"$controller_name".js
		echo "       if(err) { res.json(err); }" >> ./server/controllers/"$controller_name".js
		echo "       else { res.json("$currmodel"s); }" >> ./server/controllers/"$controller_name".js
		echo "     })" >> ./server/controllers/"$controller_name".js
		echo "  }" >> ./server/controllers/"$controller_name".js
		echo " " >> ./server/controllers/"$controller_name".js
		echo "  this.create = function(req,res) {" >> ./server/controllers/"$controller_name".js
		echo "     var "$currmodel" = new" $currmodel"(req.body);" >> ./server/controllers/"$controller_name".js
		echo "     "$currmodel".save(function(err) {" >> ./server/controllers/"$controller_name".js
		echo "       if(err) { res.json(err); }" >> ./server/controllers/"$controller_name".js
		echo "       else { res.redirect('/"$currmodel"s'); }" >> ./server/controllers/"$controller_name".js
		echo "     })" >> ./server/controllers/"$controller_name".js
		echo "  }" >> ./server/controllers/"$controller_name".js
		echo " " >> ./server/controllers/"$controller_name".js
		echo "  this.show = function(req,res) {" >> ./server/controllers/"$controller_name".js
		echo "     "$currmodel".findOne({_id:req.params.id}, function(err,"$currmodel") {" >> ./server/controllers/"$controller_name".js
		echo "       if(err) { res.json(err); }" >> ./server/controllers/"$controller_name".js
		echo "       else { res.json("$currmodel"); }" >> ./server/controllers/"$controller_name".js
		echo "     })" >> ./server/controllers/"$controller_name".js
		echo "  }" >> ./server/controllers/"$controller_name".js
		echo " " >> ./server/controllers/"$controller_name".js
		echo "  this.update = function(req,res) {" >> ./server/controllers/"$controller_name".js
		echo "     "$currmodel".update({_id:req.params.id}, req.body, function(err,"$currmodel") {" >> ./server/controllers/"$controller_name".js
		echo "       if(err) { res.json(err); }" >> ./server/controllers/"$controller_name".js
		echo "       else { res.json("$currmodel"); }" >> ./server/controllers/"$controller_name".js
		echo "     })" >> ./server/controllers/"$controller_name".js
		echo "  }" >> ./server/controllers/"$controller_name".js
		echo " " >> ./server/controllers/"$controller_name".js
		echo "  this.destroy = function(req,res) {" >> ./server/controllers/"$controller_name".js
		echo "     "$currmodel".remove({_id:req.params.id}, function(err,"$currmodel") {" >> ./server/controllers/"$controller_name".js
		echo "       if(err) { res.json(err); }" >> ./server/controllers/"$controller_name".js
		echo "       else { res.json("$currmodel"); }" >> ./server/controllers/"$controller_name".js
		echo "     })" >> ./server/controllers/"$controller_name".js
		echo "  }" >> ./server/controllers/"$controller_name".js
		echo "}" >> ./server/controllers/"$controller_name".js
		echo "module.exports = new "$controller_name"Controller"$parens"" >> ./server/controllers/"$controller_name".js
	fi
done

#  /==================================================/  #
#						ROUTES 							 # 
#  /==================================================/  #

for f in "${!models_array[@]}"; do
	currmodel="${models_array[$f+1]}"
	controller_name="$currmodel"'s'
	if [ "${models_array[$f]}" == 'model' ]; then
		echo "var "$controller_name" = require('../controllers/"$controller_name".js');" >> ./server/config/routes.js
	fi
done
echo "module.exports = function(app) {" >> ./server/config/routes.js
for f in "${!models_array[@]}"; do
	if [ "${models_array[$f]}" == 'model' ]; then
		currmodel="${models_array[$f+1]}"
		controller_name="$currmodel"'s'
		echo "  app.get('/"$controller_name"', "$controller_name".index);" >> ./server/config/routes.js
		echo "  app.post('/"$controller_name"', "$controller_name".create);" >> ./server/config/routes.js
		echo "  app.get('/"$controller_name"/:id', "$controller_name".show);" >> ./server/config/routes.js
		echo "  app.put('/"$controller_name"/:id', "$controller_name".update);" >> ./server/config/routes.js
		echo "  app.delete('/"$controller_name"/:id', "$controller_name".destroy);" >> ./server/config/routes.js
	fi
done
echo "} " >> ./server/config/routes.js

