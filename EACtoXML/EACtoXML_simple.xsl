<?xml version="1.0" encoding="UTF-8"?>
<!-- @sgraziella https://github.com/sgraziella/prosopography_LJP
    Realy basic transformation from EAC-CPF to XML in order to add un intermediate stylesheet
    in XMLImport Omeka plugin https://github.com/Daniel-KM/XmlImport -->
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


    <xsl:template match="eac:recordId">
        <!-- from control -->
        <RECORDID>
            <xsl:value-of select="."/>
        </RECORDID>
    </xsl:template>
    <xsl:template match="eac:agencyName">
        <AGENCYNAME>
            <xsl:value-of select="."/>
        </AGENCYNAME>
    </xsl:template>
    <!--
        <EVENTDATETIME>
            <xsl:value-of
                select="descendant::eac:maintenanceHistory/eac:maintenanceEvent/eac:eventDateTime"/>
        </EVENTDATETIME>
        <AGENT>
            <xsl:value-of select="descendant::eac:maintenanceHistory/eac:maintenanceEvent/eac:agent"
            />
        </AGENT>
        <SOURCES>
    -->
    <xsl:template match="eac:source">
        <SOURCE>        
        <xsl:value-of select="."/>
            </SOURCE>
    </xsl:template>
    
    <xsl:template match="eac:languageDeclaration/eac:language"/>
    
    <xsl:template match="eac:identity/eac:nameEntry">
        <NAMEENTRY><xsl:value-of select="eac:part[@localType='prenom']"/><xsl:text> </xsl:text><xsl:value-of select="eac:part[@localType='nom']"/></NAMEENTRY>
    </xsl:template>
        <!--</SOURCES>-->

        <!-- from cpfDescription -->
       <!-- <NAMEENTRY>
            <xsl:value-of select="descendant::eac:identity/eac:nameEntry"/>
        </NAMEENTRY>
        <EXISTFROMDATE>
            <xsl:value-of
                select="descendant::eac:description/eac:existDates/eac:dateRange/eac:fromDate/@standardDate"
            />
        </EXISTFROMDATE>
        <EXISTTODATE>
            <xsl:value-of
                select="descendant::eac:description/eac:existDates/eac:dateRange/eac:toDate/@standardDate"
            />
        </EXISTTODATE>
        <PLACE>
            <xsl:value-of select="descendant::eac:cpfDescription/eac:description/eac:place"/>
        </PLACE>
        <FUNCTIONS>
            <xsl:value-of select="descendant::eac:cpfDescription/eac:description/eac:functions"/>
        </FUNCTIONS>
        <BIOGHIST>
            <xsl:value-of select="descendant::eac:cpfDescription/eac:description/eac:biogHist"/>
        </BIOGHIST>
        <RELATIONS>
            <xsl:value-of select="descendant::eac:cpfDescription/eac:relations"/>
        </RELATIONS>
    </xsl:template>
    -->
    
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
