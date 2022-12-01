# Wildcard Matching in Awk

## Background

I needed this for a project, it turned out to be [non-trivial][1], now it lives
on GitHub.

## Usage

You can include `wildmatch` by prepending `-f wildcard.awk` to your `awk` call,
but in most cases, you’ll want to copy the function into your `awk` program.

## Testing

``` sh
awk -f wildcard.awk -f test.awk tests.txt
```

[1]: https://en.wikipedia.org/wiki/Matching_wildcards
