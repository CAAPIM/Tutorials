<xsl:stylesheet version="1.0" xmlns:l7="http://ns.l7tech.com/2010/04/gateway-management" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- remove what we do not want. We have a specific bundles for them -->
    <xsl:template match="l7:Mapping[@type='JDBC_CONNECTION']"/>
    <xsl:template match="l7:Item[l7:Type='JDBC_CONNECTION']"/>

    <xsl:template match="l7:Mapping[@type='CLUSTER_PROPERTY']"/>
    <xsl:template match="l7:Item[l7:Type='CLUSTER_PROPERTY']"/>

</xsl:stylesheet>