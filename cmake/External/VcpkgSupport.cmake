set( VERSION "2023.02.24")
set( PROJECT_NAME "vcpkg")

set( BOOTSTRAP_COMMAND "${FETCHCONTENT_BASE_DIR}/${PROJECT_NAME}/${PROJECT_NAME}-${VERSION}/src/bootstrap-vcpkg.bat" )

ExternalProject_Add(
    ${PROJECT_NAME}
    PREFIX ${FETCHCONTENT_BASE_DIR}/${PROJECT_NAME}
    GIT_REPOSITORY      https://github.com/microsoft/vcpkg.git
    GIT_TAG             ${VERSION}
    SOURCE_DIR "${FETCHCONTENT_BASE_DIR}/${PROJECT_NAME}/${PROJECT_NAME}-${VERSION}/src/"
    SOURCE_SUBDIR ""
    BINARY_DIR "${FETCHCONTENT_BASE_DIR}/${PROJECT_NAME}/${PROJECT_NAME}-${VERSION}/build"
    INSTALL_DIR "${FETCHCONTENT_BASE_DIR}/${PROJECT_NAME}/${PROJECT_NAME}-${VERSION}/install"
	CONFIGURE_COMMAND ${BOOTSTRAP_COMMAND}
	BUILD_COMMAND ""
	INSTALL_COMMAND ""
    CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DCMAKE_DEBUG_POSTFIX:STRING=-d
)

list(APPEND DEPENDENCIES ${PROJECT_NAME})

set(VCPKG_EXE "${FETCHCONTENT_BASE_DIR}/${PROJECT_NAME}/${PROJECT_NAME}-${VERSION}/src/vcpkg.exe")
set(VCPKG_TOOLCHAIN_DIR "${FETCHCONTENT_BASE_DIR}/${PROJECT_NAME}/${PROJECT_NAME}-${VERSION}/src/scripts/buildsystems")
set(VCPKG_MANIFEST_DIR "${CMAKE_SOURCE_DIR}/.vcpkg")

list(APPEND EXTRA_CMAKE_ARGS
    -DVCPKG_EXE:PATH=${VCPKG_EXE}
	-DVCPKG_TOOLCHAIN_DIR:PATH=${VCPKG_TOOLCHAIN_DIR}
	-DVCPKG_MANIFEST_DIR:PATH=${VCPKG_MANIFEST_DIR}
	-DVCPKG_MANIFEST_MODE:BOOL=ON
	-DCMAKE_TOOLCHAIN_FILE:PATH=${VCPKG_TOOLCHAIN_DIR}/vcpkg.cmake
)

# use git pull to update package info