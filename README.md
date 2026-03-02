# edu-embedded-linux

## Reset fingerprint (if needed)

```
ssh-keygen -R "[localhost]:2225"
```

## Connect

```bash
ssh -p 2225 dev@localhost #password dev
```
## Prepare (only once)

```bash
sudo apt update
sudo apt install cmake
cd ~
mkdir ws
cd ws
mkdir c-tooling
cd c-tooling
git init
echo "# c-tooling" > README.md
git add .
git commit -m "Initial commit"
```

## Instructions

```bash
cd ~
cd ws
cd iot
mkdir src
mkdir include
mkdir include/ctooling
mkdir build
touch ./src/main.c
touch ./src/hello.c
touch ./include/ctooling/hello.h
```

### CMakeList.txt

```bash
cat > ./CMakeList.txt << EOF
cmake_minimum_required(VERSION 3.15)

project(c-tooling LANGUAGES C)

add_library(ctooling
    src/hello.c
)

target_include_directories(ctooling
    PUBLIC
        ${PROJECT_SOURCE_DIR}/include
)

add_executable(ctooling_app
    src/main.c
)

target_link_libraries(ctooling_app
    PRIVATE
        ctooling
)
EOF
```

### main.c

```bash
cat > main.c << EOF
#include <ctooling/hello.h>

int main(void) {
    hello();
    return 0;
}
EOF
```

### hello.c

```bash
cat > ./src/hello.c << EOF
#include <stdio.h>
#include <ctooling/hello.h>

void hello(void) {
    printf("Hello, world!\n");
}
EOF
```

### hello.h

```bash
cat > ./include/ctooling/hello.h << EOF
#ifndef CTOOLING_HELLO_H
#define CTOOLING_HELLO_H

void hello(void);

#endif
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
