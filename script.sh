#path of the cloned folder
cd /d/Projects/LLA/lla_docker/lla_frontend

git fetch --all
git checkout feature/latestEnergyManagement
git branch


echo "## Pulling the latest code"

git pull

if [ $? -ne 0 ]
then
   echo "git pull failed, Please check the error"
   exit 1
fi

echo "########################--> Date when build happens: `date +%d-%b-%Y_%H-%M-%S`"
echo ""
timestamp=`date +%d-%b-%Y_%H-%M-%S`
echo ""
echo "######################## Docker Build Started  #############"

##Syntax of docker build command

## docker build -t <Tag name or image name> -f <path to Dockerfile> <Context Path i.e where the build content needs to be taken>

docker build -t frontend:"$timestamp" -f /d/Projects/LLA/lla_docker/lla_frontend/Dockerfile /d/Projects/LLA/lla_docker/lla_frontend 

if [ $? -ne 0 ]
then
   echo "Please check the error or VERIFY your Docker Desktop is up and running?
   	If not running --->> Start the docker engine and rerun  <--------------"
   exit 1
fi

echo "##########    Docker build is done           ##########"

docker run -p 80:3006 --name lla_"$timestamp" -d  frontend:"$timestamp"

