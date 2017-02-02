#!/bin/bash

# printf "%s\t%s\n" "$f" "${models_array[$f]}"

#   /==================================================/  #
# 			    	set up file structure      			  #
#   /==================================================/  #

echo "  "
echo " Welcome to mean_scaffold "
echo "  "
echo " READY "
echo "  "
echo "  "
echo "Enter your Project Name and press [ENTER]: "
read project_name
mkdir $project_name
cd $project_name
mkdir ./client
mkdir ./client/assets
mkdir ./client/assets/partials
mkdir ./client/assets/js
touch ./client/index.html
touch ./client/app.js
touch ./client/assets/js/indexController.js
# touch ./client/assets/js/editController.js
touch ./client/assets/js/showController.js
touch ./client/assets/partials/index.html
<<<<<<< HEAD
touch ./client/assets/partials/show.html
# touch ./client/assets/partials/edit.html
# touch ./client/assets/partials/new.html
=======
>>>>>>> 85f248375d84ef3183c2829d097a803804edbefe
mkdir ./server
mkdir ./server/config
mkdir ./server/models
mkdir ./server/controllers
touch ./server.js
touch ./server/config/routes.js
touch ./server/config/mongoose.js

#   /==================================================/  #
#   /==================================================/  #
# 				    	SERVER SIDE         			  #
#   /==================================================/  #
#   /==================================================/  #

#  /==================================================/  #
#			    	      CONFIG 						 #
#  /==================================================/  #

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
	echo "  "
else
	npm init -y
	npm install express mongoose body-parser --save
fi
if [ -f ./bower.json ]; then
	echo "Already installed"
	echo "  "
else
	yes '' | bower init
	bower install angular angular-route --save
fi

#  /==================================================/  #
#			   		 	  MODELS						 #
#  /==================================================/  #

#  /==================================================/  #
#			     	  declare models					 #
#  /==================================================/  #

declare -a models_array
function pushModel() {
	echo "            ___        ___    __ __ __ __          _          ___       __                  "
	echo "           |   \      /   |  |  __ __ ___|        / \        |   \     |  |                 "
	echo "           | |\ \    / /| |  | |                 / | \       |    \    |  |                 "
	echo "           | | \ \  / / | |  | |__ __ __        /  |  \      |     \   |  |                 "
	echo "           | |  \ \/ /  | |  |  __ __ __|      /  ___  \     |  |\  \  |  |                 "
	echo "           | |   \__/   | |  | |              /  /   \  \    |  | \  \_|  |                 "
	echo "           | |          | |  | |__ __ ___    /  /     \  \   |  |  \      |                 "
	echo "           |_|          |_|  |__ __ __ __|  /__/       \__\  |__|   \_____|                 "
	echo "  																	                      "
	echo "                                                                                            "
	echo "  __ __ __     __ __ __                   __ ___     __ ___     __ __     _        ___      "
	echo " |  _____  |  |  _____  |       /\       |  ____|   |  ____|   |     |   | |      |    \    "
	echo " | |     |_|  | |     |_|      /  \      | |        | |        |  |  |   | |      |  |  |   "
	echo " | |_______   | |             /    \     | |___     | |___     |  |  |   | |      |  |  |   "
	echo " |_______  |  | |      _     /  /\  \    |  ___|    |  ___|    |  |  |   | |      |  |  |   "
	echo "  _______| |  | |_____| |   /  /  \  \   | |        | |        |  |  |   | |___   |  |  |   "
	echo " |__ __ __ |  |__ __ __ |  /__/    \__\  |_|        |_|        |__ __|   |__ __|  |__ _/    "
	echo "  														                                  "
	echo "  														                                  "
	echo "Enter your Model Name and press [ENTER]: "
	read model_name
	models_array+=('model' $model_name)
}
pushModel

