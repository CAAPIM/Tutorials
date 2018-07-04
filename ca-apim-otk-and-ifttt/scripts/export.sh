#!/bin/bash
#
# This file uses RESTMan to export policies. To use it, simply install the RESTMan service, update username, password in
# this file and execute it as is. If it is used with a gateway that has the tutorial policies installed, it will export them all!
#
# export IFTTT service
#
# get cluster properties for IFTTT
curl -k -u admin:password "https://otk-ifttt.tutorial.com/restman/1.0/bundle?defaultAction=NewOrUpdate&clusterProperty=5dbe8b411167eae8d109f6a968bc9f47&clusterProperty=5dbe8b411167eae8d109f6a968bca162&clusterProperty=5dbe8b411167eae8d109f6a968bca15b&clusterProperty=5dbe8b411167eae8d109f6a968bca188&clusterProperty=5dbe8b411167eae8d109f6a968bca18f&clusterProperty=5dbe8b411167eae8d109f6a968bca1f6&clusterProperty=5dbe8b411167eae8d109f6a968bca21b&clusterProperty=d0c2108b72b11af05b03eb6dd44d2928&clusterProperty=d0c2108b72b11af05b03eb6dd44d2920&clusterProperty=d0c2108b72b11af05b03eb6dd44d291e&clusterProperty=a57c57c3590f4b15ce94b8845cbffff9" -o raw/z_ifttt_clusterProperties.bundle.raw
java -jar lib/saxon9he.jar -xsl:xsl/bundle.xsl -s:raw/z_ifttt_clusterProperties.bundle.raw -o:../add-ons/bundles/z_ifttt_clusterProperties.bundle
#
# get folder 'IFTTT':
curl -k -u admin:password "https://otk-ifttt.tutorial.com/restman/1.0/bundle?defaultAction=NewOrUpdate&folder=5dbe8b411167eae8d109f6a968bc9792" -o raw/z_ifttt_folders.bundle.raw
java -jar lib/saxon9he.jar -xsl:xsl/bundle.xsl -s:raw/z_ifttt_folders.bundle.raw -o:../add-ons/bundles/z_ifttt_folders.bundle
java -jar lib/saxon9he.jar -xsl:xsl/removeEntitiesFromFolderBundle.xsl -s:../add-ons/bundles/z_ifttt_folders.bundle -o:../add-ons/bundles/z_ifttt_folders.bundle
#
# get jdbc connection 'OAuth':
curl -k -u admin:password "https://otk-ifttt.tutorial.com/restman/1.0/bundle?defaultAction=NewOrUpdate&jdbcConnection=6c4cbf41983a96e34d69b488770929a3" -o raw/otk_01_jdbc.bundle.raw
java -jar lib/saxon9he.jar -xsl:xsl/bundle.xsl -s:raw/otk_01_jdbc.bundle.raw -o:../add-ons/bundles/otk_01_jdbc.bundle
java -jar lib/saxon9he.jar -xsl:xsl/addJdbcConnectionPassword.xsl -s:../add-ons/bundles/otk_01_jdbc.bundle -o:../add-ons/bundles/otk_01_jdbc.bundle
#
# get cluster properties for 'OTK'
curl -k -u admin:password "https://otk-ifttt.tutorial.com/restman/1.0/bundle?defaultAction=NewOrUpdate&clusterProperty=33a6275037893961d8ba3bdfdb33c101" -o raw/otk_02_clusterProperties.bundle.raw
java -jar lib/saxon9he.jar -xsl:xsl/bundle.xsl -s:raw/otk_02_clusterProperties.bundle.raw -o:../add-ons/bundles/otk_02_clusterProperties.bundle
#
# get folder 'OTK':
curl -k -u admin:password "https://otk-ifttt.tutorial.com/restman/1.0/bundle?defaultAction=NewOrUpdate&folder=e001cfd0c1c1ffaa18e187b5e72fc718" -o raw/otk_03_folders.bundle.raw
java -jar lib/saxon9he.jar -xsl:xsl/bundle.xsl -s:raw/otk_03_folders.bundle.raw -o:../add-ons/bundles/otk_03_folders.bundle
java -jar lib/saxon9he.jar -xsl:xsl/removeEntitiesFromFolderBundle.xsl -s:../add-ons/bundles/otk_03_folders.bundle -o:../add-ons/bundles/otk_03_folders.bundle
#
# Export unreferenced encapsulated assertions
#
# - OTK/Policy Fragments/authentication/OTK FIP Client Authentication (d1bde3d2021a469e82ebf8cac288b71a)
# - OTK/Policy Fragments/manage/analyse/OTK Analyze App Usage (efc6a765ba66b41f4bb7b1fc58c6ce8d)
# - OTK/Policy Fragments/manage/client/OTK Client Delete (3f6b5c92ca2ac3665bc7d8780bc4e667)
# - OTK/Policy Fragments/manage/client/OTK Client Key Update (3f6b5c92ca2ac3665bc7d8780bc4d9af)
# - OTK/Policy Fragments/manage/client/OTK Client Revoke Key (3f6b5c92ca2ac3665bc7d8780bc4e683)
# - OTK/Policy Fragments/manage/client/OTK Client Update (3f6b5c92ca2ac3665bc7d8780bc4e671)
# - OTK/Policy Fragments/manage/token/OTK Token Disable (3f6b5c92ca2ac3665bc7d8780bc4e69b)
# - OTK/Policy Fragments/manage/token/OTK Token Storage (oauth_token) (3f6b5c92ca2ac3665bc7d8780bc4de77)
# - OTK/Policy Fragments/manage/token/OTK Token Update (setting verifier) (3f6b5c92ca2ac3665bc7d8780bc4de5d)
# - OTK/Policy Fragments/manage/token/OTK Token Update (token status) (3f6b5c92ca2ac3665bc7d8780bc4e68f)
# - OTK/Policy Fragments/manage/token/OTK Token Update (user -> request_token) (3f6b5c92ca2ac3665bc7d8780bc4de6b)
# - OTK/Policy Fragments/manager/persistence/client/OTK Manager Client Key DB Count (f76f2a2a24844be3c0f269b19f06bc39)
# - OTK/Policy Fragments/response_types/OTK check response type supported (437338da510a3c54a137073b1ca83824)
# - OTK/Policy Fragments/validation - verification/OTK Create Public Key PIN (33c21ebb59b7cae5cd069fe74a94555a)
#
curl -k -u admin:password "https://otk-ifttt.tutorial.com/restman/1.0/bundle?defaultAction=NewOrUpdate&encapsulatedAssertion=d1bde3d2021a469e82ebf8cac288b71a&encapsulatedAssertion=efc6a765ba66b41f4bb7b1fc58c6ce8d&encapsulatedAssertion=3f6b5c92ca2ac3665bc7d8780bc4e667&encapsulatedAssertion=3f6b5c92ca2ac3665bc7d8780bc4d9af&encapsulatedAssertion=3f6b5c92ca2ac3665bc7d8780bc4e683&encapsulatedAssertion=3f6b5c92ca2ac3665bc7d8780bc4e671&encapsulatedAssertion=3f6b5c92ca2ac3665bc7d8780bc4e69b&encapsulatedAssertion=3f6b5c92ca2ac3665bc7d8780bc4de77&encapsulatedAssertion=3f6b5c92ca2ac3665bc7d8780bc4de5d&encapsulatedAssertion=3f6b5c92ca2ac3665bc7d8780bc4e68f&encapsulatedAssertion=3f6b5c92ca2ac3665bc7d8780bc4de6b&encapsulatedAssertion=f76f2a2a24844be3c0f269b19f06bc39&encapsulatedAssertion=437338da510a3c54a137073b1ca83824&encapsulatedAssertion=33c21ebb59b7cae5cd069fe74a94555a&encapsulatedAssertion=f76f2a2a24844be3c0f269b19f06bc39&encapsulatedAssertion=437338da510a3c54a137073b1ca83824&encapsulatedAssertion=33c21ebb59b7cae5cd069fe74a94555a" -o raw/otk_04_unreferencedEncas.bundle.raw
java -jar lib/saxon9he.jar -xsl:xsl/bundle.xsl -s:raw/otk_04_unreferencedEncas.bundle.raw -o:../add-ons/bundles/otk_04_unreferencedEncas.bundle
java -jar lib/saxon9he.jar -xsl:xsl/removeEntitiesFromFolderBundle.xsl -s:../add-ons/bundles/otk_04_unreferencedEncas.bundle -o:../add-ons/bundles/otk_04_unreferencedEncas.bundle
#
# get scheduledTasks maintaining OTK sql-based database
curl -k -u admin:password "https://otk-ifttt.tutorial.com/restman/1.0/bundle?defaultAction=NewOrUpdate&scheduledTask=33c21ebb59b7cae5cd069fe74a951e69&scheduledTask=33c21ebb59b7cae5cd069fe74a951e70&scheduledTask=33c21ebb59b7cae5cd069fe74a951e77&scheduledTask=33c21ebb59b7cae5cd069fe74a951e7f" -o raw/otk_05_scheduledTasks.bundle.raw
java -jar lib/saxon9he.jar -xsl:xsl/bundle.xsl -s:raw/otk_05_scheduledTasks.bundle.raw -o:../add-ons/bundles/otk_05_scheduledTasks.bundle
java -jar lib/saxon9he.jar -xsl:xsl/removeEntitiesFromFolderBundle.xsl -s:../add-ons/bundles/otk_05_scheduledTasks.bundle -o:../add-ons/bundles/otk_05_scheduledTasks.bundle
#
# Fixing a broken reference
sed 's#&lt;L7p:KeyGoid goidValue="0000000000000000ffffffffffffffff"/&gt;#\&lt;L7p:KeyAlias stringValue="ssl"/\&gt;\&lt;L7p:KeyGoid goidValue="00000000000000000000000000000002"/\&gt;#g' ../add-ons/bundles/otk_03_folders.bundle > ../add-ons/bundles/otk_03_folders-fixed.bundle
sed 's#&lt;L7p:SourceKeyGoid goidValue="0000000000000000ffffffffffffffff"/&gt;#\&lt;L7p:SourceKeyAlias stringValue="ssl"/\&gt;\&lt;L7p:SourceKeyGoid goidValue="00000000000000000000000000000002"/\&gt;#g' ../add-ons/bundles/otk_03_folders-fixed.bundle > ../add-ons/bundles/otk_03_folders.bundle
rm ../add-ons/bundles/otk_03_folders-fixed.bundle