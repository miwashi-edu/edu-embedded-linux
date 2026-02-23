# edu-embedded-linux

## Reset fingerprint (if needed)

```
ssh-keygen -R "[localhost]:2225"
```

## Connect

```bash
cd ~
cd ws
git clone https://github.com/miwashi-edu/edu-embedded-linux.git
cd edu-embedded-linux
./start-iotnet.sh # If not started already
docker compose up -d --build
ssh -p 2225 dev@localhost #password dev
```
## Prepare (only once)

```bash
sudo apt-get update
sudo apt-get install curl
mkdir $HOME/.local/bin
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
curl -LsSf https://astral.sh/uv/install.sh | sh
git config --global init.defaultBranch main
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
cd ~
mkdir ws
cd ws
mkdir iot
cd iot
git init
echo "# iot" > README.md
git add .
git commit -m "Initial commit"
```

## Instructions

```bash
cd ~
cd ws
cd iot
mkdir src
mkdir ./src/iot
touch ./src/iot/__init__.py
```


### pyproject.toml

```bash
cat > pyproject.toml << EOF
[project]
name = "iot"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
authors = [
    { name = "IoT dev", email = "iot@example.com" }
]
requires-python = ">=3.11"
dependencies = []

[project.scripts]
hello = "iot:hello"

[tool.uv.sources]

[build-system]
requires = ["uv_build>=0.10.4,<0.11.0"]
build-backend = "uv_build"
EOF
```

### init.py

```bash
cat > ./src/iot/__init__.py << EOF
def hello() -> str:
    return "Hello from iot!"
EOF
```

## Instructions

```bash
pip install . --break-system-packages
hello
```

## Start over

```bash
git reset --hard
git clean -df
```
