# Install dependencies
sudo apt-get install build-essential gdb lcov pkg-config \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
      lzma lzma-dev tk-dev uuid-dev zlib1g-dev libmpdec-dev libzstd-dev \
      inetutils-inetd

# Build OpenSSL
wget https://github.com/openssl/openssl/releases/download/openssl-3.5.4/openssl-3.5.4.tar.gz
./config --prefix=/opt/openssl --openssldir=/usr/local/ssl shared zlib
make && make install
sed -i '1s/^/\/opt\/openssl\/lib64\n/' /etc/ld.so.conf
ldconfig

# Update CAs
wget http://ftp.debian.org/debian/pool/main/c/ca-certificates/ca-certificates_20250419_all.deb

# Build Python
wget https://www.python.org/ftp/python/3.13.11/Python-3.13.11.tgz
export LDFLAGS="-L/opt/openssl/lib64"
export CPPFLAGS="-I/opt/openssl/include -I/opt/openssl/include/openssl"
./configure --enable-optimizations --prefix=/opt/litellm/python
make && make install

# Install certbot
python3 -m venv /opt/certbot/
/opt/certbot/bin/pip install --upgrade pip
/opt/certbot/bin/pip install certbot
ln -s /opt/certbot/bin/certbot /usr/bin/certbot
certbot certonly --standalone
echo "0 0,12 * * * root /opt/certbot/bin/python -c 'import random; import time; time.sleep(random.random() * 3600)' && sudo certbot renew -q" > /etc/crontab

# Setup No-IP DDNS
wget --content-disposition https://www.noip.com/download/linux/latest
dpkg -i noip-duc_3.3.0_amd64.deb
echo "0 12 * * 0 nobody noip-duc --once -u group:user -p passwd -g all.ddnskey.com" > /etc/crontab

# Install Rust (requires a lot of RAM > 512MB)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install LiteLLM
pip install 'litellm[proxy]'
