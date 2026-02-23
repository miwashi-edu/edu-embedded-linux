# edu-embedded-linux

## Reset fingerprint (if needed)

```
ssh-keygen -R [localhost]:2225
```

```bash
cd ~
cd ws
git clone https://github.com/miwashi-edu/edu-embedded-linux.git
cd edu-embedded-linux
./start-iotnet.sh
docker compose up -d --build
ssh -p 2225 dev@localhost #password dev
```

