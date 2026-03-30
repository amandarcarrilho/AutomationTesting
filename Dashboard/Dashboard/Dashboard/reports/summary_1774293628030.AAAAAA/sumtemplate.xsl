<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" >
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:template match="/testcollection">
        <html>
            <head>
                <meta http-equiv="content-type" content="text/html; charset=UTF-8">
                </meta>
                <title>
                    <xsl:value-of select="properties/property[@name='_PRODUCT_NAME']/@value"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="properties/property[@name='_PRODUCT_VERSION_SHORT']/@value"/> Summary Report
                </title>
            </head>
            <body style="font-family:Arial, Helvetica, sans-serif; font-size:12px; color:#000000">
<!-- START: Top bar -->
                <table background="header_pad.png" border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tbody>
                        <tr height="65">
                            <td align="left"><a href="https://www.t-plan.com"><img src="header_left.png" border="0" height="65" width="520"/></a></td>
                            <td align="right"><a href="https://www.t-plan.com/robot"><img src="header_right.png" border="0" height="65" width="160"/></a></td>
                        </tr>
                    </tbody>
                </table>
<!-- END: Top bar -->
<br/>
<h2>Executed Test Cases</h2>

<!-- Read the parameters -->
<xsl:variable name="failColor">
    <xsl:choose>
        <xsl:when test="params/param[@name='failColor']"><xsl:value-of select="params/param[@name='failColor']/@value"/></xsl:when>
        <xsl:otherwise>#ff3333</xsl:otherwise>
    </xsl:choose>
</xsl:variable>
<xsl:variable name="pauseColor">
    <xsl:choose>
        <xsl:when test="params/param[@name='pauseColor']"><xsl:value-of select="params/param[@name='pauseColor']/@value"/></xsl:when>
        <xsl:otherwise>orange</xsl:otherwise>
    </xsl:choose>
</xsl:variable>
<xsl:variable name="passColor">
    <xsl:choose>
        <xsl:when test="params/param[@name='passColor']"><xsl:value-of select="params/param[@name='passColor']/@value"/></xsl:when>
        <xsl:otherwise>#33ff33</xsl:otherwise>
    </xsl:choose>
</xsl:variable>
<xsl:variable name="runningColor">
    <xsl:choose>
        <xsl:when test="params/param[@name='runningColor']"><xsl:value-of select="params/param[@name='runningColor']/@value"/></xsl:when>
        <xsl:otherwise>magenta</xsl:otherwise>
    </xsl:choose>
</xsl:variable>
<xsl:variable name="pendingColor">
    <xsl:choose>
        <xsl:when test="params/param[@name='pendingColor']"><xsl:value-of select="params/param[@name='pendingColor']/@value"/></xsl:when>
        <xsl:otherwise>#8888ff</xsl:otherwise>
    </xsl:choose>
</xsl:variable>

<b>View created on: </b><xsl:value-of select="properties/property[@name='_SUMMARY_DATE']/@value"/>
<br/><br/>

