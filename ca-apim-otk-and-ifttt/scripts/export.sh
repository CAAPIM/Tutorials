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
# Fixing a broken reference
sed 's#&lt;L7p:KeyGoid goidValue="0000000000000000ffffffffffffffff"/&gt;#\&lt;L7p:KeyAlias stringValue="ssl"/\&gt;\&lt;L7p:KeyGoid goidValue="00000000000000000000000000000002"/\&gt;#g' ../add-ons/bundles/otk_03_folders.bundle > ../add-ons/bundles/otk_03_folders-fixed.bundle
sed 's#&lt;L7p:SourceKeyGoid goidValue="0000000000000000ffffffffffffffff"/&gt;#\&lt;L7p:SourceKeyAlias stringValue="ssl"/\&gt;\&lt;L7p:SourceKeyGoid goidValue="00000000000000000000000000000002"/\&gt;#g' ../add-ons/bundles/otk_03_folders-fixed.bundle > ../add-ons/bundles/otk_03_folders.bundle
rm ../add-ons/bundles/otk_03_folders-fixed.bundle