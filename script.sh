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
echo " app.listen( port, function() { " >> ./server.js
echo " console.log( 'server running on port ${ port }' ) " >> ./server.js
echo " }); "

if [ -f ./package.json ]; then
	echo "Already installed"
else
	npm init -y
	npm install express mongoose body-parser --save
fi
if [ -f ./bower.json ]; then
	echo "Already installed"
else
	bower init
	bower install angular angular-route --save
fi


#  /==================================================/  #
#						MODELS 							 # 
#  /==================================================/  #

declare -a models_array
function pushModel() {
	echo -n "Enter your Model Name and press [ENTER]: "
	read model_name
	models_array+=($model_name)
}
pushModel

function pushAttributes() {
	echo -n "Enter Attribute NAME and press [ENTER]: "
	read attr_name
	models_array+=($attr_name)
	echo -n "Enter Attribute TYPE and press [ENTER]: "
	read attr_type
	models_array+=($attr_type)
	echo -n "Another Attribute? Type no to exit"
	read another_attr
	if ! [ $another_attr == 'no' ]; then
		pushAttributes
	else
		models_array+=('0')
		echo -n "Another Model? Type no to exit"
			read another_model
			if ! [ $another_model == 'no' ]; then
				pushModel
				pushAttributes
			fi
	fi
}
pushAttributes

for f in "${models_array[@]}"; do
	echo "$f"
done

for f in "${models_array[@]}"; do
	if [ "$f" == '0' ]; then
		((index++))
	controller_name="${models_array[index]}"'s'
	touch ./server/models/"${models_array[index]}".js
	touch ./server/controllers/$controller_name.js
	echo "var mongoose = require('mongoose')," >> ./server/models/"${models_array[index]}".js
	echo "    Schema   = mongoose.Schema;" >> ./server/models/"${models_array[index]}".js
	echo "    "$model_name"Schema = new Schema({" >> ./server/models/"${models_array[index]}".js

	function setAttributes() {
		echo "    	""${models_array[index]}"": {" >> ./server/models/"${models_array[index]}".js
		echo "      		type: ""${models_array[index]}""}," >> ./server/models/"${models_array[index]}".js
		index++
	}
	if [ "${models_array[index]}" ]; then
		if ! [ "${models_array[index+1]}" == '0' ]; then
			setAttributes
		else
			index++
		fi
	fi
	echo " {timestamps:true});" >> ./server/models/"${models_array[index]}".js
	echo " 	  mongoose.model('$model_name', ""${models_array[index]}""Schema)" >> ./server/models/"${models_array[index]}".js
done


#  /==================================================/  #
#						CONTROLLERS 					 # 
#  /==================================================/  #




