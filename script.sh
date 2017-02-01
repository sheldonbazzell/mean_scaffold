#!/bin/bash

	# printf "%s\t%s\n" "$f" "${models_array[$f]}"

echo -n "Enter your Project Name and press [ENTER]: "
read project_name
mkdir $project_name
cd $project_name
mkdir ./client
mkdir ./client/assets
mkdir ./client/assets/partials
mkdir ./client/assets/js
touch ./client/assets/index.html
touch ./client/assets/app.js
touch ./client/assets/js/indexController.js
touch ./client/assets/js/editController.js
touch ./client/assets/js/showController.js
touch ./client/assets/partials/index.html
touch ./client/assets/partials/show.html
touch ./client/assets/partials/edit.html
touch ./client/assets/partials/new.html
mkdir ./server
mkdir ./server/config
mkdir ./server/models
mkdir ./server/controllers
touch ./server.js
touch ./server/config/routes.js
touch ./server/config/mongoose.js


#  /==================================================/  #
#  /==================================================/  #
#			    	      CONFIG 						 # 
#  /==================================================/  #
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
#  /==================================================/  #
#			   		 	  MODELS						 # 
#  /==================================================/  #
#  /==================================================/  #

#  /==================================================/  #
#			     	  declare models					 # 
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

#  /==================================================/  #
#			   	    	set models						 # 
#  /==================================================/  #
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


#  /==================================================/  #
#  /==================================================/  #
#				   index.html  (main)    				 # 
#  /==================================================/  #
#  /==================================================/  #
echo "<!DOCTYPE html>" >> ./client/assets/index.html
echo "<html ng-app='app'>" >> ./client/assets/index.html
echo "<head>" >> ./client/assets/index.html
echo "  <title>"$project_name"</title>" >> ./client/assets/index.html
echo "  <script src='angular/angular.js'></script>" >> ./client/assets/index.html
echo "  <script src='angular-route/angular-route.js'></script>" >> ./client/assets/index.html
echo "  <script src='app.js'></script>" >> ./client/assets/index.html
for f in "${!models_array[@]}"; do
	if [ "${models_array[$f]}" == 'model' ]; then
		currmodel="${models_array[$f+1]}"
		touch ./client/assets/js/"$currmodel"Factory.js
		echo "  <script src=""'assets/js/"$currmodel"Factory.js'""></script>" >> ./client/assets/index.html
	fi
done
echo "</head>" >> ./client/assets/index.html
echo "<body>" >> ./client/assets/index.html
echo "  <div ng-view></div>" >> ./client/assets/index.html
echo "</body>" >> ./client/assets/index.html
echo "</html>" >> ./client/assets/index.html



#  /==================================================/  #
#  /==================================================/  #
#				           app.js  	    				 # 
#  /==================================================/  #
#  /==================================================/  #

echo "var app = angular.module('app', ['ngRoute'])" >> ./client/assets/app.js
echo "app.config(function($routeProvider) {" >> ./client/assets/app.js
echo "  $routeProvider" >> ./client/assets/app.js
echo "    .when('/', {" >> ./client/assets/app.js
echo "      templateUrl: 'assets/partials/index.html'" >> ./client/assets/app.js
echo "      controller:  'indexController'" >> ./client/assets/app.js
echo "    }) " >> ./client/assets/app.js
echo "    .when('/new/:class', {" >> ./client/assets/app.js
echo "      templateUrl: 'assets/partials/new.html'" >> ./client/assets/app.js
echo "      controller:  'newController'" >> ./client/assets/app.js
echo "    }) " >> ./client/assets/app.js
echo "    .when('/:class/:id', {" >> ./client/assets/app.js
echo "      templateUrl: 'assets/partials/show.html'" >> ./client/assets/app.js
echo "      controller:  'showController'" >> ./client/assets/app.js
echo "    }) " >> ./client/assets/app.js

#  /==================================================/  #
#  /==================================================/  #
#			      		 PARTIALS  	        			 # 
#  /==================================================/  #
#  /==================================================/  #

#  /==================================================/  #
#			            index.html  	       			 # 
#  /==================================================/  #

for f in "${!models_array[@]}"; do
	if [ "${models_array[$f]}" == 'model' ]; then
		currmodel="${models_array[$f+1]}"
		echo "<a href=""'/new/"$currmodel"'"">Create "$currmodel"</a>" >> ./client/assets/index.html
		echo "" >> ./client/assets/index.html
	fi
