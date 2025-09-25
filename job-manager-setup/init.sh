#!/bin/sh

# Copyright (C) 2025 NEC Corporation.
# 
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

# Maximum number of retries
MAX_RETRIES=10
# Retry interval (seconds)
RETRY_INTERVAL=10
#API KEY
API_KEY=`head -n 1 ./tokens.properties`
API_KEY=$(echo "$API_KEY" | cut -d' ' -f2)
API_KEY=$(echo "$API_KEY" | cut -d',' -f1)

i=1
while [ $i -le $MAX_RETRIES ]; do
  # Create a project
  STATUS=$(curl -s -X POST 'http://job-manager:4440/api/14/projects' -H "X-Rundeck-Auth-Token: $API_KEY" -H "Content-Type: application/json" -d '{"name":"CDIM"}' -o /dev/null -w '%{http_code}\n' -s)
  if [ $STATUS -eq 201 ]; then
    # Import project(CDIM)
    curl -X PUT 'http://job-manager:4440/api/14/project/CDIM/import?importConfig=true' -H "X-Rundeck-Auth-Token: $API_KEY" -H "Content-Type: application/zip" --data-binary '@CDIM-project.zip'
    # Import job(HW_configuration_information_data_linkage_job)
    curl -X POST 'http://job-manager:4440/api/14/project/CDIM/jobs/import?fileformat=yaml' -H "X-Rundeck-Auth-Token: $API_KEY" -H "Content-Type: application/yaml" --data-binary '@HW_configuration_information_data_linkage_job.yaml'
    # Import job(Alert_manager_housekeeping_job)
    curl -X POST 'http://job-manager:4440/api/14/project/CDIM/jobs/import?fileformat=yaml' -H "X-Rundeck-Auth-Token: $API_KEY" -H "Content-Type: application/yaml" --data-binary '@Alert_manager_housekeeping_job.yaml'

    exit 0
  elif  [ $STATUS -eq 409 ]; then
    exit 0
  fi

  if [ $i -eq $MAX_RETRIES ]; then
    exit 1
  fi

  sleep $RETRY_INTERVAL
  i=$((i+1))
done







