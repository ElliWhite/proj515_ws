execute_process(COMMAND "/home/elliottwhite/proj515_ws/build/rqt_multiplot_plugin/rqt_multiplot/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/elliottwhite/proj515_ws/build/rqt_multiplot_plugin/rqt_multiplot/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
