#! /bin/bash
clear

url="http://10.0.17.6/Assignment.html"

page=$(curl -sL "$url")

temp=( $( \
echo "$page" | \
xmllint --xpath "//table[@id='temp']//td" - | \
awk -F "[><]" '{print $3}'
) )

pres=( $( \
echo "$page" | \
xmllint --xpath "//table[@id='press']//td" - | \
awk -F "[><]" '{print $3}'

) )

for ((i=0; i<"${#temp[@]}"; i+=2)) {
echo "${pres[$i]}  ${temp[$i]}  ${temp[$i+1]}"
}
