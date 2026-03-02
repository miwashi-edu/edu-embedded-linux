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
cd ws
cd c-tooling
git add .
git commit -m "level-2"
```

## Instructions

```bash
cd ~
cd ws
cd c-tooling
mkdir cmake
touch ./cmake/deps.cmake
```


### depts.cmake

```bash
cat > ./cmake/deps.cmake << EOF
include(FetchContent)

FetchContent_Declare(
        argparse_upstream
        GIT_REPOSITORY https://github.com/cofyc/argparse.git
        GIT_TAG        master
)

FetchContent_MakeAvailable(argparse_upstream)

# Upstream isn't a CMake project, so we create our own target from its sources.
add_library(argparse STATIC
        \${argparse_upstream_SOURCE_DIR}/argparse.c
)

target_include_directories(argparse
        PUBLIC
        ${argparse_upstream_SOURCE_DIR}
)

add_library(argparse::argparse ALIAS argparse)
EOF
```

### CMakeLists.txt

```bash
cat > .CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.15)
project(c-tooling LANGUAGES C)

include(GNUInstallDirs)

list(APPEND CMAKE_MODULE_PATH "\${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(deps)  # MUST be before modules that use argparse

add_subdirectory(modules/hello)
add_subdirectory(modules/creetings)

add_executable(chello src/main.c)
target_link_libraries(chello PRIVATE hello)

install(TARGETS chello creetings
        RUNTIME DESTINATION \${CMAKE_INSTALL_BINDIR}
)
EOF
```

### creetings/CMakeLists.txt

```bash
cat > ./modules/creetings/CMakeLists.txt << EOF
add_executable(creetings src/creetings.c)
target_link_libraries(creetings PRIVATE argparse::argparse)
EOF
```

### creetings.c

```bash
cat > ./modules/creetings/src/creetings.c << EOF
#include <stdio.h>
#include "argparse.h"

static const char *const usages[] = {
    "creetings <name>",
    NULL,
};

int main(int argc, const char **argv) {
    struct argparse_option options[] = {
        OPT_HELP(),
        OPT_END(),
    };

    struct argparse argparse;
    argparse_init(&argparse, options, usages, 0);
    argparse_describe(&argparse, "\nPrint a greeting.", "\nExample:\n  creetings Alice");

    argc = argparse_parse(&argparse, argc, argv);

    if (argc != 1) {
        argparse_usage(&argparse);
        return 2;
    }

    const char *name = argv[0];
    printf("Creetings, %s!\n", name);
    return 0;
}
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
