# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "waypoint_navigation: 7 messages, 0 services")

set(MSG_I_FLAGS "-Iwaypoint_navigation:/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg;-Iactionlib_msgs:/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg;-Imove_base_msgs:/opt/ros/kinetic/share/move_base_msgs/cmake/../msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(waypoint_navigation_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg" NAME_WE)
add_custom_target(_waypoint_navigation_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "waypoint_navigation" "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg" "waypoint_navigation/goToWaypointGoal:std_msgs/Header:geometry_msgs/Quaternion:geometry_msgs/Point:geometry_msgs/PoseStamped:geometry_msgs/Pose:move_base_msgs/MoveBaseGoal:actionlib_msgs/GoalID:move_base_msgs/MoveBaseActionGoal"
)

get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointAction.msg" NAME_WE)
add_custom_target(_waypoint_navigation_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "waypoint_navigation" "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointAction.msg" "actionlib_msgs/GoalStatusArray:waypoint_navigation/goToWaypointGoal:std_msgs/Header:waypoint_navigation/goToWaypointActionGoal:geometry_msgs/Quaternion:waypoint_navigation/goToWaypointActionResult:geometry_msgs/Point:waypoint_navigation/goToWaypointActionFeedback:move_base_msgs/MoveBaseActionResult:waypoint_navigation/goToWaypointResult:geometry_msgs/PoseStamped:geometry_msgs/Pose:move_base_msgs/MoveBaseGoal:move_base_msgs/MoveBaseResult:waypoint_navigation/goToWaypointFeedback:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:move_base_msgs/MoveBaseActionGoal"
)

get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg" NAME_WE)
add_custom_target(_waypoint_navigation_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "waypoint_navigation" "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg" "actionlib_msgs/GoalStatusArray:waypoint_navigation/goToWaypointFeedback:actionlib_msgs/GoalID:std_msgs/Header:actionlib_msgs/GoalStatus"
)

get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg" NAME_WE)
add_custom_target(_waypoint_navigation_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "waypoint_navigation" "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg" "move_base_msgs/MoveBaseActionResult:actionlib_msgs/GoalID:move_base_msgs/MoveBaseResult:std_msgs/Header:actionlib_msgs/GoalStatus"
)

get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg" NAME_WE)
add_custom_target(_waypoint_navigation_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "waypoint_navigation" "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg" "actionlib_msgs/GoalID:move_base_msgs/MoveBaseActionGoal:geometry_msgs/Quaternion:geometry_msgs/Point:geometry_msgs/PoseStamped:move_base_msgs/MoveBaseGoal:geometry_msgs/Pose:std_msgs/Header"
)

get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg" NAME_WE)
add_custom_target(_waypoint_navigation_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "waypoint_navigation" "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg" "std_msgs/Header:move_base_msgs/MoveBaseResult:move_base_msgs/MoveBaseActionResult:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:waypoint_navigation/goToWaypointResult"
)

