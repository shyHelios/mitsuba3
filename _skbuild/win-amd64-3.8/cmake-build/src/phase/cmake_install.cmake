# Install script for directory: E:/Code/mitsuba3/src/phase

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/src/phase/hg.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/plugins/hg.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/src/phase/isotropic.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/plugins/isotropic.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/src/phase/blendphase.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/plugins/blendphase.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/src/phase/rayleigh.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/plugins/rayleigh.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/src/phase/sggx.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/plugins/sggx.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/src/phase/tabphase.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/plugins/tabphase.dll")
endif()

