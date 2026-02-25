# edu-embedded-linux

## Connect by SSH to your dev machine

```
ssh-keygen -R "[localhost]:2225" # If needing to reset when changing machine
ssh -p 2225 dev@localhost #password dev
```

## Prepare (only once)

> Check hello command is working, when it is then continue.

```bash
cd ~
cd ws
> ./src/iot/__init__.py # Empty __init__.py
git add .
git commit -m "level-1"
```

## Instructions

```bash
cd ~
cd ws
cd iot
touch ./src/iot/main.py
touch ./src/iot/__main__.py
```

```bash
cat > ./src/iot/main.py << EOF
import typer

app = typer.Typer()

def hello() -> str:
    return "Hello from iot!"

@app.command()
def greet(name: str = typer.Argument("World", help="Name to greet")):
    """Greet someone by name."""
    print(f"Hello, {name}!")

@app.command()
def version():
    """Show the current version."""
    print("iot version 0.2.0")

if __name__ == "__main__":
    app()
EOF
```

```bash
cat > ./src/iot/__main__.py << EOF
from iot.main import app

if __name__ == "__main__":
    app()
EOF
```

### pyproject.toml

#### Dependencies

```toml
dependencies = [
    "typer>=0.12.0"
]
```

#### Scripts

```toml
[project.scripts]
iot = "iot.main:app"
```

### Install it

```bash
pip install . --break-system-packages
```

### Test it

```
iot --help
iot greet
iot greet Alice
iot version
```

## Start over

```bash
git reset --hard
git clean -df
```
