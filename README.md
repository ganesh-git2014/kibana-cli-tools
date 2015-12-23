# kibana-cli-tools
bash cli commands to use - tested with kibana 3
To use it just modify the file fields for indexname, port, etc...(accordingly to your implementation) and source the file in bash.
This will provide you with the following commands:
## urlencode <string> - it will return the string url encoded - used to encode dashboard id's that have spaces or special characters(kibana requires encoding it).
## missing <file1> <file2> - it will return the lines that exists in file 1 but are missing from file 2
## pushDashboard <host> <id> <json file name> - sill send the json as a dashbaord
## getDashboard <host> <id> - will output json content to stdout
## transferDashboard <sourceHost> <destHost> <id>
## countDashboards <host>
## getDashboardIds <host>
## delDashboard <host> <id>
## getMissingDashboards <host1> <host2>

Hope it will help anyone - not tested on kibana 4 as we still use the older version.
