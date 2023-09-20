#/bash/sh

i=1;
num=0

function getPackage(){
	package=`tail -4 packages.info |cut -f 2 -d ' '|sed -n ' '$i' p'`
	echo -e "current package is $package \n";
}


function getAddr(){
	address=`tail -4 packages.info  |cut -f 3 -d ' ' |sed -n ' '$i' p'`
	echo -e "current address is $address \n";

}

function updateNum(){
	let i++;
	echo -e "current pointer is $i \n";
}

function clearDir(){
	p_path="package/$package"
	echo -e "Path is $p_path\n"
	[ -e $p_path ] && rm -rf $p_path || mkdir $p_path
}

function clonePackage(){
	while ((num<4));do
		getPackage;
		getAddr;
		updateNum;
		echo -e "package is ${package},address is ${address}.\n"
		clearDir;
		git clone $address $p_path;
		echo -e "-------------------------------------------------\n"
		let num++;
	done
	$(pwd)/script/feeds update -a && $(pwd)/script/feeds install -a
}
function clearVAR(){
	i=1;
	package=""
	address=""
	num=0
}
clonePackage
clearVAR

	
#./scripts/feeds update -a && ./scripts/feeds install -a
