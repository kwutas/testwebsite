#!/bin/sh

# Based on https://stackoverflow.com/a/41643684

T='+%j*1440+%H*60+%M' # minutes in year: DAY/Y * 1440 min/d + H * 60 h/min + MIN
SED_ARG='s/^0\{1,\}\|\(+\)0\{1,\}\([[:digit:]]\)/\1\2/g'
Z=$(( ( $(date "$T" | sed "$SED_ARG") - ( $(date -u "$T" | sed "$SED_ARG") ) ) * 100 / 60 )) # TZ offset as hr*100

H=${Z%??} # hours ($Z is hundredths of hours, so we remove the last two digits)
if   [ "$H" -lt -13 ]; then H=$((H+8712))    # UTC is a year ahead
elif [ "$H" -gt  13 ]; then H=$((H%8736-24)) # UTC is a year behind
fi
if   [ "$H" -lt -13 ]; then H=$((H+24))      # UTC is a day ahead of a leap year
elif [ "$H" -gt  13 ]; then H=$((H-24))      # UTC is a day behind a leap year
fi

M=${Z#"$H"} # hundredths of hours (to become minutes on the next line)
if [ "$M" != 00 ]; then M=$(( "$M" * 60 / 100 )); fi # Minutes relative to 60/hr

printf '%+03d:%02d' "$H" "$M" # TZ offset in HHMM
