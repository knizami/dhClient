#!/bin/bash
curl -G -v "https://slack.com/api/chat.postMessage?token=$SLACK_TOKEN" \
--data-urlencode "channel=#vsts-dh-build" \
--data-urlencode "text=$1" \
--data-urlencode "username=VSTS Build" \
--data-urlencode "as_user=false" \
--data-urlencode "pretty=1"