done
for f in "${!models_array[@]}"; do
	length=${#models_array[@]}
	declare -a attr_array
	if [ "${models_array[$f]}" == 'model' ]; then
		currmodel="${models_array[$f+1]}"
		echo "<h1>"${models_array[$f+1]}"</h1>" >> ./client/assets/index.html
		echo "<table>" >> ./client/assets/index.html
		echo " <tr>" >> ./client/assets/index.html
	elif [ "${models_array[$f]}" == 'a_name' ]; then
		echo "   <th>" >> ./client/assets/index.html
		echo "     "${models_array[$f+1]}"" >> ./client/assets/index.html
		attr_array+=(${models_array[$f+1]})
		echo "   </th>" >> ./client/assets/index.html
	elif [ "${models_array[$f+1]}" == 'model' ] || [ "$f" == "$(( length-1 ))" ]; then
		echo "   </tr>" >> ./client/assets/index.html
		echo "   <tr ng-repeat=""'"$currmodel" in "$currmodel"s'"">" >> ./client/assets/index.html
		for g in "${!attr_array[@]}"; do
			echo "     <td ng-bind=""'"$currmodel"."${attr_array[$g]}"'""></td>" >> ./client/assets/index.html
		done
		attr_array=()
		echo "   </tr>" >> ./client/assets/index.html
		echo " </table>" >> ./client/assets/index.html

	fi
done

#  /==================================================/  #
#			              new.html  	       			 # 
#  /==================================================/  #
echo "      <!--                    -->" >> ./client/assets/new.html
echo "      <!--  SET UP YOUR FORM  -->" >> ./client/assets/new.html
echo "      <!-- here is an example -->" >> ./client/assets/new.html
echo "      <!--                    -->" >> ./client/assets/new.html
declare -a attr_array=()
echo "<form ng-model='{{class}}' ng-submit='create()';>" >> ./client/assets/new.html
for f in "${!models_array[@]}"; do
	if [ "${models_array[$f]}" == 'a_name' ]; then
		attr_array+=(${models_array[$f+3]})
		attr_array+=(${models_array[$f+1]})
	elif [ "${models_array[$f+1]}" == 'model' ]; then
		break
	fi
done
for m in "${!attr_array[@]}"; do
	printf "%s\t%s\n" "$m" "${attr_array[$m]}"
	if [ "${attr_array[$m]}" == 'String' ]; then
		echo "  <input type='text' ng-model=""'{{class}}."'<!-- FILL THIS IN WITH YOUR ATTRIBUTE -->'"'>" >> ./client/assets/new.html
	elif [ "${attr_array[$m]}" == 'Number' ]; then
		echo "  <input type='number' ng-model=""'{{class}}."'<!-- FILL THIS IN WITH YOUR ATTRIBUTE -->'"'>" >> ./client/assets/new.html
	elif [ "${attr_array[$m]}" == 'Date' ]; then
		echo "  <input type='date' ng-model=""'{{class}}."'<!-- FILL THIS IN WITH YOUR ATTRIBUTE -->'"'>" >> ./client/assets/new.html
	elif [ "${attr_array[$m]}" == 'Boolean' ]; then
		echo "  <select ng-model=""'{{class}}."'<!-- FILL THIS IN WITH YOUR ATTRIBUTE -->'"'>" >> ./client/assets/new.html
		echo "    <option>True</option>" >> ./client/assets/new.html
		echo "    <option>False</option>" >> ./client/assets/new.html
		echo "  </select>" >> ./client/assets/new.html
	fi
done
echo "  <input type='submit' value='Create'>" >> ./client/assets/new.html
echo "</form>" >> ./client/assets/new.html


# #  /==================================================/  #
# #  /==================================================/  #
# #				    		CONTROLLERS     			   # 
# #  /==================================================/  #
# #  /==================================================/  #

# for f in "${!models_array[@]}"; do
# 	# printf "%s\t%s\n" "$f" "${models_array[$f]}"
# 	controller_name="$currmodel"'s'
# 	touch ./server/controllers/$controller_name.js
# 	length=${#models_array[@]}
# 	if [ "${models_array[$f]}" == 'model' ]; then
# 		currmodel="${models_array[$f+1]}"
# 		controller_name="$currmodel"'s'
# 		parens="()"
# 		touch ./server/controllers/$controller_name.js
# 		echo "var mongoose = require('mongoose')," >> ./server/controllers/"$controller_name".js
# 		echo " " $currmodel "= mongoose.model(""'"$currmodel"'"");" >> ./server/controllers/"$controller_name".js
# 		echo " " >> ./server/controllers/"$controller_name".js
# 		echo "function" $controller_name"Controller"$parens" {" >> ./server/controllers/"$controller_name".js
# 		echo "  this.index = function(req,res) {" >> ./server/controllers/"$controller_name".js
# 		echo "     "$currmodel".find({}, function(err,"$currmodel"s) {" >> ./server/controllers/"$controller_name".js
# 		echo "       if(err) { res.json(err); }" >> ./server/controllers/"$controller_name".js
# 		echo "       else { res.json("$currmodel"s); }" >> ./server/controllers/"$controller_name".js
# 		echo "     })" >> ./server/controllers/"$controller_name".js
# 		echo "  }" >> ./server/controllers/"$controller_name".js
# 		echo " " >> ./server/controllers/"$controller_name".js
# 		echo "  this.create = function(req,res) {" >> ./server/controllers/"$controller_name".js
# 		echo "     var "$currmodel" = new" $currmodel"(req.body);" >> ./server/controllers/"$controller_name".js
# 		echo "     "$currmodel".save(function(err) {" >> ./server/controllers/"$controller_name".js
# 		echo "       if(err) { res.json(err); }" >> ./server/controllers/"$controller_name".js
# 		echo "       else { res.redirect('/"$currmodel"s'); }" >> ./server/controllers/"$controller_name".js
# 		echo "     })" >> ./server/controllers/"$controller_name".js
# 		echo "  }" >> ./server/controllers/"$controller_name".js
# 		echo " " >> ./server/controllers/"$controller_name".js
# 		echo "  this.show = function(req,res) {" >> ./server/controllers/"$controller_name".js
# 		echo "     "$currmodel".findOne({_id:req.params.id}, function(err,"$currmodel") {" >> ./server/controllers/"$controller_name".js
# 		echo "       if(err) { res.json(err); }" >> ./server/controllers/"$controller_name".js
# 		echo "       else { res.json("$currmodel"); }" >> ./server/controllers/"$controller_name".js
# 		echo "     })" >> ./server/controllers/"$controller_name".js
# 		echo "  }" >> ./server/controllers/"$controller_name".js
# 		echo " " >> ./server/controllers/"$controller_name".js
# 		echo "  this.update = function(req,res) {" >> ./server/controllers/"$controller_name".js
# 		echo "     "$currmodel".update({_id:req.params.id}, req.body, function(err,"$currmodel") {" >> ./server/controllers/"$controller_name".js
# 		echo "       if(err) { res.json(err); }" >> ./server/controllers/"$controller_name".js
# 		echo "       else { res.json("$currmodel"); }" >> ./server/controllers/"$controller_name".js
# 		echo "     })" >> ./server/controllers/"$controller_name".js
# 		echo "  }" >> ./server/controllers/"$controller_name".js
# 		echo " " >> ./server/controllers/"$controller_name".js
# 		echo "  this.destroy = function(req,res) {" >> ./server/controllers/"$controller_name".js
# 		echo "     "$currmodel".remove({_id:req.params.id}, function(err,"$currmodel") {" >> ./server/controllers/"$controller_name".js
# 		echo "       if(err) { res.json(err); }" >> ./server/controllers/"$controller_name".js
# 		echo "       else { res.json("$currmodel"); }" >> ./server/controllers/"$controller_name".js
# 		echo "     })" >> ./server/controllers/"$controller_name".js
# 		echo "  }" >> ./server/controllers/"$controller_name".js
# 		echo "}" >> ./server/controllers/"$controller_name".js
# 		echo "module.exports = new "$controller_name"Controller"$parens"" >> ./server/controllers/"$controller_name".js
# 	fi
# done

# #  /==================================================/  #
# #					    	ROUTES 						   # 
# #  /==================================================/  #

# for f in "${!models_array[@]}"; do
# 	currmodel="${models_array[$f+1]}"
# 	controller_name="$currmodel"'s'
# 	if [ "${models_array[$f]}" == 'model' ]; then
# 		echo "var "$controller_name" = require('../controllers/"$controller_name".js');" >> ./server/config/routes.js
# 	fi
# done
# echo "module.exports = function(app) {" >> ./server/config/routes.js
# for f in "${!models_array[@]}"; do
# 	if [ "${models_array[$f]}" == 'model' ]; then
# 		currmodel="${models_array[$f+1]}"
# 		controller_name="$currmodel"'s'
# 		echo "  app.get('/"$controller_name"', "$controller_name".index);" >> ./server/config/routes.js
# 		echo "  app.post('/"$controller_name"', "$controller_name".create);" >> ./server/config/routes.js
# 		echo "  app.get('/"$controller_name"/:id', "$controller_name".show);" >> ./server/config/routes.js
# 		echo "  app.put('/"$controller_name"/:id', "$controller_name".update);" >> ./server/config/routes.js
# 		echo "  app.delete('/"$controller_name"/:id', "$controller_name".destroy);" >> ./server/config/routes.js
# 	fi
# done
# echo "} " >> ./server/config/routes.js

