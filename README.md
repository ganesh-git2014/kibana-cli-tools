# kibana-cli-tools
bash cli commands to use - tested with kibana 3
While working witgh kibana we had the need to be able to backup and restore dashboards, maybe transfer dashboard between 2 elasticsearch clusters(used to store kibana dashboards among other stuff).
To use it just modify the top 3 fields in the file for indexname, port, etc...(accordingly to your implementation) and source the file in bash.

This will provide you with the following commands:
</br> urlencode \<string\> - it will return the string url encoded - used to encode dashboard id's that have spaces or special characters(kibana requires encoding it).
</br> missing \<file1\> \<file2\> - it will return the lines that exists in file 1 but are missing from file 2
</br> pushDashboard \<host\> \<id\> \<json file name\> - sill send the json as a dashbaord
</br> getDashboard \<host\> \<id\> - will output json content to stdout
</br> transferDashboard \<sourceHost\> \<destHost\> \<id\>
</br> countDashboards \<host\>
</br> getDashboardIds \<host\>
</br> delDashboard \<host\> \<id\>
</br> getMissingDashboards \<host1\> \<host2\>

BTW - the host parameter can be any host of an elasticsearch cluster.

Hope it will help anyone - not tested on kibana 4 as we still use the older version.
