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
cd c-tooling
mkdir src
mkdir -p modules/hello/{src,include}
touch ./src/main.c
touch ./modules/hello/src/hello.c
touch ./modules/hello/include/hello.h
```

### CMakeLists.txt

> When you type the file, note that the \ is not needed
> It is there to `escape` the $

```bash
cat > ./CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.15)
project(c-tooling LANGUAGES C)

include(GNUInstallDirs)

add_subdirectory(modules/hello)

add_executable(chello src/main.c)
target_link_libraries(chello PRIVATE hello)

install(TARGETS chello
  RUNTIME DESTINATION \${CMAKE_INSTALL_BINDIR}
)
EOF
```

### modules/hello/CMakeLists.txt

> When you type the file, note that the \ is not needed
> It is there to `escape` the $

```bash
cat > ./modules/hello/CMakeLists.txt << EOF
add_library(hello STATIC
    src/hello.c
)

target_include_directories(hello
    PUBLIC
        \${CMAKE_CURRENT_SOURCE_DIR}/include
)
EOF
```

### main.c

```bash
cat > ./src/main.c << EOF
#include "hello.h"

int main(void) {
    hello();
    return 0;
}
EOF
```

### hello.c

```bash
cat > ./modules/hello/src/hello.c << EOF
#include <stdio.h>
#include "ctooling/hello.h"

void hello(void) {
    printf("Hello, world!\n");
}
EOF
```

### hello.h

```bash
cat > ./modules/hello/include/hello.h << EOF
#ifndef CTOOLING_HELLO_H
#define CTOOLING_HELLO_H

void hello(void);

#endif
EOF
```

## Instructions

```bash
rm -rf build
cmake -B build
cmake --build build
```

## Start over

```bash
git reset --hard
git clean -df
```
