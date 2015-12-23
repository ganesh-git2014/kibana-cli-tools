INDEX="kibana-int"
PORT="9200"
TMPFILE="/var/tmp/tmpDashbaord.json"

#urlencode <string> - it will return the string url encoded
urlencode () {
  if [ "$#" -ne 1 ]; then
    sed -e 's/%/%25/g;s/ /%20/g;s/ /%09/g;s/!/%21/g;s/"/%22/g;s/#/%23/g;s/\$/%24/g;s/\&/%26/g;s/'\''/%27/g;s/(/%28/g;s/)/%29/g;s/\*/%2a/g;s/+/%2b/g;s/,/%2c/g;s/-/%2d/g;s/\./%2e/g;s/\//%2f/g;s/:/%3a/g;s/;/%3b/g;s//%3e/g;s/?/%3f/g;s/@/%40/g;s/\[/%5b/g;s/\\/%5c/g;s/\]/%5d/g;s/\^/%5e/g;s/_/%5f/g;s/`/%60/g;s/{/%7b/g;s/|/%7c/g;s/}/%7d/g;s/~/%7e/g;s/      /%09/g'
  else
    echo $1 | sed -e 's/%/%25/g;s/ /%20/g;s/ /%09/g;s/!/%21/g;s/"/%22/g;s/#/%23/g;s/\$/%24/g;s/\&/%26/g;s/'\''/%27/g;s/(/%28/g;s/)/%29/g;s/\*/%2a/g;s/+/%2b/g;s/,/%2c/g;s/-/%2d/g;s/\./%2e/g;s/\//%2f/g;s/:/%3a/g;s/;/%3b/g;s//%3e/g;s/?/%3f/g;s/@/%40/g;s/\[/%5b/g;s/\\/%5c/g;s/\]/%5d/g;s/\^/%5e/g;s/_/%5f/g;s/`/%60/g;s/{/%7b/g;s/|/%7c/g;s/}/%7d/g;s/~/%7e/g;s/      /%09/g'
  fi
}


## Call: missing <file1> <file2> - it will return the lines that exists in file 1 but are missing from file 2
missing () {
  while read LINE
  do
    VALUE=$(echo $LINE | tr -d '\n')
    grep "$VALUE" $2 > /dev/null 2>&1 
    if [[ $? -ne 0 ]]; then
      echo $VALUE
    fi
  done < $1
}

## Call: pushDashboard <host> <id> <json file name> - sill send the json as a dashbaord
createDashboard () {
  curl -s -XPUT "http://$1:$PORT/$INDEX/dashboard/$2?pretty" -d @$3
}

## Call: getDashboard <host> <id> - will output json content to stdout
getDashboard () {
  curl -s -XGET "http://$1:$PORT/$INDEX/dashboard/$2/_source?pretty"
}

## Call: transferDashboard <sourceHost> <destHost> <id>
transferDashboard () {
  getDashboard $1 $3 > $TMPFILE
  createDashboard $2 $3 $TMPFILE
  rm -f $TMPFILE
}

## Call: countDashboards <host>
countDashboards () {
  curl -s -XGET "http://$1:$PORT/$INDEX/dashboard/_count?pretty" | grep count | awk '{print $3}' | tr -d ','
}

## getDashboardIds <host>
getDashboardIds () {
  SIZE=$(countDashboards $1 | tr -d '\n')
  curl -s -XGET "http://$1:$PORT/$INDEX/dashboard/_search?fields=id&_source=false&size=$SIZE&pretty" | grep '_id' | cut -d'"' -f4
}

## delDashboard <host> <id>
delDashboard () {
  curl -s -XDELETE "http://$1:$PORT/$INDEX/dashboard/$2?pretty"
}

## getMissingDashboards <host1> <host2>
getMissingDashboards () {
  getDashboardIds $1 > "$TMPFILE.1"
  getDashboardIds $2 > "$TMPFILE.2"
  missing "$TMPFILE.1" "$TMPFILE.2"
  rm -f "$TMPFILE.1" "$TMPFILE.2" 
}
