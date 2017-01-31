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


echo ./server.js
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

for ((index=0; index <= ${#models_array[@]}; index++)); do
	controller_name="${#models_array[@]}"'s'
	touch ./server/models/"${#models_array[@]}".js
	touch ./server/controllers/$controller_name.js
	echo "var mongoose = require('mongoose')," >> ./server/models/"${#models_array[@]}".js
	echo "    Schema   = mongoose.Schema;" >> ./server/models/"${#models_array[@]}".js
	echo "    "$model_name"Schema = new Schema({" >> ./server/models/"${#models_array[index]}".js

	function setAttributes() {
		echo "    	""${#models_array[index]}"": {" >> ./server/models/"${#models_array[index]}".js
		echo "      		type: ""${#models_array[index]}""}," >> ./server/models/"${#models_array[index]}".js
		index++
	}
	if [ "${models_array[index]}" ]; then
		if ! [ "${#models_array[index]}" == '0' ]; then
			setAttributes
		else
			continue
		fi
	fi
	echo " {timestamps:true});" >> ./server/models/"${#models_array[index]}".js
	echo " 	  mongoose.model('$model_name', ""${#models_array[index]}""Schema)" >> ./server/models/"${#models_array[index]}".js
done