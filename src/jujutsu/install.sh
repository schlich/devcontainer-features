set -e

apt-get update
apt-get install -y build-essential
cargo install --locked --bin jj jj-cli

chmod +x /usr/local/cargo/bin/jj

export PATH="$PATH:$HOME/.cargo/bin"

echo jj --version