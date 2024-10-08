# Install script for directory: E:/Code/mitsuba3/ext/openexr/IlmBase/Iex

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/ext/openexr/IlmBase/Iex/Iex-mitsuba.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/Iex-mitsuba.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/include/OpenEXR" TYPE FILE FILES
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Iex/IexBaseExc.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Iex/IexMathExc.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Iex/IexThrowErrnoExc.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Iex/IexErrnoExc.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Iex/IexMacros.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Iex/Iex.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Iex/IexNamespace.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Iex/IexExport.h"
    "E:/Code/mitsuba3/ext/openexr/IlmBase/Iex/IexForward.h"
    )
endif()

