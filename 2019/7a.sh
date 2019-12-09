#!/usr/bin/env bash

rm -f all;
shuf -e {0..4}{0..4}{0..4}{0..4}{0..4}|grep -vE "(.).*\1{1,}"| sed -E "s/(.)/\1 /g" |while read a b c d e; do
# echo "$a,$b,$c,$d,$e";
# echo "4 3 2 1 0"|while read a b c d e; do
# echo "0 1 2 3 4"|while read a b c d e; do

    out=$({ echo $a; echo "0"; } | ./5b.php $1)
    out=$({ echo $b; echo $out; } | ./5b.php $1)
    out=$({ echo $c; echo $out; } | ./5b.php $1)
    out=$({ echo $d; echo $out; } | ./5b.php $1)
    out=$({ echo $e; echo $out; } | ./5b.php $1)

    echo $out >> all;
done
cat all | sort -nr |head -n 1