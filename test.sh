declare -a models_array
function pushModel() {
	echo -n "Enter your Model Name and press [ENTER]: "
	read model_name
	while [ -z $model_name ]; do
		echo -n "Enter your Model Name and press [ENTER]: "
		read model_name
	done
	model_name="$(echo $model_name | tr '[:upper:]' '[:lower:]')"
	model_name="$(echo ${model_name^})"
	models_array+=('model' $model_name)
}
pushModel

function repeatModel() {
	echo -n "Another Model? Type no to exit: "
	read another_model
	another_model="$(echo $another_model | tr '[:upper:]' '[:lower:]')"
	if [ $another_model == 'yes' ]; then
		pushModel
		pushAttributes
	elif [ $another_model == 'no' ]; then
		break
	else
		echo "Invalid input. Must be YES or NO"
		repeatModel
	fi
}

function repeatAttribute(){
	echo -n "Another Attribute? Type no to exit: "
	read another_attr
	another_attr="$(echo $another_attr | tr '[:upper:]' '[:lower:]')"
	if [ $another_attr == 'yes' ]; then
		pushAttributes
	elif [ $another_attr == 'no' ]; then
		repeatModel
	else
		echo "Invalid input. Must be YES or NO"
		repeatAttribute
	fi
}
function pushAttributes() {
	echo -n "Enter Attribute NAME and press [ENTER]: "
	read attr_name
	while [ -z $attr_name ]; do
		echo -n "Enter Attribute Name and press [ENTER]: "
		read attr_name
	done
	attr_name="$(echo $attr_name | tr '[:upper:]' '[:lower:]')"
	models_array+=('a_name' $attr_name)
	echo -n "Enter Attribute TYPE and press [ENTER]: "
	read attr_type
	while [ -z $attr_type ]; do
		echo -n "Enter Attribute TYPE and press [ENTER]: "
		read attr_type
	done
	attr_type="$(echo $attr_type | tr '[:upper:]' '[:lower:]')"
	arr=('string' 'number' 'date' 'boolean' 'array')
	for i in "${!arr[@]}"; do
		if [ $attr_type == ${arr[$i]} ]; then
			bool=true
			break
		else
			bool=false
		fi
	done
	while [ $bool == false ]; do
		echo -n "Enter VALID Attribute TYPE and press [ENTER]: "
		read attr_type
	done
	attr_type="$(echo ${attr_type^})"
	models_array+=('a_type' $attr_type)
	repeatAttribute
}
pushAttributes


for f in "${!models_array[@]}"; do
	printf "%s\t%s\n" "$f" "${models_array[$f]}"
done
