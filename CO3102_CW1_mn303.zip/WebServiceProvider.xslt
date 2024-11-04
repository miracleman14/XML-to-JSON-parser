<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/service">
        <html>
            <head>
                <title>Web Service Interface Details</title>
            </head>
            <body>
                <h1>Web Service Interface Details</h1>
                <table border="1">
                    <tr>
                        <th>Method(s)</th>
                        <th>Parameter(s)</th>
                        <th>Return</th>
                        <th>Number of Exception(s)</th>
                    </tr>
                    <xsl:for-each select="abstract_method">
                        <tr>
                            <td>
                                <xsl:value-of select="@name"/>
                            </td>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="@name='authenticateUser'">
                                        <xsl:text>account: String, password: String, url: URL</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="@name='deleteUser'">
                                        <xsl:text>user: String</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:for-each select="arguments/parameter">
                                            <xsl:value-of select="@type"/>
                                            <xsl:if test="position() != last()">, </xsl:if>
                                        </xsl:for-each>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>
                            <td>
                                <xsl:value-of select="return"/>
                            </td>
                            <td>
                                <xsl:value-of select="count(exceptions/exception)"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
