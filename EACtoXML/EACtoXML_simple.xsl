<?xml version="1.0" encoding="UTF-8"?>
<!-- @sgraziella https://github.com/sgraziella/prosopography_LJP
    entityType = person;
    Really basic transformation from EAC-CPF to XML in order to add un intermediate stylesheet
    in XMLImport Omeka plugin https://github.com/Daniel-KM/XmlImport -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:eac="urn:isbn:1-931666-33-4" exclude-result-prefixes="xs xlink eac" version="1.0">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <AUTORITYFILE>
            <PERSON>
                <xsl:apply-templates/>
            </PERSON>
        </AUTORITYFILE>
    </xsl:template>



    <!-- Templates for control elements -->
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
    </xsl:template>

    <xsl:template match="eac:source">
        <SOURCE>
            <xsl:value-of select="."/>
        </SOURCE>
    </xsl:template>




    <!-- Templates for cpfDescription -->
    <xsl:template match="eac:entityType">
        <ENTITYTYPE>
            <xsl:value-of select="."/>
        </ENTITYTYPE>
    </xsl:template>
    
    <xsl:template match="eac:identity/eac:nameEntry">
        <NAMEENTRY>
            <xsl:value-of select="eac:part[@localType = 'prenom']"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="eac:part[@localType = 'nom']"/>
        </NAMEENTRY>
    </xsl:template>
    
    <xsl:template match="eac:nameEntryParallel"/>

    <xsl:template match="eac:existDates">
        <EXISTFROMDATE>
            <xsl:value-of select="eac:dateRange/eac:fromDate/@standardDate"/>
        </EXISTFROMDATE>
        <EXISTTODATE>
            <xsl:value-of select="eac:dateRange/eac:toDate/@standardDate"/>
        </EXISTTODATE>
    </xsl:template>

    <xsl:template match="eac:place">
        <PLACE>
            <xsl:value-of select="."/>
        </PLACE>
    </xsl:template>

    <xsl:template match="eac:functions">
        <FUNCTIONS>
            <xsl:value-of select="."/>
        </FUNCTIONS>
    </xsl:template>

    <xsl:template match="eac:biogHist">
        <BIOGHIST>
            <xsl:value-of select="."/>
        </BIOGHIST>
    </xsl:template>
    
    <xsl:template match="eac:relations">
        <RELATIONS>
            <xsl:value-of select="."/>
        </RELATIONS>
    </xsl:template>


    <!-- ici il faudrait le template pour importer les sources -->
    <!-- <xsl:template match="eac:source">
        <!-\-<xsl:for-each select="descendant::eac:sources/source">
            <xsl:value-of select="descendant::eac:sources/source/sourceEntry"/>
        </xsl:for-each>-\->
        <SOURCE>
        <xsl:value-of select="."/>
        </SOURCE>
    </xsl:template>
-->

</xsl:stylesheet>
