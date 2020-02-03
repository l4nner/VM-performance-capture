#!/bin/bash
 
# change this four line section to reflect your scenario ----------
compId="<compartment id>"
instId="<VM instance id>"
startTime="2020-01-20T23:45Z"    # example for January 20th, 2020. 23:45 hours. UTC.
endTime="2020-01-21T00:15Z"
# -----------------------------------------------------------------
 
declare -a perfCounters=("CpuUtilization" \
                         "DiskBytesRead" \
                         "DiskBytesWritten" \
                         "DiskIopsRead" \
                         "DiskIopsWritten" \
                         "MemoryUtilization" \
                         "NetworksBytesIn" \
                         "NetworksBytesOut")
 
for perfCounter in ${perfCounters[@]}
do
  oci monitoring metric-data summarize-metrics-data -c $compId --namespace oci_computeagent \
    --query-text "$perfCounter[1m]{resourceId=$instId}.avg()" --start-time $startTime \
    --end-time $endTime
done
