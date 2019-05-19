# Install script for directory: /home/elliottwhite/proj515_ws/src/waypoint_navigation

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/elliottwhite/proj515_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
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

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/waypoint_navigation/action" TYPE FILE FILES "/home/elliottwhite/proj515_ws/src/waypoint_navigation/action/goToWaypoint.action")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/waypoint_navigation/msg" TYPE FILE FILES
    "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointAction.msg"
    "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg"
    "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg"
    "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg"
    "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg"
    "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg"
    "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/waypoint_navigation/cmake" TYPE FILE FILES "/home/elliottwhite/proj515_ws/build/waypoint_navigation/catkin_generated/installspace/waypoint_navigation-msg-paths.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/elliottwhite/proj515_ws/devel/include/waypoint_navigation")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/elliottwhite/proj515_ws/devel/share/roseus/ros/waypoint_navigation")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/elliottwhite/proj515_ws/devel/share/common-lisp/ros/waypoint_navigation")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/elliottwhite/proj515_ws/devel/share/gennodejs/ros/waypoint_navigation")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python" -m compileall "/home/elliottwhite/proj515_ws/devel/lib/python2.7/dist-packages/waypoint_navigation")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/elliottwhite/proj515_ws/devel/lib/python2.7/dist-packages/waypoint_navigation")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/elliottwhite/proj515_ws/build/waypoint_navigation/catkin_generated/installspace/waypoint_navigation.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/waypoint_navigation/cmake" TYPE FILE FILES "/home/elliottwhite/proj515_ws/build/waypoint_navigation/catkin_generated/installspace/waypoint_navigation-msg-extras.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/waypoint_navigation/cmake" TYPE FILE FILES
    "/home/elliottwhite/proj515_ws/build/waypoint_navigation/catkin_generated/installspace/waypoint_navigationConfig.cmake"
    "/home/elliottwhite/proj515_ws/build/waypoint_navigation/catkin_generated/installspace/waypoint_navigationConfig-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/waypoint_navigation" TYPE FILE FILES "/home/elliottwhite/proj515_ws/src/waypoint_navigation/package.xml")
endif()

