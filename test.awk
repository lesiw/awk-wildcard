#!/usr/bin/awk -f

BEGIN {
    FS = ","
}
{
    got = wildmatch($1, $2, $3)
    if (got != $4) {
        print("wild: " $1 "  test: " $2 "  got: " got "  want: " $4)
        err = 1
    }
}
END {
    exit err
}
