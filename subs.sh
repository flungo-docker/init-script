#!/bin/bash

# Makes substitutions for variables in output file.
# Expects environment variables to be set.
# Should not be run manually

# Insert of hook scripts

if [ -f $PRE_START_SCRIPT ]; then
  # Insert after BEGIN tag
  sed -i "/### BEGIN PRE_START_SCRIPT ###/{
    r $PRE_START_SCRIPT
  }" $OUTPUT
fi

if [ -f $POST_START_SCRIPT ]; then
  # Insert after BEGIN tag
  sed -i "/### BEGIN POST_START_SCRIPT ###/{
    r $POST_START_SCRIPT
  }" $OUTPUT
fi

if [ -f $PRE_STOP_SCRIPT ]; then
  # Insert after BEGIN tag
  sed -i "/### BEGIN PRE_STOP_SCRIPT ###/{
    r $PRE_STOP_SCRIPT
  }" $OUTPUT
fi

if [ -f $POST_STOP_SCRIPT ]; then
  # Insert after BEGIN tag
  sed -i "/### BEGIN POST_STOP_SCRIPT ###/{
    r $POST_STOP_SCRIPT
  }" $OUTPUT
fi

if [ -f $PRE_RESTART_SCRIPT ]; then
  # Insert after BEGIN tag
  sed -i "/### BEGIN PRE_RESTART_SCRIPT ###/{
    r $PRE_RESTART_SCRIPT
  }" $OUTPUT
fi

if [ -f $POST_RESTART_SCRIPT ]; then
  # Insert after BEGIN tag
  sed -i "/### BEGIN POST_RESTART_SCRIPT ###/{
    r $POST_RESTART_SCRIPT
  }" $OUTPUT
fi

if [ -f $PRE_PAUSE_SCRIPT ]; then
  # Insert after BEGIN tag
  sed -i "/### BEGIN PRE_PAUSE_SCRIPT ###/{
    r $PRE_PAUSE_SCRIPT
  }" $OUTPUT
fi

if [ -f $POST_PAUSE_SCRIPT ]; then
  # Insert after BEGIN tag
  sed -i "/### BEGIN POST_PAUSE_SCRIPT ###/{
    r $POST_PAUSE_SCRIPT
  }" $OUTPUT
fi

if [ -f $PRE_UNPAUSE_SCRIPT ]; then
  # Insert after BEGIN tag
  sed -i "/### BEGIN PRE_UNPAUSE_SCRIPT ###/{
    r $PRE_UNPAUSE_SCRIPT
  }" $OUTPUT
fi

if [ -f $POST_UNPAUSE_SCRIPT ]; then
  # Insert after BEGIN tag
  sed -i "/### BEGIN POST_UNPAUSE_SCRIPT ###/{
    r $POST_UNPAUSE_SCRIPT
  }" $OUTPUT
fi

# Basic variable substitutions - done after hook scripts to allow use of tags
# in user hook scripts
sed -i "s/<DESCRIPTION>/$DESCRIPTION/g" $OUTPUT
sed -i "s/<SERVICE>/$SERVICE/g" $OUTPUT
sed -i "s/<CONTAINER>/$CONTAINER/g" $OUTPUT
