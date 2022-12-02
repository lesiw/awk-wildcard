#!/usr/bin/awk -f

# Tests a string against a wildcarded string.
#
# wild - The wildcarded string.
# test - The string to test against the wildcarded string.
# stop - An optional wildcard stop character.
#
# Returns 1 if the test string matches, 0 if it does not.
function wildmatch(wild, test, stop,    wi, ti, sc, ws, ts, ss) {
    split(wild, w, ""); wi = 1
    split(test, t, ""); ti = 1
    while (1) {
        if (w[wi] == "*") {
            wi++
            sc++
        } else if (!t[ti]) {
            return !w[wi]
        } else if (sc == 1 && t[ti] == stop) {
            sc = 0
        } else if (w[wi] == t[ti] || w[wi] == "?") {
            if (sc) {
                ws = wi
                ts = ti
                ss = sc
                sc = 0
            }
            wi++
            ti++
        } else if (sc) {
            ti++
        } else if (ws) {
            sc = ss
            if (t[ti] == stop && sc < 2) return 0
            wi = ws
            ti = ++ts
        } else {
            return 0
        }
    }
}
