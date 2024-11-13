#! /bin/bash

url="http://10.0.17.6/Assignment.html"

html=$(curl -s "$url")

temp_rows=$(echo "$html" | \
sed -n '/The Tempeerature Read:/,/The Pressure Read:/p' | \
grep -Eo '<td>[^<]+</td>' | \
sed 's/<[^>]*>//g' | \
paste - -)

pressure_rows=$(echo "$html" | \
sed -n '/The Pressure Read:/,$p' | \
grep -Eo '<td>[^<]+</td>' | \
sed 's/<[^>]*>//g' | \
paste - -)

echo -e "Temperature\tPressure\tDate-Time"

temp_arr=($temp_rows)
pressure_arr=($pressure_rows)

for ((i = 0; i< ${#temp_arr[@]}; i+=2));
do
	temp="@{temp_arr[i]}"
	temp_date="${temp_arr[i+1]}"

	for ((j = 0; j< ${#pressure_arr[@]}; j+=2));
	do
		pressure="${pressure_arr[j]}"
		pressure_date="${pressure_arr[j+1]}"

		if [ "$temp_date" == "pressure_date" ];
		then
			echo -e "$temp\t\t$pressure\t\t$temp_date"
			break
		fi
	done
done
