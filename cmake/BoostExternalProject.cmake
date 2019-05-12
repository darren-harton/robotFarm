#[[ CMake guard. ]]
if(TARGET BoostExternalProject)
    return()
endif()

# Include dependencies.
include(ExternalProject)
include(${CMAKE_CURRENT_LIST_DIR}/PythonExternalProject.cmake)

ExternalProject_Add(BoostExternalProject
        PREFIX                  ${CMAKE_CURRENT_BINARY_DIR}/boost
        URL                     https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.gz
        DOWNLOAD_NO_PROGRESS    ON

        CONFIGURE_COMMAND       LD_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib:$ENV{LD_LIBRARY_PATH}
                                PATH=${CMAKE_INSTALL_PREFIX}/bin:$ENV{PATH} <SOURCE_DIR>/bootstrap.sh
                                --prefix=${CMAKE_INSTALL_PREFIX} --with-python-root=${CMAKE_INSTALL_PREFIX}

        BUILD_COMMAND           <SOURCE_DIR>/b2 install
        BUILD_IN_SOURCE         ON
        INSTALL_COMMAND         "")

add_dependencies(BoostExternalProject Python3ExternalProject)