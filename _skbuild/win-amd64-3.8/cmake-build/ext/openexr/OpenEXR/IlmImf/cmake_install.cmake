# Install script for directory: E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/ext/openexr/OpenEXR/IlmImf/IlmImf-mitsuba.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/IlmImf-mitsuba.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba/include/OpenEXR" TYPE FILE FILES
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfForward.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfExport.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfBoxAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfCRgbaFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfChannelList.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfChannelListAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfCompressionAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfDoubleAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfFloatAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfFrameBuffer.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfHeader.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfIO.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfInputFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfIntAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfLineOrderAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfMatrixAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfOpaqueAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfOutputFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfRgbaFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfStringAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfVecAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfHuf.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfWav.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfLut.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfArray.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfCompression.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfLineOrder.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfName.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfPixelType.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfVersion.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfXdr.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfConvert.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfPreviewImage.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfPreviewImageAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfChromaticities.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfChromaticitiesAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfKeyCode.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfKeyCodeAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfTimeCode.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfTimeCodeAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfRational.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfRationalAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfFramesPerSecond.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfStandardAttributes.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfStdIO.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfEnvmap.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfEnvmapAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfInt64.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfRgba.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfTileDescription.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfTileDescriptionAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfTiledInputFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfTiledOutputFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfTiledRgbaFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfRgbaYca.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfTestFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfThreading.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfB44Compressor.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfStringVectorAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfMultiView.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfAcesFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfMultiPartOutputFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfGenericOutputFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfMultiPartInputFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfGenericInputFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfPartType.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfPartHelper.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfOutputPart.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfTiledOutputPart.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfInputPart.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfTiledInputPart.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfDeepScanLineOutputFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfDeepScanLineOutputPart.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfDeepScanLineInputFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfDeepScanLineInputPart.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfDeepTiledInputFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfDeepTiledInputPart.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfDeepTiledOutputFile.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfDeepTiledOutputPart.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfDeepFrameBuffer.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfDeepCompositing.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfCompositeDeepScanLine.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfNamespace.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfDeepImageState.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfDeepImageStateAttribute.h"
    "E:/Code/mitsuba3/ext/openexr/OpenEXR/IlmImf/ImfFloatVectorAttribute.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba" TYPE STATIC_LIBRARY OPTIONAL FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/ext/zlib/zlib.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/mitsuba" TYPE SHARED_LIBRARY FILES "E:/Code/mitsuba3/_skbuild/win-amd64-3.8/cmake-build/Release/zlib1.dll")
endif()

