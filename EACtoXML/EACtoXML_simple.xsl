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
                <xsl:apply-templates select="eac:eac-cpf"/>
            </PERSON>
        </AUTORITYFILE>
    </xsl:template>


    <xsl:template match="eac:eac-cpf">
        <!-- from control -->
        <RECORDID>
            <xsl:value-of select="descendant::eac:recordId"/>
        </RECORDID>
        <AGENCYNAME>
            <xsl:value-of select="descendant::eac:maintenanceAgency/eac:agencyName"/>
        </AGENCYNAME>
        <EVENTDATETIME>
            <xsl:value-of
                select="descendant::eac:maintenanceHistory/eac:maintenanceEvent/eac:eventDateTime"/>
        </EVENTDATETIME>
        <AGENT>
            <xsl:value-of select="descendant::eac:maintenanceHistory/eac:maintenanceEvent/eac:agent"
            />
        </AGENT>
        <SOURCES>
            <!-- <xsl:value-of select="descendant::eac:sources"/> -->
            <xsl:apply-templates select="eac-cpf/control/sources"/>
        </SOURCES>

        <!-- from cpfDescription -->
        <NAMEENTRY>
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
    
    
    <!-- ici il faudrait le template pour importer les sources -->
    <xsl:template match="eac:eac-cpf/control/sources">
        <xsl:for-each select="descendant::eac:sources/source">
            <xsl:value-of select="descendant::eac:sources/source/sourceEntry"/>
        </xsl:for-each>
    </xsl:template>


</xsl:stylesheet>
