# edu-embedded-linux

> Task, given `net scan`.
> Use net scan to scan all IP that respons to ping on a net mask (ie. 192.168.0.0/27)
> Find the mac adress of every IP adress
> Determine if it is a raspberry py from the mac adress.

## Expected output

```text
No, b0:39:56:57:46:88 192.168.1.1 is not a known Raspberry Pi address.
No, 68:a4:e:3:f1:5a 192.168.1.2 is not a known Raspberry Pi address.
No, 7c:2a:ca:b0:40:35 192.168.1.4 is not a known Raspberry Pi address.
No, 6e:7:6:d5:cb:38 192.168.1.6 is not a known Raspberry Pi address.
Yes, 88:a2:9e:3f:71:d2 192.168.1.17 is a Raspberry Pi address.
Yes, 2c:cf:67:d1:a5:18 192.168.1.20 is a Raspberry Pi address.
```

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
git switch level-5
./start-iotnet.sh # If not started already
docker compose down
docker compose up -d --build
ssh -p 2225 dev@localhost #password dev
```
## Prepare (only once)

> Create an `empty` repository in github, it must be empty.
> Copy the `URL` to this repository
> Remember you need to create a `Personal Access Token` as password.

### Prepare GIT

```bash
git config --global init.defaultBranch main
git config --global user.name "you name"
git config --global user.email "user@example.com"
cd ~
cd ws
cd net
git init
git add .
git commit -m "initial commit"
git remote add origin [er github länk]
git push -u origin main
```

### Prepare Rest

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
sudo apt update
sudo apt install curl
sudo apt install iputils-ping 
sudo apt install net-tools
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## Instructions

```bash
cd ~
cd ws
cd net
uv run net scan 192.168.1.0/27 2>/dev/null
```

## Instructions

```bash
# If in your personal computer, use pipx
pip install . --break-system-packages
net scan 192.168.1.0/27
```

## Hints

```python
def _get_vendor(mac_addr: str):
    """Internal helper to lookup the vendor of a MAC address."""
    url = f"https://api.macvendors.com/{mac_addr}"
    try:
        # User agent header is often required for some APIs
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req) as response:
            return response.read().decode('utf-8')
    except urllib.error.HTTPError as e:
        if e.code == 404:
            return None
        elif e.code == 429:
            raise Exception("Too many requests. Please try again later.")
        else:
            raise Exception(f"HTTP {e.code} {e.reason}")
    except Exception as e:
        raise Exception(f"{e}")
```

```python
result = subprocess.run(
            ["arp", "-n", ip],
            capture_output=True,
            text=True,
            timeout=5
        )
``

