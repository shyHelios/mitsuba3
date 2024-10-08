# Install script for directory: E:/Code/mitsuba3/ext/openexr/IlmBase/config

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/include/OpenEXR" TYPE FILE FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/ext/openexr/IlmBase/config/IlmBaseConfig.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/cmake/IlmBase" TYPE FILE FILES
    "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/ext/openexr/IlmBase/config/IlmBaseConfig.cmake"
    "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/ext/openexr/IlmBase/config/IlmBaseConfigVersion.cmake"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/mitsuba/cmake/IlmBase/IlmBaseTargets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/mitsuba/cmake/IlmBase/IlmBaseTargets.cmake"
         "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/ext/openexr/IlmBase/config/CMakeFiles/Export/1429a6f86cb046fa1bee4fbf9e2aee1d/IlmBaseTargets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/mitsuba/cmake/IlmBase/IlmBaseTargets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/mitsuba/cmake/IlmBase/IlmBaseTargets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/cmake/IlmBase" TYPE FILE FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/ext/openexr/IlmBase/config/CMakeFiles/Export/1429a6f86cb046fa1bee4fbf9e2aee1d/IlmBaseTargets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/cmake/IlmBase" TYPE FILE FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/ext/openexr/IlmBase/config/CMakeFiles/Export/1429a6f86cb046fa1bee4fbf9e2aee1d/IlmBaseTargets-release.cmake")
  endif()
endif()

