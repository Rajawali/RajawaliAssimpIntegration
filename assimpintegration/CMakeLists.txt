# Sets the minimum version of CMake required to build the native library.

cmake_minimum_required(VERSION 3.4.1)

find_library( log-lib log )

add_subdirectory( ../assimp assimpbin )
add_subdirectory( ../assimp/contrib/zlib assimp_zlib_bin )

include_directories(BEFORE SYSTEM
                    ${CMAKE_CURRENT_BINARY_DIR}/assimpbin/include
                    ${CMAKE_CURRENT_BINARY_DIR}/assimpbin
                    ${CMAKE_CURRENT_BINARY_DIR}/assimp_zlib_bin
                    ../assimp
                    ../assimp/include
                    ../assimp/contrib
                    ../assimp/contrib/irrXML
                    ../assimp/contrib/rapidjson/include
                    ../assimp/contrib/openddlparser/include
                    ../assimp/contrib/zlib
)

file(GLOB assimp_src
    "../assimp/code/*.cpp"
    "../assimp/code/*.c"
    "../assimp/code/*.h"
    "../assimp/code/*.hpp"
    "../assimp/contrib/clipper/*.cpp"
    "../assimp/contrib/clipper/*.hpp"
    "../assimp/contrib/irrXML/*.h"
    "../assimp/contrib/irrXML/*.cpp"
    "../assimp/contrib/Open3DGC/*.cpp"
    "../assimp/contrib/Open3DGC/*.h"
    "../assimp/contrib/openddlparser/code/*.cpp"
    "../assimp/contrib/poly2tri/poly2tri/common/*.cc"
    "../assimp/contrib/poly2tri/poly2tri/common/*.h"
    "../assimp/contrib/poly2tri/poly2tri/sweep/*.cc"
    "../assimp/contrib/poly2tri/poly2tri/sweep/*.h"
    "../assimp/contrib/poly2tri/poly2tri/*.h"
    "../assimp/contrib/unzip/*.c"
    "../assimp/contrib/unzip/*.h"
    "../assimp/contrib/utf8cpp/*.h"
    "../assimp/contrib/utf8cpp/source/*.h"
    "../assimp/contrib/utf8cpp/source/utf8/*.h"
    "../assimp/contrib/zlib/*.h"
    "../assimp/contrib/zlib/*.c"
)

list(REMOVE_ITEM assimp_src
    "../assimp/code/C4DImporter.cpp"
    "../assimp/code/C4DImporter.h"
)

message( STATUS "ASSIMP Sources: " ${assimp_src} )

add_library( assimpintegration SHARED src/main/cpp/native.c ${assimp_src} )

target_link_libraries( assimpintegration ${log-lib} )