#!/usr/bin/awk -f

# Tests a string against a wildcarded string.
#
# wild - The wildcarded string.
# test - The string to test against the wildcarded string.
# stop - An optional wildcard stop character.
#
# Returns 1 if the test string matches, 0 if it does not.
function wildmatch(wild, test, stop) {
    split(wild, wildchar, "")
    wildidx = 1
    split(test, testchar, "")
    testidx = 1

    laststar = 0
    lastchar = 0

    while (1) {
        wildcount = 0
        if (wildchar[wildidx] == "*") {
            while (1) {
                wildcount++
                if (wildidx == length(wild))
                    break
                else if (wildchar[wildidx+1] != "*")
                    break
                wildidx++
            }
            while (1) {
                if (wildcount == 1 && testchar[testidx] == stop)
                    break
                if (wildchar[wildidx+1] == "?")
                    break
                if (testchar[testidx] == wildchar[wildidx+1])
                    break
                if (testidx == length(test))
                    return (wildidx == length(wild))
                testidx++
            }
            if (wildcount != 1 || testchar[testidx] != stop) {
                laststar = wildidx
                lastchar = testidx
            }
            wildidx++
        } else if (wildchar[wildidx] == "?") {
            testidx++
            wildidx++
        } else if (testchar[testidx] == wildchar[wildidx]) {
            testidx++
            wildidx++
        } else if (laststar) {
            wildidx = laststar
            testidx = lastchar+1
        } else {
            return 0
        }
        if (testidx > length(test) && wildidx > length(wild)) {
            return 1
        } else if (testidx > length(test) && wildchar[wildidx] != "*") {
            return 0
        } else if (wildidx > length(wild) && laststar) {
            wildidx = laststar
            testidx = lastchar+1
        } else if (wildidx > length(wild)) {
            return 0
        }
    }
}
