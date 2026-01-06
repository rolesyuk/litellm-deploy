VENV_PATH="/opt/litellm/venv"
DOMAIN=""

source "${VENV_PATH}/bin/activate"

export SSL_KEYFILE_PATH="/etc/letsencrypt/live/${DOMAIN}/privkey.pem"
export SSL_CERTFILE_PATH="/etc/letsencrypt/live/${DOMAIN}/fullchain.pem"

export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
export REQUESTS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"

export MASTER_KEY=""
export OPENAI_API_KEY=""
export GEMINI_API_KEY=""
