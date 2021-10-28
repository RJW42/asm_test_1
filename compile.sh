#!/bin/bash
IN_NAME=first.asm
OUT_NAME=myos.iso

# Compile 
nasm -f bin $IN_NAME -o stage1.com
dd if=/dev/zero of=stage2.img bs=1024 count=1440
dd if=stage1.com of=stage2.img seek=0 count=1 conv=notrunc

mkdir stage3

cp stage2.img stage3/

genisoimage -quiet -V 'TEST_OS' -input-charset iso8859-1 -o $OUT_NAME -b stage2.img -hide stage2.img stage3/

# Cleanup 
rm stage1.com stage2.img 
rm -rf ./stage3