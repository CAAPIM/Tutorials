<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:l7="http://ns.l7tech.com/2010/04/gateway-management">

    <!-- Identity transform -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Add a lt password so that it can be imported using RESTMan -->
    <xsl:template match="l7:Property[@key='user']">
        <xsl:copy-of select="."/>
        <l7:Property key="password">
            <l7:StringValue>password</l7:StringValue>
        </l7:Property>
    </xsl:template>

</xsl:stylesheet>