function pushAttributes() {

	echo "  "
	echo "Enter Attribute NAME and press [ENTER]: "
	read attr_name
	models_array+=('a_name' $attr_name)
	echo "  "
	echo "Enter Attribute TYPE and press [ENTER]: "
	read attr_type
	if [ $attr_type == 'String' ]; then
		echo "  "
		echo "Do you want this attribute to be a text field? (yes/no)"
		read str_type
		if [ $str_type == 'yes' ]; then
			text_attr='Text'
			models_array+=('a_type' $text_attr)
		else
			models_array+=('a_type' $attr_type)
		fi
	fi
	echo "  "
	echo "Another Attribute? (yes/no)"
	read another_attr
	if ! [ $another_attr == 'no' ]; then
		pushAttributes
	else
		echo "  "
		echo "Another Model? (yes/no)"
			read another_model
			if ! [ $another_model == 'no' ]; then
				pushModel
				pushAttributes
			else
				echo "  "
				echo "  "
				echo "  "
				echo "  "
				echo "  run your server.js "
				echo "  "
				echo "  "
				echo "  "
				echo "   p.s. cd into your project first "
				echo "  "
				echo "  "
				echo "  "
				echo "  "
			fi
	fi
}
pushAttributes

#  /==================================================/  #
#			   	    	set models						 #
#  /==================================================/  #
for g in "${!models_array[@]}"; do
	if [ "${models_array[$g]}" = 'Text' ]; then
		models_array[$g]="String"
	fi
