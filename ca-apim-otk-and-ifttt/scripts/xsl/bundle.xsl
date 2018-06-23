<xsl:stylesheet version="1.0" xmlns:l7="http://ns.l7tech.com/2010/04/gateway-management" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Will turn the exported RESTMan bundle into a message that can be imported into the gateway -->
    <xsl:template match="l7:Item">
        <xsl:copy-of select="//l7:Bundle"/>
    </xsl:template>

</xsl:stylesheet>