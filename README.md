# without_port

## Overview
This project automates the configuration and deployment of containers running various software to connect to devices in a network where port modification is not possible. Currently, the implementation leverages Tor to facilitate secure and anonymous connections.

## Features
- **Automated Configuration**: Set up and run different containers with the necessary software to connect to devices in restricted networks.
- **Tor Integration**: Use Tor hidden services to bypass network restrictions and enable secure connections without modifying ports.
- **SSH Access**: Securely access devices using SSH over Tor.

## Getting Started

### Prerequisites
- Docker installed on your machine.
- A GitHub repository with the necessary code and SSH key.

### Setup and Installation

1. **Clone the Repository**
```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo
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
4. **Access the Container and Use Git**
+ Access the running container and clone your Git repository using a specified SSH key.
```bash
docker exec -it tor-ssh-container /bin/bash
GIT_SSH_COMMAND="ssh -i /root/.ssh/yourkey" git clone github.com/repo.git
```

