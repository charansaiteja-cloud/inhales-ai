# InhaleSkill AI — CMake build for the native inference engine.
# Produces a shared library consumed by Dart FFI on each platform.

cmake_minimum_required(VERSION 3.16)
project(InhaleInference LANGUAGES C CXX)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

if(ANDROID)
    set(ANDROID_ABI "${ANDROID_ABI}")
    message(STATUS "Building for Android ABI: ${ANDROID_ABI}")
endif()

set(INFERENCE_SOURCES
    inference/inhale_engine.cpp
)

# Optional: llama.cpp integration.
# When USE_LLAMA=ON, the llama.cpp source tree under native/llama.cpp is
# compiled and linked. Otherwise the stub engine is used.
option(USE_LLAMA "Build with llama.cpp integration" ON)

if(USE_LLAMA)
    message(STATUS "llama.cpp integration enabled")
    add_subdirectory(llama.cpp llama)
    add_library(inference SHARED ${INFERENCE_SOURCES})
    target_link_libraries(inference PRIVATE llama)
else()
    add_library(inference SHARED ${INFERENCE_SOURCES})
endif()

target_include_directories(inference PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/inference)

if(APPLE)
    set_target_properties(inference PROPERTIES
        FRAMEWORK TRUE
        FRAMEWORK_VERSION "1.0"
    )
endif()

if(WIN32)
    set_target_properties(inference PROPERTIES
        WINDOWS_EXPORT_ALL_SYMBOLS TRUE
    )
endif()