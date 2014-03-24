#!/bin/bash

echo ""
echo "Node server skeleton by Matthew Drake"
echo ""

cd ..

if [[ -z "$1" ]]; then
	SILENT=0
	echo "Alright, let's start by creating a new node project."
	echo "What is your project's name? [Spaces or non-alpha characters will be ignored]"
	read APP_ID	
else
	APP_ID=$1
	SILENT=1
fi

APP_ID=${APP_ID//[^A-Za-z\-_]/}

template=`cat build.sh.template`
service_template=`cat upstart.template`

echo "Creating project folder $APP_ID"
mkdir $APP_ID && cd $APP_ID

echo "Creating src folder"
mkdir src
echo "Creating local folder"
mkdir local
echo "Creating prod folder"
mkdir prod
echo "Creating stag folder"
mkdir stag
echo "Creating log folder"
mkdir log

echo "Creating bash build script."
echo -e "APP_ID=$APP_ID\n$template">>build.sh

echo "Creating upstart file."
echo -e "APP_ID_=$APP_ID\n$service_template">>${APP_ID}.conf

echo "===Please edit and review the bash script==="
cd node-deploy-tools