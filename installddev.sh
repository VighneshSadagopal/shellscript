curl https://apt.fury.io/drud/gpg.key | sudo apt-key add -
echo "deb https://apt.fury.io/drud/ * *" | sudo tee -a /etc/apt/sources.list.d/ddev.list
sudo apt update && sudo apt install -y ddev

