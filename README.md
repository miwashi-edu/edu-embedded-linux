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
cd ~
cd ws
cd c-tooling
git add .
git commit -m "Level-1"
```

## Instructions

```bash
cd ~
cd ws
cd c-tooling
mkdir -p modules/creetings/{src,include}
touch ./modules/creeting/src/creetings.c
touch ./modules/creetings/include/creetings.h
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
add_subdirectory(modules/creetings)

add_executable(chello src/main.c)
target_link_libraries(chello PRIVATE hello)

install(TARGETS chello creetings
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
EOF
```

### modules/creetings/CMakeLists.txt

> When you type the file, note that the \ is not needed
> It is there to `escape` the $

```bash
cat > ./modules/creetings/CMakeLists.txt << EOF
add_executable(creetings
    src/creetings.c
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
cat > ./modules/creetings/src/creetings.c << EOF
#include <stdio.h>

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <name>\n", argv[0]);
        return 2;
    }

    printf("Creetings, %s!\n", argv[1]);
    return 0;
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
sudo cmake --install build
```

## Start over

```bash
git reset --hard
git clean -df
```
