#!bin/ bash
sudo su
apt-get update && apt-get install qemu-kvm -y
##Install graphics driver on ubuntu 18.04
add-apt-repository ppa:graphics-drivers
apt-get update
apt-get install nvidia-driver-418

#Install Nvidia CUDA drivers
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
dpkg -i cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
apt-get update
wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
apt install ./nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
apt-get update

#check installation
nvidia-smi

#Install docker ce
apt-get remove docker docker-engine docker.io
apt-get update
apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
xenial \
stable"

#Nvidia GPU docker commands
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
apt-get update && sudo apt-get install -y nvidia-container-toolkit
systemctl restart docker

#Test nvidia docker graphics
docker run --gpus all nvidia/cuda:9.0-base nvidia-smi

# run docker with gpu installed
Docker pull tenserflow/gpu-unity-ubuntu-xfce-novnc:v1
docker run --user 0 --gpus all -it -p 5901:5901 -p 6901:6901 tenserflow/gpu-unity-ubuntu-xfce-novnc:v1
