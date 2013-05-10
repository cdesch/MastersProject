#!/bin/sh
#find . -regex "*.\(h\|m\|mm\)" | xargs enscript --color=1 -C -M Letter -Ecpp -fCourier8 -o - | ps2pdf - code.pdf
find .   -name "*.h" -o -name "*.mm" -o -name "*.m" -maxdepth 0 -type f  | xargs enscript --color=1 -C -M Letter -Ecpp -fCourier8 -o - | ps2pdf - code.pdf

#-regex ".*\.\(jpg\|gif\|png\|jpeg\)"