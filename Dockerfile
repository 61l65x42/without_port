# Use an official Debian as a parent image
FROM debian:latest

# Update the package list and install necessary packages
RUN apt-get update && apt-get install -y \
    tor \
    openssh-server \
    git \
    vim \
    torsocks \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for the SSH daemon and set up the SSH server
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd

# Configure SSH server for key-based authentication
RUN mkdir /root/.ssh
COPY authorized_keys /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys

# Disable password authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# Uncomment the Port line in sshd_config
RUN sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config

# Configure Tor hidden service
RUN mkdir -p /var/lib/tor/hidden_service/
RUN chown -R debian-tor:debian-tor /var/lib/tor/hidden_service/
RUN chmod 700 /var/lib/tor/hidden_service/

# Add Tor configuration
RUN echo "HiddenServiceDir /var/lib/tor/hidden_service/" >> /etc/tor/torrc
RUN echo "HiddenServicePort 22 127.0.0.1:22" >> /etc/tor/torrc
RUN echo "Log notice file /var/log/tor/notices.log" >> /etc/tor/torrc

# Expose the SSH port
EXPOSE 22

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Start SSH and Tor services
CMD ["/entrypoint.sh"]
