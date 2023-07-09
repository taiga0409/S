cmake_minimum_required(VERSION 3.16)
enable_language(CXX)
set(CMAKE_CXX_STANDARD 20) # C++20...
set(CMAKE_CXX_STANDARD_REQUIRED ON) #...is required...
set(CMAKE_CXX_EXTENSIONS OFF) #...without compiler extensions like gnu++11
set(JSON_BuildTests OFF CACHE INTERNAL "")
set(CMAKE_BUILD_TYPE Debug)

find_library(PTHREAD_LIBRARY pthread)
find_package(PythonLibs 3 REQUIRED)
find_package(Python3 COMPONENTS Development NumPy)

# ビルドオプション
option(BUILD_MAIN_EXE ON)
option(BUILD_TEST_EXE ON)

project(ROBOT_NAME)

add_subdirectory(mcl)

# logディレクトリを作成
file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/../log)


# src内の.cppファイルを探索，SRC_FILEに格納
file(GLOB SRC_FILE RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ./src/*.cpp src/*/*.cpp)
message("SRC_FILE = ${SRC_FILE}")

add_library(
  ROBOT_NAME ${SRC_FILE}
)

target_include_directories(ROBOT_NAME PUBLIC
  include
)

target_link_libraries(ROBOT_NAME PUBLIC
  MCL
  ${PTHREAD_LIBRARY}
  Python3::Python Python3::NumPy
)

target_compile_options(ROBOT_NAME PRIVATE -O3 -g -Wall -Wextra -Wno-long-long -pedantic)

########
# main/
########
if(BUILD_MAIN_EXE)
  add_subdirectory(main)
endif(BUILD_MAIN_EXE)

########
# test/
########
if(BUILD_TEST_EXE)
  add_subdirectory(test)
endif(BUILD_TEST_EXE)
