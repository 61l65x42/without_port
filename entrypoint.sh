#!/bin/bash

# Start the SSH server
/usr/sbin/sshd

# Start the Tor service as the debian-tor user
runuser -u debian-tor -- tor &

# Wait longer to ensure Tor has started and generated the hidden service hostname
sleep 60

# Check if the hidden service directory exists and list its contents for debugging
if [ -d /var/lib/tor/hidden_service/ ]; then
    echo "Hidden service directory exists."
    ls -la /var/lib/tor/hidden_service/
else
    echo "Hidden service directory does not exist."
fi

# Display the .onion address
if [ -f /var/lib/tor/hidden_service/hostname ]; then
    cat /var/lib/tor/hidden_service/hostname > /onion_address
    cat /var/lib/tor/hidden_service/hostname
else
    echo "Hostname file does not exist."
    # Check Tor logs for issues
    cat /var/log/tor/notices.log
fi

# Keep the container running
tail -f /dev/null
