#!/bin/bash
[ -z $BUILDID ] && { echo '$BUILDID is undefined, exiting.'; exit 1; }
echo "Deploying release to dev for Build ID: $BUILDID"
echo "Step 1:  Update the manifest versions to: $BUILDID"
echo "================================================="
sed -i "/<ApplicationManifest.*ApplicationTypeVersion/s/ApplicationTypeVersion=\".*\"/ApplicationTypeVersion=\"$BUILDID\"/" dhclient/ApplicationManifest.xml
[ $? -eq 0 ] || { echo "Failed to update Application Manifest, Exiting..."; exit 1; }
sed -i "/<ServiceManifestRef.*ServiceManifestVersion/s/ServiceManifestVersion=\".*\"/ServiceManifestVersion=\"$BUILDID\"/" dhclient/ApplicationManifest.xml
[ $? -eq 0 ] || { echo "Failed to update ServiceManifestRef, Exiting..."; exit 1; }
sed -i "/<CodePackage.*Version/s/Version=\".*\"/Version=\"$BUILDID\"/" dhclient/dhClient/ServiceManifest.xml
[ $? -eq 0 ] || { echo "Failed to update CodePackage, Exiting..."; exit 1; }
sed -i "s/<ImageName>.*<\/ImageName>/<ImageName>knizami\/dhclient:$BUILDID<\ImageName>/g" dhclient/dhClient/ServiceManifest.xml
[ $? -eq 0 ] || { echo "Failed to update ImageName, Exiting..."; exit 1; }
echo "================================================="
azure servicefabric application package copy dhclient fabric:ImageStore
azure servicefabric application type register dhclient
azure servicefabric application create fabric:/dh dhMobile $BUILDID
