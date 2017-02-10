#!/bin/bash
Echo "Deploying release to dev for Build ID: $BUILDID"
azure servicefabric application package copy dhclient fabric:ImageStore
azure servicefabric application type register dhclient
azure servicefabric application create fabric:/dh dhMobile 1.0.0
