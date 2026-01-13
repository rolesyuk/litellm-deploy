#!/bin/bash

chmod +r /etc/letsencrypt/archive/veequ3.ddns.net/privkey*.pem
chmod 755 /etc/letsencrypt/{live,archive}

sudo -u nobody bash -c '. /opt/litellm/env.sh; litellm --config /opt/litellm/config.yaml'