done
for f in "${!models_array[@]}"; do
	length=${#models_array[@]}
	if [ "${models_array[$f]}" == 'model' ]; then
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

#   /==================================================/  #
# 				        CONTROLLERS         			  #
#   /==================================================/  #
echo ""
echo ""
echo ""

for f in "${!models_array[@]}"; do

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

# #  /==================================================/  #
# #					    	ROUTES 						   #
# #  /==================================================/  #

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

#  /==================================================/  #
#				   index.html  (main)    				 #
#  /==================================================/  #

echo "<!DOCTYPE html>" >> ./client/index.html
echo "<html ng-app='app'>" >> ./client/index.html
echo "<head>" >> ./client/index.html
echo "  <title>"$project_name"</title>" >> ./client/index.html
echo "  <script src='angular/angular.js'></script>" >> ./client/index.html
echo "  <script src='angular-route/angular-route.js'></script>" >> ./client/index.html
echo "  <script src='app.js'></script>" >> ./client/index.html
for f in "${!models_array[@]}"; do
	if [ "${models_array[$f]}" == 'model' ]; then
		currmodel=${models_array[$f+1]}"sFactory"
		echo "  <script src=""'assets/js/"$currmodel".js'""></script>" >> ./client/index.html
	fi
done
echo "  <script src='assets/js/indexController.js'></script>" >> ./client/index.html
echo "  <script src='assets/js/editController.js'></script>" >> ./client/index.html
echo "  <script src='assets/js/showController.js'></script>" >> ./client/index.html
echo "</head>" >> ./client/index.html
echo "<body>" >> ./client/index.html
echo "  <div ng-view></div>" >> ./client/index.html
echo "</body>" >> ./client/index.html
echo "</html>" >> ./client/index.html

#  /==================================================/  #
#				           app.js  	    				 #
#  /==================================================/  #

route='$routeProvider'
echo "var app = angular.module('app', ['ngRoute'])" >> ./client/app.js
echo "app.config(function("$route") {" >> ./client/app.js
echo "  "$route"" >> ./client/app.js
echo "    .when('/', {" >> ./client/app.js
echo "      templateUrl: 'assets/partials/index.html'," >> ./client/app.js
echo "      controller:  'indexController'" >> ./client/app.js
echo "    }) " >> ./client/app.js
for f in "${!models_array[@]}"; do
	currmodel=${models_array[$f+1]}
	if [ "${models_array[$f]}" == 'model' ]; then
		echo "    .when('/new/"$currmodel"', {" >> ./client/app.js
		echo "      templateUrl: 'assets/partials/new"$currmodel".html'," >> ./client/app.js
		echo "      controller:  'new"$currmodel"Controller'" >> ./client/app.js
		echo "    }) " >> ./client/app.js
	fi
done
for f in "${!models_array[@]}"; do
	currmodel=${models_array[$f+1]}
	if [ "${models_array[$f]}" == 'model' ]; then
		echo "    .when('/"$currmodel"/:id', {" >> ./client/app.js
		echo "      templateUrl: 'assets/partials/show"$currmodel".html'," >> ./client/app.js
		echo "      controller:  'show"$currmodel"Controller'" >> ./client/app.js
		echo "    }) " >> ./client/app.js
	fi
done
for f in "${!models_array[@]}"; do
	currmodel=${models_array[$f+1]}
	if [ "${models_array[$f]}" == 'model' ]; then
		echo "    .when('/edit/"$currmodel"/:id', {" >> ./client/app.js
		echo "      templateUrl: 'assets/partials/edit"$currmodel".html'," >> ./client/app.js
		echo "      controller:  'edit"$currmodel"Controller'" >> ./client/app.js
		echo "    }) " >> ./client/app.js
	fi
done
echo "     .otherwise('/');" >> ./client/app.js
echo " });" >> ./client/app.js

#  /==================================================/  #
#			      		 PARTIALS  	        			 #
#  /==================================================/  #

#  /==================================================/  #
#			            index.html  	       			 #
#  /==================================================/  #

for f in "${!models_array[@]}"; do
	if [ "${models_array[$f]}" == 'model' ]; then
		currmodel="${models_array[$f+1]}"
		echo "<a href=""'#!/new/"$currmodel"'"">Create "$currmodel"</a>" >> ./client/assets/partials/index.html
		echo "" >> ./client/assets/partials/index.html
	fi
done
for f in "${!models_array[@]}"; do
	length=${#models_array[@]}
	declare -a attr_array
	if [ "${models_array[$f]}" == 'model' ]; then
		currmodel="${models_array[$f+1]}"
		echo "<h1>"${models_array[$f+1]}"</h1>" >> ./client/assets/partials/index.html
		echo "<table>" >> ./client/assets/partials/index.html
		echo " <tr>" >> ./client/assets/partials/index.html
	elif [ "${models_array[$f]}" == 'a_name' ]; then
		echo "   <th>"${models_array[$f+1]}"</th>" >> ./client/assets/partials/index.html
		attr_array+=(${models_array[$f+1]})
		echo "   <th>Actions</th>" >> ./client/assets/partials/index.html
	elif [ "${models_array[$f+1]}" == 'model' ] || [ "$f" == "$(( length-1 ))" ]; then
		echo "   </tr>" >> ./client/assets/partials/index.html
		echo "   <tr ng-repeat=""'"$currmodel" in "$currmodel"s'"">" >> ./client/assets/partials/index.html
		for g in "${!attr_array[@]}"; do
			echo "     <td ng-bind=""'"$currmodel"."${attr_array[$g]}"'""></td>" >> ./client/assets/partials/index.html
		done
		attr_array=()
		echo "     <td>" >> ./client/assets/partials/index.html
		echo "       <a href='#!/"$currmodel"/{{"$currmodel"._id}}'>Show</a>" >> ./client/assets/partials/index.html
		echo "       <a href='#!/"$currmodel"/{{"$currmodel"._id}}/edit'>Edit</a>" >> ./client/assets/partials/index.html
		echo "       <button ng-click='destroy("$currmodel")'>X</button>" >> ./client/assets/partials/index.html
		echo "     </td>" >> ./client/assets/partials/index.html
		echo "   </tr>" >> ./client/assets/partials/index.html
		echo " </table>" >> ./client/assets/partials/index.html
	fi
done

#  /==================================================/  #
#			              new.html  	       			 #
#  /==================================================/  #

echo "      <!--                    -->" >> ./client/assets/partials/new.html
echo "      <!--  SET UP YOUR FORM  -->" >> ./client/assets/partials/new.html
echo "      <!-- here is an example -->" >> ./client/assets/partials/new.html
echo "      <!--                    -->" >> ./client/assets/partials/new.html
declare -a attr_array=()
echo "<form ng-model='{{class}}' ng-submit='create()';>" >> ./client/assets/partials/new.html
for f in "${!models_array[@]}"; do
	if [ "${models_array[$f]}" == 'a_name' ]; then
		attr_array+=(${models_array[$f+3]})
		attr_array+=(${models_array[$f+1]})
	elif [ "${models_array[$f+1]}" == 'model' ]; then
		break
	fi
done
for m in "${!attr_array[@]}"; do
	if [ "${attr_array[$m]}" == 'String' ]; then
		echo "  <input type='text' ng-model=""'{{class}}."'<!-- FILL THIS IN WITH YOUR ATTRIBUTE -->'"'>" >> ./client/assets/partials/new.html
	elif [ "${attr_array[$m]}" == 'Number' ]; then
		echo "  <input type='number' ng-model=""'{{class}}."'<!-- FILL THIS IN WITH YOUR ATTRIBUTE -->'"'>" >> ./client/assets/partials/new.html
	elif [ "${attr_array[$m]}" == 'Date' ]; then
		echo "  <input type='date' ng-model=""'{{class}}."'<!-- FILL THIS IN WITH YOUR ATTRIBUTE -->'"'>" >> ./client/assets/partials/new.html
	elif [ "${attr_array[$m]}" == 'Boolean' ]; then
		echo "  <select ng-model=""'{{class}}."'<!-- FILL THIS IN WITH YOUR ATTRIBUTE -->'"'>" >> ./client/assets/partials/new.html
		echo "    <option>True</option>" >> ./client/assets/partials/new.html
		echo "    <option>False</option>" >> ./client/assets/partials/new.html
		echo "  </select>" >> ./client/assets/partials/new.html
	fi
done
echo "  <input type='submit' value='Create'>" >> ./client/assets/partials/new.html
echo "</form>" >> ./client/assets/partials/new.html
#   /==================================================/  #
# 				        edit.html        			  #
#   /==================================================/  #

for f in "${!models_array[@]}"; do
	# printf "%s\t%s\n" "$f" "${models_array[$f]}"

	if [ "${models_array[$f]}" == 'model' ]; then
		currmodel="${models_array[$f+1]}"
		lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
		touch ./client/assets/partials/edit$currmodel.html

		declare -a attr_array=()
		echo "<form ng-repeat='"$currmodel" in "$currmodel"s' ng-submit='update()';>" >> ./client/assets/partials/edit$currmodel.html
		for k in "${!models_array[@]}"; do
			if [ "${models_array[$k]}" == 'a_name' ]; then
				attr_array+=(${models_array[$k+3]})
				attr_array+=(${models_array[$k+1]})
			elif [ "${models_array[$k+1]}" == 'model' ]; then
				break
			fi
		done
		for m in "${!attr_array[@]}"; do
			attr_name=""
			if [ ${attr_array[$m]} == 'String' ]; then
				attr_name=${attr_array[$m+1]}
				echo "  <input type='text' ng-model='"$lowercurrmodel"."$attr_name"'>" >> ./client/assets/partials/edit$currmodel.html
			elif [ "${attr_array[$m]}" == 'Number' ]; then
				attr_name=${attr_array[$m+1]}
				echo "  <input type='number' ng-model='"$lowercurrmodel"."$attr_name"'>" >> ./client/assets/partials/edit$currmodel.html
			elif [ "${attr_array[$m]}" == 'Date' ]; then
				attr_name=${attr_array[$m+1]}
				echo "  <input type='date' ng-model='"$lowercurrmodel"."$attr_name"'>" >> ./client/assets/partials/edit$currmodel.html
			elif [ "${attr_array[$m]}" == 'Boolean' ]; then
				attr_name=${attr_array[$m+1]}
				echo "  <select ng-model='"$lowercurrmodel"."$attr_name"'>" >> ./client/assets/partials/edit$currmodel.html
				echo "    <option ng-bind='"$lowercurrmodel"."$attr_name"'></option>" >> ./client/assets/partials/edit$currmodel.html
				echo "  </select>" >> ./client/assets/partials/edit$currmodel.html
			fi
		done
		echo "  <input type='submit' value='Update'>" >> ./client/assets/partials/edit$currmodel.html
		echo "</form>" >> ./client/assets/partials/edit$currmodel.html
	fi
done

#  /==================================================/  #
#			      	   CONTROLLERS          			 #
#  /==================================================/  #

#  /==================================================/  #
#			         indexController.js	       			 #
#  /==================================================/  #

declare -a factories_array
scope='$scope'
location='$location'
routeParams='$routeParams'
for f in "${!models_array[@]}"; do
	if [ "${models_array[$f]}" == 'model' ]; then
		factories_array+=(${models_array[$f+1]}"s")
	fi
done
length=${#factories_array[@]}

echo "app.controller('indexController',[""'"$scope"'"", " >> ./client/assets/js/indexController.js
for g in "${!factories_array[@]}"; do
	echo "'"${factories_array[$g]}"Factory', " >> ./client/assets/js/indexController.js
done
echo "function("$scope", " >> ./client/assets/js/indexController.js
# for k in "${!factories_array[@]}"; do
# 	if [ "$k" == "$(( length-1 ))" ]; then
# 		echo ""${factories_array[$k]}"Factory " >> ./client/assets/js/indexController.js
# 	else
# 		echo ""${factories_array[$k]}"Factory, " >> ./client/assets/js/indexController.js
# 	fi
# done
echo ") {" >> ./client/assets/js/indexController.js
for l in "${!factories_array[@]}"; do
	echo " "$scope"."${factories_array[$l]}" = [];" >> ./client/assets/js/indexController.js
	echo " "$scope".get"${factories_array[$l]}" = function() { " >> ./client/assets/js/indexController.js
	echo "   "${factories_array[$l]}"Factory.index(function(data) {  " >> ./client/assets/js/indexController.js
	echo "      "$scope"."${factories_array[$l]}" = data;" >> ./client/assets/js/indexController.js
	echo "    })" >> ./client/assets/js/indexController.js
	echo " }" >> ./client/assets/js/indexController.js
	echo "" >> ./client/assets/js/indexController.js
done
echo "}])" >> ./client/assets/js/indexController.js


#   /==================================================/  #
# 				        Edit Controller       			  #
#   /==================================================/  #
for f in "${!models_array[@]}"; do
    # length=${#models_array[@]}
  if [ "${models_array[$f]}" == 'model' ]; then
    currmodel="${models_array[$f+1]}"
    lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
    touch ./client/assets/js/new"$currmodel"Controller.js
    echo "app.controller('edit"$currmodel"Controller',['"$scope"','"$routeParams"','"$location"','"$currmodel"sFactory', " >> ./client/assets/js/edit"$currmodel"Controller.js
    echo "function("$scope","$routeParams","$location","$currmodel"sFactory) {"  >> ./client/assets/js/edit"$currmodel"Controller.js
    echo " "$scope".update = function() { " >> ./client/assets/js/edit"$currmodel"Controller.js
    echo "   "$currmodel"sFactory.update("$scope"."$lowercurrmodel", "$routeParams")" >> ./client/assets/js/edit"$currmodel"Controller.js
    echo "   "$location".url('/')" >> ./client/assets/js/edit"$currmodel"Controller.js
    echo " }" >> ./client/assets/js/edit"$currmodel"Controller.js
    echo "}])" >> ./client/assets/js/edit"$currmodel"Controller.js
  fi
done

#  /==================================================/  #
#			      	   FACTORIES            			 #
#  /==================================================/  #
