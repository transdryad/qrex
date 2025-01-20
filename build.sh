#!/bin/bash
nasm -f bin -o qrex.out qrex64.nasm
chmod +x qrex.out
qrb=$(base64 -w0 qrex.out)
qr="data:application/octet-stream;base64,"
echo "String in qrcode: $qr$qrb"
qrencode -o qrex.png -s 1 -t PNG "$qr$qrb"