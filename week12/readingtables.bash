#! /bin/bash


curl -s "http://10.0.17.6/Assignment.html" -o page.html

xmllint --html --format page.html -o formatted_page.html 2>/dev/null

table1=$(awk '/<table/,/<\/table>/' formatted_page.html | head -n -1 | tail -n +2)
table2=$(awk '/<table/,/<\/table>/ {if (++count == 2) {print}}' formatted_page.html)

combined_table="<table>\n${table1}\n${table2}\n</table>"

echo -e "$combined_table"
