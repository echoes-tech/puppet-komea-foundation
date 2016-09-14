#!/bin/bash

APPLICATION_NAME="foundation"
APPLICATION_PATH="/opt/echoes/foundation/"

MEMORY_USAGE="-Xmx1024m -Xms256m"

JAVA_VERSION="1.8"

SCRIPT_PATH=$(cd "$(dirname "$0")" && pwd -P)
APPLICATION_HOME=$APPLICATION_PATH
export APPLICATION_HOME

getpid() {
    pid=`pgrep -f "java.*$APPLICATION_NAME"`
}

start() {
    getpid
    if [ -n "$pid" ]; then
        echo "$APPLICATION_NAME (pid $pid) is already running"
        exit 1
    fi

    if [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
        echo Found java executable in JAVA_HOME
        JAVA_CMD="$JAVA_HOME/bin/java"
    elif [[ -n "$JAVA" ]] && [[ -x "$JAVA" ]];  then
        echo Found java executable by JAVA
        JAVA_CMD="$JAVA"
    elif type -p java; then
        echo Found java executable in PATH
        JAVA_CMD=java
    else
        echo "Cannot find a Java JDK. Please set JAVA_HOME, JAVA executable or put java (>=1.8) in your PATH."
        exit 1
    fi

    if [[ "$JAVA_CMD" ]]; then
        version=$("$JAVA_CMD" -version 2>&1 | awk -F '"' '/version/ {print $2}')
        if [[ "$version" > $JAVA_VERSION ]]; then
        echo Java version "$version"
        else
        echo JAVA_CMD=$JAVA_CMD
        echo Java version "$version" is less than required $JAVA_VERSION
        exit 1
        fi
    fi

    cd "$APPLICATION_HOME"
    echo -n "APPLICATION_HOME="
    pwd

    nohup "$JAVA_CMD" $JAVA_OPTS $MEMORY_USAGE -jar $APPLICATION_NAME.jar > /var/log/foundation.log 2>&1 &

    echo -ne "Starting process"
    for i in {1..10}; do
        if ! [ -n "$pid" ]; then
            echo -ne "."
            sleep 1
            getpid
        fi
    done
    echo

    if [ -n "$pid" ]
        then status
        else echo "Error during $APPLICATION_NAME starting, see log for details."
    fi
}

stop() {
    status
    if [ -n "$pid" ]
    then
        echo -ne "Stopping process"
        kill -9 $pid
        res=$?
        for i in {1..10}; do
            if [ -n "$pid" ]; then
                echo -ne "."
                sleep 1
                getpid
            fi
        done
        echo
        if ! [ -n "$pid" ]
            then echo "$APPLICATION_NAME has been successfully stopped."
            else echo "Error during $APPLICATION_NAME stopping... $res"
        fi
    fi
}

status() {
    getpid
    if [ -n "$pid" ]
        then echo "$APPLICATION_NAME (pid $pid) is running..."
        else echo "$APPLICATION_NAME is NOT running"
    fi
}

#APPLICATION_FILE=$(find . -iregex '.*\(jar\)' -exec basename {} \;)
#APPLICATION_NAME="${APPLICATION_FILE%.*}"
#APPLICATION_NAME=$(find . -iregex '.*\(jar\)' -exec basename {} \; | cut -f 1 -d '.')
if [ -z "$APPLICATION_NAME" ]; then
  echo "Cannot find application jar file in directory $APPLICATION_HOME"
  exit 1
fi
echo "APPLICATION_NAME=$APPLICATION_NAME"

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    status)
        status
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo $"Usage: $0 {start|stop|restart|status}"
        exit 1
esac

exit 0
