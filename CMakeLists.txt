cmake_minimum_required(VERSION 3.9)

project(QtCreatorSuper)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_CXX_STANDARD 14)

list(APPEND CMAKE_PREFIX_PATH
  ${CMAKE_BINARY_DIR}/cmake
)

set(QTC_MERGE_BINARY_DIR YES)
add_subdirectory(qtcreator)

function(check_add_subdirectory directory)
  if (EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${directory}/CMakeLists.txt)
    add_subdirectory(${directory})
  endif()
endfunction()