get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg" NAME_WE)
add_custom_target(_waypoint_navigation_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "waypoint_navigation" "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg" "actionlib_msgs/GoalStatusArray:actionlib_msgs/GoalID:std_msgs/Header:actionlib_msgs/GoalStatus"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseGoal.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_cpp(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointAction.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatusArray.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionResult.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseGoal.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseResult.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_cpp(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatusArray.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_cpp(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseResult.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_cpp(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatusArray.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_cpp(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseResult.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_cpp(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionGoal.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseGoal.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/waypoint_navigation
)

### Generating Services

### Generating Module File
_generate_module_cpp(waypoint_navigation
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/waypoint_navigation
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(waypoint_navigation_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(waypoint_navigation_generate_messages waypoint_navigation_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_cpp _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointAction.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_cpp _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_cpp _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_cpp _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_cpp _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_cpp _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_cpp _waypoint_navigation_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(waypoint_navigation_gencpp)
add_dependencies(waypoint_navigation_gencpp waypoint_navigation_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS waypoint_navigation_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseGoal.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_eus(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointAction.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatusArray.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionResult.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseGoal.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseResult.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_eus(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatusArray.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_eus(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseResult.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_eus(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatusArray.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_eus(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseResult.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_eus(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionGoal.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseGoal.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/waypoint_navigation
)

### Generating Services

### Generating Module File
_generate_module_eus(waypoint_navigation
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/waypoint_navigation
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(waypoint_navigation_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(waypoint_navigation_generate_messages waypoint_navigation_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_eus _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointAction.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_eus _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_eus _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_eus _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_eus _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_eus _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_eus _waypoint_navigation_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(waypoint_navigation_geneus)
add_dependencies(waypoint_navigation_geneus waypoint_navigation_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS waypoint_navigation_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseGoal.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_lisp(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointAction.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatusArray.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionResult.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseGoal.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseResult.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_lisp(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatusArray.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_lisp(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseResult.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_lisp(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatusArray.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_lisp(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseResult.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_lisp(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionGoal.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseGoal.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/waypoint_navigation
)

### Generating Services

### Generating Module File
_generate_module_lisp(waypoint_navigation
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/waypoint_navigation
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(waypoint_navigation_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(waypoint_navigation_generate_messages waypoint_navigation_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_lisp _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointAction.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_lisp _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_lisp _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_lisp _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_lisp _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_lisp _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_lisp _waypoint_navigation_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(waypoint_navigation_genlisp)
add_dependencies(waypoint_navigation_genlisp waypoint_navigation_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS waypoint_navigation_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseGoal.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_nodejs(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointAction.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatusArray.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionResult.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseGoal.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseResult.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_nodejs(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatusArray.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_nodejs(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseResult.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_nodejs(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatusArray.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_nodejs(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseResult.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_nodejs(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionGoal.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseGoal.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/waypoint_navigation
)

### Generating Services

### Generating Module File
_generate_module_nodejs(waypoint_navigation
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/waypoint_navigation
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(waypoint_navigation_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(waypoint_navigation_generate_messages waypoint_navigation_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_nodejs _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointAction.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_nodejs _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_nodejs _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_nodejs _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_nodejs _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_nodejs _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_nodejs _waypoint_navigation_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(waypoint_navigation_gennodejs)
add_dependencies(waypoint_navigation_gennodejs waypoint_navigation_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS waypoint_navigation_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseGoal.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_py(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointAction.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatusArray.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionResult.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseGoal.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseResult.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_py(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatusArray.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_py(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseResult.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_py(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatusArray.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_py(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseResult.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/waypoint_navigation
)
_generate_msg_py(waypoint_navigation
  "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseActionGoal.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/move_base_msgs/cmake/../msg/MoveBaseGoal.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/waypoint_navigation
)

### Generating Services

### Generating Module File
_generate_module_py(waypoint_navigation
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/waypoint_navigation
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(waypoint_navigation_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(waypoint_navigation_generate_messages waypoint_navigation_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionGoal.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_py _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointAction.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_py _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionFeedback.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_py _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointResult.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_py _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointGoal.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_py _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointActionResult.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_py _waypoint_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/devel/share/waypoint_navigation/msg/goToWaypointFeedback.msg" NAME_WE)
add_dependencies(waypoint_navigation_generate_messages_py _waypoint_navigation_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(waypoint_navigation_genpy)
add_dependencies(waypoint_navigation_genpy waypoint_navigation_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS waypoint_navigation_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/waypoint_navigation)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/waypoint_navigation
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET actionlib_msgs_generate_messages_cpp)
  add_dependencies(waypoint_navigation_generate_messages_cpp actionlib_msgs_generate_messages_cpp)
endif()
if(TARGET move_base_msgs_generate_messages_cpp)
  add_dependencies(waypoint_navigation_generate_messages_cpp move_base_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/waypoint_navigation)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/waypoint_navigation
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET actionlib_msgs_generate_messages_eus)
  add_dependencies(waypoint_navigation_generate_messages_eus actionlib_msgs_generate_messages_eus)
endif()
if(TARGET move_base_msgs_generate_messages_eus)
  add_dependencies(waypoint_navigation_generate_messages_eus move_base_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/waypoint_navigation)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/waypoint_navigation
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET actionlib_msgs_generate_messages_lisp)
  add_dependencies(waypoint_navigation_generate_messages_lisp actionlib_msgs_generate_messages_lisp)
endif()
if(TARGET move_base_msgs_generate_messages_lisp)
  add_dependencies(waypoint_navigation_generate_messages_lisp move_base_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/waypoint_navigation)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/waypoint_navigation
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET actionlib_msgs_generate_messages_nodejs)
  add_dependencies(waypoint_navigation_generate_messages_nodejs actionlib_msgs_generate_messages_nodejs)
endif()
if(TARGET move_base_msgs_generate_messages_nodejs)
  add_dependencies(waypoint_navigation_generate_messages_nodejs move_base_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/waypoint_navigation)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/waypoint_navigation\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/waypoint_navigation
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET actionlib_msgs_generate_messages_py)
  add_dependencies(waypoint_navigation_generate_messages_py actionlib_msgs_generate_messages_py)
endif()
if(TARGET move_base_msgs_generate_messages_py)
  add_dependencies(waypoint_navigation_generate_messages_py move_base_msgs_generate_messages_py)
endif()
