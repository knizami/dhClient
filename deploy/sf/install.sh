#!/bin/bash
[ -z $BUILDID ] && { echo '$BUILDID is undefined, exiting.'; exit 1; }
echo "Deploying release to dev for Build ID: $BUILDID"
echo "Step 1:  Update the manifest versions to: $BUILDID"
echo "================================================="
echo "Updating ApplicationManifest.."
sed -i "/<ApplicationManifest.*ApplicationTypeVersion/s/ApplicationTypeVersion=\".*\"/ApplicationTypeVersion=\"$BUILDID\"/" dhclient/ApplicationManifest.xml
[ $? -eq 0 ] || { echo "Failed to update Application Manifest, Exiting..."; exit 1; }
echo "Updating ApplicationManifest Completed"
echo "Updating ServiceManifestRef.."
sed -i "/<ServiceManifestRef.*ServiceManifestVersion/s/ServiceManifestVersion=\".*\"/ServiceManifestVersion=\"$BUILDID\"/" dhclient/ApplicationManifest.xml
[ $? -eq 0 ] || { echo "Failed to update ServiceManifestRef, Exiting..."; exit 1; }
echo "Updating ServiceManifestRef Completed"
echo "Updating CodePackage.."
sed -i "/<CodePackage.*Version/s/Version=\".*\"/Version=\"$BUILDID\"/" dhclient/dhClient/ServiceManifest.xml
[ $? -eq 0 ] || { echo "Failed to update CodePackage, Exiting..."; exit 1; }
echo "Updating CodePackage Completed"
echo "Updating ImageName.."
sed -i "s/<ImageName>.*<\/ImageName>/<ImageName>knizami\/dhclient:$BUILDID<\ImageName>/g" dhclient/dhClient/ServiceManifest.xml
[ $? -eq 0 ] || { echo "Failed to update ImageName, Exiting..."; exit 1; }
echo "Updating ImageName Completed"
echo "================================================="
azure servicefabric application package copy dhclient fabric:ImageStore
azure servicefabric application type register dhclient
azure servicefabric application create fabric:/dh dhMobile $BUILDID
