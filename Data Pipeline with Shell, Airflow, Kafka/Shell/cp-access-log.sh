# This script
# Extracts data from file into a CSV file.

# Download the access log file

wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"

# Unzip the file to extract the .txt file.
gunzip -f web-server-access-log.txt.gz

# Extract phase

echo "Extracating Data"

# Extract the columns 1-4 from file

cut -d"#" -f1,2,3,4 web-server-access-log.txt > extracted-data-web.txt

# Transfrom Phase
echo "Transforming Data"

# read the extracted data and replace the colons with commas.
tr "#" "," < extracted-data-web.txt > transformed-data-web.csv

# LOAD PHASE
echo "Loading Data"

# Send the instructions to connect to 'template1' and
# copy the file to the table 'users' through command pipeline.

echo "\c template1; \COPY access_log FROM '/home/project/transformed-data-web.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost

# # FINAL CHECK
# echo '\c template1; \\SELECT * from access_log;' | psql --username=postgres --host=localhost