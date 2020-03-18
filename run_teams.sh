#!/bin/bash
# Wait until teams finishes
teams
pid=$(pgrep -x teams -o)
# https://stackoverflow.com/a/41613532
tail --pid="$pid" -f /dev/null
