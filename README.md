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
cat > ./cmake/depts.cmake << EOF
include(FetchContent)

# ---- argparse (C library) ----
FetchContent_Declare(
  argparse
  GIT_REPOSITORY https://github.com/cofyc/argparse.git
  GIT_TAG        v1.1
)

FetchContent_MakeAvailable(argparse)
EOF
```

### CMakeLists.txt

```bash
cat > .CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.15)
project(c-tooling LANGUAGES C)

include(GNUInstallDirs)

list(APPEND CMAKE_MODULE_PATH "\${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(deps)

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
add_executable(creetings
    src/creetings.c
)

target_link_libraries(creetings
    PRIVATE
        argparse
)
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
