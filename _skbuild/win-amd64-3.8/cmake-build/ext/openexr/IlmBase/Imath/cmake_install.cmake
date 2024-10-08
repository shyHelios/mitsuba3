# Install script for directory: E:/Code/mitsuba3/ext/openexr/IlmBase/Imath

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/ext/openexr/IlmBase/Imath/Imath-mitsuba.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/Imath-mitsuba.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/include/OpenEXR" TYPE FILE FILES
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathBoxAlgo.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathBox.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathColorAlgo.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathColor.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathEuler.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathExc.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathExport.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathForward.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathFrame.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathFrustum.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathFrustumTest.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathFun.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathGL.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathGLU.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathHalfLimits.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathInt64.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathInterval.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathLimits.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathLineAlgo.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathLine.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathMath.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathMatrixAlgo.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathMatrix.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathNamespace.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathPlane.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathPlatform.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathQuat.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathRandom.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathRoots.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathShear.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathSphere.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathVecAlgo.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Imath/ImathVec.h"
    )
endif()

