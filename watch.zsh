# Watch files in infinite loop
watch () {
    # This script will re-run every time any of the specified files changes.
    #
    # $1: Command to execute
    # $*: Files to watch (can be a glob pattern)

    if (( $# < 2 ))
    then
        echo "Usage: watch <CMD> <FILES>"
        return 1
    fi

    # The command to execute
    CMD=$1
    shift

    # The files to watch
    FILES=$*;

    # Start the watch process
    echo "Watching files.."
    CTIME=$(date -j -f "%a %b %d %T %Z %Y" "`date`" "+%s")
    while :; do
        # Check if any files have changed
        for f in $(echo $FILES); do
            eval $(stat -s $f)
            if [ $? -eq 0 ]; then
                if [ $st_mtime -gt $CTIME ]; then
                    CTIME=$(date -j -f "%a %b %d %T %Z %Y" "`date`" "+%s")
                    echo 'Retrying: ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
                    # Run the command
                    eval $CMD
                    # If it succeeded
                    if [ $? -eq 0 ]; then
                        echo 'Succeeded: ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
                    # If it failed
                    else
                        echo 'Failed: ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
                    fi
                fi
            else
                echo "watch: $f is not a file."
                return 1
            fi
        done
    done
}