<!-- START: Table of test scripts -->
                <table cellpadding="4" cellspacing="1" border="0" bgcolor="black" style="text-align: left; font-family:Arial, Helvetica, sans-serif; font-size:12px; color:#000000">
                    <tbody>
                        <tr>
                            <td style="vertical-align: top; color: rgb(255, 255, 255); background-color: rgb(153, 153, 153);"><b>Project</b></td>
                            <td style="vertical-align: top; color: rgb(255, 255, 255); background-color: rgb(153, 153, 153);"><b>Test Script</b></td>
                            <td style="vertical-align: top; color: rgb(255, 255, 255); background-color: rgb(153, 153, 153);"><b>Test Case</b></td>
                        </tr>
                        <xsl:for-each select="project">
                            <xsl:variable name="pname" select="@name"/>
                            <xsl:variable name="prowspan" select="@tccount"/>
                            <xsl:for-each select="testsuite">
                                <xsl:variable name="tname" select="@filename"/>
                                <xsl:variable name="trowspan" select="@tccount"/>
                                <xsl:variable name="tposition" select="position()"/>
                                <xsl:variable name="status" select="@status"/>
                                <xsl:variable name="relpath">
                                    <xsl:choose>
                                        <xsl:when test="@relpath"><xsl:value-of select="@relpath"/></xsl:when>
                                        <xsl:otherwise></xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:for-each select="testcase">
                                    <xsl:variable name="cposition" select="position()"/>
                                    <xsl:variable name="tcbg">
                                        <xsl:choose>
                                            <xsl:when test="@exitcode">
                                                <xsl:choose>
                                                    <xsl:when test="@exitcode = '0'"><xsl:value-of select="$passColor"/></xsl:when>
                                                    <xsl:otherwise><xsl:value-of select="$passColor"/></xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:when>
                                            <xsl:otherwise>white</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:variable>

                                    <tr>
                                        <xsl:if test="$tposition = '1' and $cposition = '1'">
                                            <td bgcolor="white"><xsl:attribute name="rowspan"><xsl:value-of select="$prowspan"/></xsl:attribute>
                                                <xsl:value-of select="$pname"/>
                                            </td>
                                        </xsl:if>
                                        <!-- The Test Script (Script File) column -->
                                        <xsl:if test="$cposition = '1'">
                                            <td>
                                                <xsl:attribute name="rowspan"><xsl:value-of select="$trowspan"/></xsl:attribute>
                                                <!-- Set the BG color by the script status -->
                                                <xsl:choose>
                                                    <xsl:when test="$status = '-1'">  <!-- The script is running -->
                                                        <xsl:attribute name="bgcolor"><xsl:value-of select="$pendingColor"/></xsl:attribute>
                                                    </xsl:when>
                                                    <xsl:when test="$status = '0'">  <!-- The script is running -->
                                                        <xsl:attribute name="bgcolor"><xsl:value-of select="$runningColor"/></xsl:attribute>
                                                    </xsl:when>
                                                    <xsl:when test="$status = '1'">  <!-- The script is paused -->
                                                        <xsl:attribute name="bgcolor"><xsl:value-of select="$pauseColor"/></xsl:attribute>
                                                    </xsl:when>
                                                    <xsl:when test="$status = '3'">  <!-- The script passed (finished with the exit code of 0) -->
                                                        <xsl:attribute name="bgcolor"><xsl:value-of select="$failColor"/></xsl:attribute>
                                                    </xsl:when>
                                                    <xsl:when test="$status = '4'">  <!-- The script passed (finished with the exit code of 0) -->
                                                        <xsl:attribute name="bgcolor"><xsl:value-of select="$passColor"/></xsl:attribute>
                                                    </xsl:when>
                                                    <xsl:otherwise>   <!-- Other result - failed, stopped or unknown status-->
                                                        <xsl:attribute name="bgcolor">white</xsl:attribute>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            <xsl:choose>
                                                <xsl:when test="$relpath = ''">
                                                    <xsl:value-of select="$tname"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <a><xsl:attribute name="href"><xsl:value-of select="$relpath"/></xsl:attribute><xsl:value-of select="$tname"/></a>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            </td>
                                        </xsl:if>
                                        <!-- The Test Case column -->
                                        <td>
                                            <xsl:attribute name="bgcolor"><xsl:value-of select="$tcbg"/></xsl:attribute>
                                            <xsl:choose>
                                                <xsl:when test="@name">
                                                    <xsl:call-template name="newline">
                                                        <xsl:with-param name="text" select="@name"/>
                                                    </xsl:call-template> (No. <xsl:value-of select="@number"/>)</xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:choose>
                                                        <xsl:when test="@number">No. <xsl:value-of select="@number"/></xsl:when>
                                                        <xsl:otherwise>N/A</xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:for-each>
                    </tbody>
                </table>
<!-- END: Table of test scripts -->

<!-- Show the color legend -->
                <br/>
                <table cellpadding="2" cellspacing="5" border="0" style="text-align: left; font-family:Arial, Helvetica, sans-serif; font-size:12px; color:#000000">
                    <tbody>
                        <tr>
                            <td><b>Legend: </b></td>
                            <td><table cellpadding="3" cellspacing="1" border="0" bgcolor="#000000" style="text-align: left; font-family:Arial, Helvetica, sans-serif; font-size:12px; color:#000000"><tr><td><xsl:attribute name="bgcolor"><xsl:value-of select="$pendingColor"/></xsl:attribute>Not yet executed</td></tr></table></td>
                            <td><table cellpadding="3" cellspacing="1" border="0" bgcolor="#000000" style="text-align: left; font-family:Arial, Helvetica, sans-serif; font-size:12px; color:#000000"><tr><td><xsl:attribute name="bgcolor"><xsl:value-of select="$runningColor"/></xsl:attribute>Running</td></tr></table></td>
                            <td><table cellpadding="3" cellspacing="1" border="0" bgcolor="#000000" style="text-align: left; font-family:Arial, Helvetica, sans-serif; font-size:12px; color:#000000"><tr><td><xsl:attribute name="bgcolor"><xsl:value-of select="$pauseColor"/></xsl:attribute>Paused</td></tr></table></td>
                            <td><table cellpadding="3" cellspacing="1" border="0" bgcolor="#000000" style="text-align: left; font-family:Arial, Helvetica, sans-serif; font-size:12px; color:#000000"><tr><td><xsl:attribute name="bgcolor"><xsl:value-of select="$passColor"/></xsl:attribute>Passed</td></tr></table></td>
                            <td><table cellpadding="3" cellspacing="1" border="0" bgcolor="#000000" style="text-align: left; font-family:Arial, Helvetica, sans-serif; font-size:12px; color:#000000" ><tr><td><xsl:attribute name="bgcolor"><xsl:value-of select="$failColor"/></xsl:attribute>Failed</td></tr></table></td>
                        </tr>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    <!--START: Template to replace new lines with <br> -->
    <xsl:template name="newline">
        <xsl:param name="text"/>
        <xsl:choose>
            <xsl:when test="contains($text,'&#10;')">
                <xsl:value-of select="substring-before($text,'&#10;')"/>
                <br/>
                <xsl:call-template name="newline">
                    <xsl:with-param name="text" select="substring-after($text,'&#10;')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--END: new line template -->    
</xsl:stylesheet>