# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "variant_msgs: 4 messages, 0 services")

set(MSG_I_FLAGS "-Ivariant_msgs:/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(variant_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg" NAME_WE)
add_custom_target(_variant_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "variant_msgs" "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg" ""
)

get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg" NAME_WE)
add_custom_target(_variant_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "variant_msgs" "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg" ""
)

get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Variant.msg" NAME_WE)
add_custom_target(_variant_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "variant_msgs" "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Variant.msg" "variant_msgs/VariantHeader:variant_msgs/VariantType"
)

get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Test.msg" NAME_WE)
add_custom_target(_variant_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "variant_msgs" "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Test.msg" "std_msgs/Bool:std_msgs/Header:std_msgs/String"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/variant_msgs
)
_generate_msg_cpp(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/variant_msgs
)
_generate_msg_cpp(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Variant.msg"
  "${MSG_I_FLAGS}"
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg;/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/variant_msgs
)
_generate_msg_cpp(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Test.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Bool.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/String.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/variant_msgs
)

### Generating Services

### Generating Module File
_generate_module_cpp(variant_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/variant_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(variant_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(variant_msgs_generate_messages variant_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_cpp _variant_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_cpp _variant_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Variant.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_cpp _variant_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Test.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_cpp _variant_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(variant_msgs_gencpp)
add_dependencies(variant_msgs_gencpp variant_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS variant_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/variant_msgs
)
_generate_msg_eus(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/variant_msgs
)
_generate_msg_eus(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Variant.msg"
  "${MSG_I_FLAGS}"
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg;/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/variant_msgs
)
_generate_msg_eus(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Test.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Bool.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/String.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/variant_msgs
)

### Generating Services

### Generating Module File
_generate_module_eus(variant_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/variant_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(variant_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(variant_msgs_generate_messages variant_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_eus _variant_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_eus _variant_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Variant.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_eus _variant_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Test.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_eus _variant_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(variant_msgs_geneus)
add_dependencies(variant_msgs_geneus variant_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS variant_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/variant_msgs
)
_generate_msg_lisp(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/variant_msgs
)
_generate_msg_lisp(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Variant.msg"
  "${MSG_I_FLAGS}"
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg;/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/variant_msgs
)
_generate_msg_lisp(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Test.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Bool.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/String.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/variant_msgs
)

### Generating Services

### Generating Module File
_generate_module_lisp(variant_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/variant_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(variant_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(variant_msgs_generate_messages variant_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_lisp _variant_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_lisp _variant_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Variant.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_lisp _variant_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Test.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_lisp _variant_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(variant_msgs_genlisp)
add_dependencies(variant_msgs_genlisp variant_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS variant_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/variant_msgs
)
_generate_msg_nodejs(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/variant_msgs
)
_generate_msg_nodejs(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Variant.msg"
  "${MSG_I_FLAGS}"
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg;/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/variant_msgs
)
_generate_msg_nodejs(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Test.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Bool.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/String.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/variant_msgs
)

### Generating Services

### Generating Module File
_generate_module_nodejs(variant_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/variant_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(variant_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(variant_msgs_generate_messages variant_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_nodejs _variant_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_nodejs _variant_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Variant.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_nodejs _variant_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Test.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_nodejs _variant_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(variant_msgs_gennodejs)
add_dependencies(variant_msgs_gennodejs variant_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS variant_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/variant_msgs
)
_generate_msg_py(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/variant_msgs
)
_generate_msg_py(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Variant.msg"
  "${MSG_I_FLAGS}"
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg;/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/variant_msgs
)
_generate_msg_py(variant_msgs
  "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Test.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Bool.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/String.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/variant_msgs
)

### Generating Services

### Generating Module File
_generate_module_py(variant_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/variant_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(variant_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(variant_msgs_generate_messages variant_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantType.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_py _variant_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/VariantHeader.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_py _variant_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Variant.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_py _variant_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/elliottwhite/proj515_ws/src/variant/variant_msgs/msg/Test.msg" NAME_WE)
add_dependencies(variant_msgs_generate_messages_py _variant_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(variant_msgs_genpy)
add_dependencies(variant_msgs_genpy variant_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS variant_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/variant_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/variant_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(variant_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/variant_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/variant_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(variant_msgs_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/variant_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/variant_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(variant_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/variant_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/variant_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(variant_msgs_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/variant_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/variant_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/variant_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(variant_msgs_generate_messages_py std_msgs_generate_messages_py)
endif()
