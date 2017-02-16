#!/bin/bash
curl -G -v "https://slack.com/api/chat.postMessage?token=$1" \
--data-urlencode "channel=#vsts-dh-build" \
--data-urlencode "text=$2" \
--data-urlencode "username=VSTS Build" \
--data-urlencode "as_user=false" \
--data-urlencode "pretty=1"
