#!/bin/bash
[ -z $BUILDID ] && { echo '$BUILDID is undefined, exiting.'; exit 1; }
echo "Deploying release to dev for Build ID: $BUILDID"
echo "Step 1:  Update the manifest versions to: $BUILDID"
echo "================================================="
sed -i "/<ApplicationManifest.*ApplicationTypeVersion/s/ApplicationTypeVersion=\".*\"/ApplicationTypeVersion=\"$BUILDID\"/" ApplicationManifest.xml
[ $? -eq 0 ] || { echo "Failed to update Application Manifest, Exiting..."; exit 1; }
sed -i "/<ServiceManifestRef.*ServiceManifestVersion/s/ServiceManifestVersion=\".*\"/ServiceManifestVersion=\"$BUILDID\"/" ApplicationManifest.xml
[ $? -eq 0 ] || { echo "Failed to update ServiceManifestRef, Exiting..."; exit 1; }
sed -i "/<CodePackage.*Version/s/Version=\".*\"/Version=\"$BUILDID\"/" dhClient/ServiceManifest.xml
[ $? -eq 0 ] || { echo "Failed to update CodePackage, Exiting..."; exit 1; }
sed -i "s/<ImageName>.*<\/ImageName>/<ImageName>knizami\/dhclient:$BUILDID<\ImageName>/g" dhClient/ServiceManifest.xml
[ $? -eq 0 ] || { echo "Failed to update ImageName, Exiting..."; exit 1; }
echo "===================COMPLETED====================="
azure servicefabric application package copy dhClient fabric:ImageStore
azure servicefabric application type register dhClient
azure servicefabric application upgrade start -m Monitored fabric:/dh $BUILDID
