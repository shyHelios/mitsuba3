# Install script for directory: E:/Code/mitsuba3/src/emitters

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/src/emitters/area.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/plugins/area.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/src/emitters/point.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/plugins/point.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/src/emitters/constant.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/plugins/constant.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/src/emitters/envmap.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/plugins/envmap.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/src/emitters/directional.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/plugins/directional.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/src/emitters/directionalarea.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/plugins/directionalarea.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/src/emitters/spot.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/plugins/spot.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/src/emitters/projector.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/plugins" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/plugins/projector.dll")
endif()

