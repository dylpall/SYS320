#/!bin/bash


:> "report.html"
echo "<html><head><h3>Access logs with IOC indicators:</h3></head>" >> "report.html"
echo "<body>" >> "report.html"
echo "<table style='border: 1px solid;'>" >> "report.html"

report=$(cat report.txt)

IFS=$'\n'

for row in $report
do

echo "<tr>" >> "report.html"
IFS=" "
for item in $row
do
	echo "<td style='border: 1px solid;'>$item</td>" >> "report.html"
done
	echo "</tr>" >> "report.html"
done

echo "</table></body></html>" >> "report.html"


mv "report.html" "/var/www/html/"
