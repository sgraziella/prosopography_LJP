<?xml version="1.0" encoding="UTF-8"?>
<!-- @sgraziella https://github.com/sgraziella/prosopography_LJP
    Really basic transformation from EAC-CPF to XML in order to add an intermediate stylesheet
    on XMLImport Omeka plugin https://github.com/Daniel-KM/XmlImport 
    Case 1 : entityType = person 
    version 0.1 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:eac="urn:isbn:1-931666-33-4" exclude-result-prefixes="xs xlink eac" version="1.0">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <AUTORITYFILE>
            <PERSON>
                <xsl:apply-templates/>
            </PERSON>
        </AUTORITYFILE>
    </xsl:template>


    <!-- ****** Templates for control elements ****** -->
    <xsl:template match="eac:recordId">
        <RECORDID>
            <xsl:value-of select="."/>
        </RECORDID>
    </xsl:template>

    <xsl:template match="eac:maintenanceStatus"/>

    <xsl:template match="eac:publicationStatus"/>

    <xsl:template match="eac:agencyName">
        <AGENCYNAME>
            <xsl:value-of select="."/>
        </AGENCYNAME>
    </xsl:template>

    <xsl:template match="eac:languageDeclaration"/>

    <xsl:template match="eac:conventionDeclaration"/>

    <xsl:template match="eac:maintenanceHistory">
        <EVENTDATETIME>
            <xsl:value-of select="descendant::eac:maintenanceEvent/eac:eventDateTime"/>
        </EVENTDATETIME>
        <AGENT>
            <xsl:value-of select="descendant::eac:maintenanceEvent/eac:agent"/>
        </AGENT>
        <EVENTDESCRIPTION>
            <xsl:value-of select="descendant::eac:maintenanceEvent/eac:eventDescription"/>
        </EVENTDESCRIPTION>
    </xsl:template>

    <!-- subcolumn for sources -->
    <xsl:template match="eac:sources">
        <SOURCES>
            <xsl:for-each select="descendant::eac:source">
                <SOURCE>
                    <xsl:value-of select="eac:sourceEntry"/>
                </SOURCE>
            </xsl:for-each>
            <xsl:for-each
                select="descendant::eac:source/eac:objectXMLWrap/*[namespace-uri() = 'http://www.tei-c.org/ns/1.0' and local-name() = 'bibl']">
                <SOURCE>
                    <xsl:value-of
                        select="./*[namespace-uri() = 'http://www.tei-c.org/ns/1.0' and local-name() = 'author']"
                    />, <xsl:value-of
                        select="./*[namespace-uri() = 'http://www.tei-c.org/ns/1.0' and local-name() = 'title']"/>
                    <!-- à completer -->
                </SOURCE>
            </xsl:for-each>
        </SOURCES>
    </xsl:template>

    <!-- ****** Templates for cpfDescription ****** -->
    <xsl:template match="eac:entityType">
        <ENTITYTYPE>
            <xsl:value-of select="."/>
        </ENTITYTYPE>
    </xsl:template>

    <xsl:template match="eac:identity/eac:nameEntry">
        <NAMEENTRY>
            <xsl:value-of select="eac:part[@localType = 'prénom']"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="eac:part[@localType = 'nom']"/>
        </NAMEENTRY>
    </xsl:template>

    <xsl:template match="eac:nameEntryParallel"/>

    <xsl:template match="eac:existDates">
        <EXISTFROMDATE>
            <xsl:value-of select="eac:dateRange/eac:fromDate"/>
        </EXISTFROMDATE>
        <EXISTTODATE>
            <xsl:value-of select="eac:dateRange/eac:toDate"/>
        </EXISTTODATE>
    </xsl:template>

    <xsl:template match="eac:place">
        <PLACE>
            <xsl:value-of select="."/>
        </PLACE>
    </xsl:template>

    <xsl:template match="eac:functions">
        <FUNCTIONS>
            <xsl:for-each select="eac:function">
                <FUNCTION>
                    <xsl:choose>
                        <xsl:when test="string-length(eac:dateRange/eac:fromDate) != 0">
                    <xsl:value-of select="eac:dateRange/eac:fromDate"/>
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select="eac:dateRange/eac:toDate"/>
                    <xsl:text>: </xsl:text>
                        </xsl:when>
                    </xsl:choose>
                    
                    <xsl:value-of select="eac:term"/>
                    <xsl:choose>
                        <xsl:when test="string-length(eac:placeEntry) != 0">
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="eac:placeEntry"/>
                            <xsl:text>)</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </FUNCTION>
            </xsl:for-each>
        </FUNCTIONS>
    </xsl:template>

    <xsl:template match="eac:biogHist">
        <BIOGHIST>
            <xsl:for-each select="eac:chronList/eac:chronItem">
                <CHRONITEM>
                    <xsl:value-of select="."/>
                </CHRONITEM>
            </xsl:for-each>
        </BIOGHIST>
    </xsl:template>

    <xsl:template match="eac:relations">
        <RELATIONS>
            <xsl:value-of select="."/>
        </RELATIONS>
    </xsl:template>

</xsl:stylesheet>
