# Sets the minimum version of CMake required to build the native library.

cmake_minimum_required(VERSION 3.4.1)

find_library( log-lib log )

find_library( z-lib z )

add_subdirectory( ../assimp assimpbin )

include_directories(
                    ../assimp
                    ../assimp/include
                    ../assimp/contrib
                    ../assimp/contrib/irrXML
                    ../assimp/contrib/rapidjson/include
                    ../assimp/contrib/openddlparser/include
                    ${CMAKE_CURRENT_BINARY_DIR}/assimpbin/include
                    ${CMAKE_CURRENT_BINARY_DIR}/assimpbin
)

file(GLOB assimp_src
    "../assimp/code/Blend*.cpp"
    "../assimp/code/Blend*.h"
    "../assimp/code/MMD*.cpp"
    "../assimp/code/MMD*.h"
)

message( STATUS "ASSIMP Sources: " ${assimp_src} )

set ( assimpintegrationpath ${CMAKE_CURRENT_SOURCE_DIR}/../assimpintegration/build/intermediates/cmake/
                            ${BUILD_TYPE}/obj/${ANDROID_ABI}/libassimpintegration.so )

message( STATUS "ASSIMP Integration Path: " ${assimpintegrationpath} )

add_library( assimpintegration SHARED IMPORTED IMPORTED_LOCATION ${assimpintegrationpath} )

add_library( assimpintegrationAPI24 SHARED ${assimp_src} )

target_link_libraries( assimpintegrationAPI24 ${assimpintegration} ${log-lib} ${z-lib} )