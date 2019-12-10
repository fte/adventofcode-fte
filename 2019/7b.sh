#!/usr/bin/env bash

socat -lmlocal2  tcp-listen:12071,reuseaddr,fork exec:'./5b.php "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5"' &
socat -lmlocal2  tcp-listen:12072,reuseaddr,fork exec:'./5b.php "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5"' &
socat -lmlocal2  tcp-listen:12073,reuseaddr,fork exec:'./5b.php "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5"' &
socat -lmlocal2  tcp-listen:12074,reuseaddr,fork exec:'./5b.php "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5"' &
socat -lmlocal2  tcp-listen:12075,reuseaddr,fork exec:'./5b.php "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5"' &

rm -f all;
# shuf -e {5..9}{5..9}{5..9}{5..9}{5..9}|grep -vE "(.).*\1{1,}"| sed -E "s/(.)/\1 /g" |while read a b c d e; do
# echo "9 8 7 6 5"|while read a b c d e; do
echo "9 7 8 5 6"|while read a b c d e; do
    out=$({ echo $a; echo "0"; } | nc localhost 12071)
    echo $out;
    # out=$({ echo $b; echo $out; } | nc localhost 12072)
    # echo $out;
    # out=$({ echo $c; echo $out; } | nc localhost 12073)
    # echo $out;
    # out=$({ echo $d; echo $out; } | nc localhost 12074)
    # echo $out;
    # out=$({ echo $e; echo $out; } | nc localhost 12075)
    # echo $out;
    # for i in {1..5};do
    #     out=$(echo $out | nc localhost "1207${i}")
    #     echo $out;
    #     # echo "$!";
    # done
done
# cat all | sort -nr |head -n 1
# sort -n output | tail -1