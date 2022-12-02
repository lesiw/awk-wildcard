#!/usr/bin/awk -f

# Tests a string against a wildcarded string.
#
# wild - The wildcarded string.
# test - The string to test against the wildcarded string.
# stop - An optional wildcard stop character.
#
# Returns 1 if the test string matches, 0 if it does not.
function wildmatch(wild, test, stop) {
    split(wild, w, "")
    split(test, t, "")

    wi = 1
    ti = 1
    wc = 0
    ls = 0
    lc = 0

    while (1) {
        if (w[wi] == "*") {
            wi++
            wc++
        } else if (!w[wi] && !t[ti]) {
            return 1
        } else if (!t[ti]) {
            return 0
        } else if (w[wi] == t[ti] || w[wi] == "?") {
            if (wc) {
                ls = ++wi
                lc = ti++
                wc = 0
            } else {
                ti++
                wi++
            }
        } else if (wc == 1 && t[ti] == stop) {
            wc = 0
        } else if (wc) {
            ti++
        } else if (ls) {
            wi = ls
            ti = ++lc
        } else {
            return 0
        }
    }
}
