## without_port

### Overview
This project sets up a Docker container running a Tor hidden service to remotely control a host device via SSH, without needing to modify network policies. More similar services will be added in the future to their own containers, apache avocado etc...

### Features
- **Automated Configuration**: Easily set up and run containers with the required software.
- **Tor Integration**: Bypass network restrictions using Tor hidden services.
- **SSH Access**: Securely connect to devices via SSH over Tor.

### Getting Started

#### Prerequisites
- Docker installed.
- A GitHub repository with the necessary code and SSH key.


### First generate the ssh key used for the authentication to the container, use this instead the password auth
```bash
ssh-keygen -t rsa -b 4096 -f dockertor_ssh_key
cat dockertor_ssh_key.pub >> authorized_keys
```

### Setup and Installation

1. **Clone the Repository**
```bash
   git clone https://github.com/61l65x/without_port.git
   cd without_port
```
2. **Build the Docker Image**
+ Ensure your Dockerfile and entrypoint.sh are properly set up in the repository.
```bash
docker build -t tor-ssh .
```
3. **Run the Docker Container** 
+ Run the container in host network mode to ensure it can communicate with the host network.
```bash
docker run -d --name tor-ssh-container --network host tor-ssh
```

4. **Connect to the .onion Service Using Torsocks**
After setting up the Tor hidden service, you can connect to it using torsocks to ensure your connection is routed through the Tor network and use the container remotely trough the tor, without touching network configurations.
And example use of git in the container.

```bash 
torsocks ssh -i ./your_ssh_key root@youronionaddress.onion
GIT_SSH_COMMAND="ssh -i /root/.ssh/yourkey" git clone github.com/repo.git
```

#### Problem solving

+ Launch  bash in the  container check if all the services are running and ok, tor, sshd. 
```bash
docker exec -it tor-ssh-container /bin/bash
```