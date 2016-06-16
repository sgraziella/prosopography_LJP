<?xml version="1.0" encoding="UTF-8"?>
<!--@sgraziella https://github.com/sgraziella/prosopography_LJP
    @licence Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
    Basic transformation from EAC-CPF to XML in order to add an intermediate stylesheet
    on XMLImport Omeka plugin https://github.com/Daniel-KM/XmlImport
    with attribute-set for Dublin Core
    version 0.1-dc -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:eac="urn:isbn:1-931666-33-4" xmlns:dc="http://purl.org/dc/elements/1.1/"
    exclude-result-prefixes="xs xlink eac dc" version="1.0">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>


    <!-- ************** Dublin Core basic set **************** -->
    <xsl:attribute-set name="dc-contributor">
        <!-- dc:contributor : An entity responsible for making contributions to the resource -->
        <xsl:attribute name="dc:contributor">contributor</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-coverage">
        <!-- dc:coverage : The spatial or temporal topic of the resource, the spatial applicability of the resource, 
            or the jurisdiction under which the resource is relevant -->
        <xsl:attribute name="dc:coverage">coverage</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-creator">
        <!-- dc:creator : An entity primarily responsible for making the resource -->
        <xsl:attribute name="dc:type">creator</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-date">
        <!-- dc:date : A point or period of time associated with an event in the lifecycle of the resource -->
        <xsl:attribute name="dc:type">date</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-description">
        <!-- dc:description : An account of the resource -->
        <xsl:attribute name="dc:description">description</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-format">
        <!-- dc:format : The file format, physical medium, or dimensions of the resource -->
        <xsl:attribute name="dc:format">format</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-identifier">
        <!-- dc:identifier : An unambiguous reference to the resource within a given context -->
        <xsl:attribute name="dc:type">identifier</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-language">
        <!-- dc: language : A language of the resource -->
        <xsl:attribute name="dc:type">language</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-publisher">
        <!-- dc:publisher : An entity responsible for making the resource available -->
        <xsl:attribute name="dc:type">publisher</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-relation">
        <!-- dc:relation : A related resource -->
        <xsl:attribute name="dc:relation">relation</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc:rights">
        <!-- dc:rights : Information about rights held in and over the resource -->
        <xsl:attribute name="rights">rights</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-source">
        <!-- dc:source : A related resource from which the described resource is derived -->
        <xsl:attribute name="dc:source">source</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-subject">
        <!-- dc:subject : The topic of the resource -->
        <xsl:attribute name="dc:subject"/>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-title">
        <!-- dc:title : A name given to the resource -->
        <xsl:attribute name="dc:type">title</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-type">
        <!-- dc:type : The nature or genre of the resource -->
        <xsl:attribute name="dc:type">type</xsl:attribute>
    </xsl:attribute-set>




    <!-- ************* main template ************************** -->
    <xsl:template match="/">
        <AUTORITYFILE>
            <PERSON>
                <xsl:apply-templates
                    select="eac:eac-cpf/eac:cpfDescription/eac:identity/eac:nameEntry" mode="copy"/>
                <xsl:apply-templates/>
            </PERSON>
        </AUTORITYFILE>
    </xsl:template>


    <!-- ************ Templates for control elements *********** -->
    <xsl:template match="eac:recordId">
        <RECORDID xsl:use-attribute-sets="dc-identifier">
            <xsl:value-of select="."/>
        </RECORDID>
    </xsl:template>

    <xsl:template match="eac:maintenanceStatus">
        <MAINTENANCESTATUS>
            <xsl:value-of select="."/>
        </MAINTENANCESTATUS>
    </xsl:template>

    <xsl:template match="eac:publicationStatus">
        <PUBLICATIONSTATUS>
            <xsl:value-of select="."/>
        </PUBLICATIONSTATUS>
    </xsl:template>

    <xsl:template match="eac:agencyName">
        <AGENCYNAME xsl:use-attribute-sets="dc-publisher">
            <xsl:value-of select="."/>
        </AGENCYNAME>
    </xsl:template>

    <xsl:template match="eac:languageDeclaration">
        <LANGUAGEDECLARATION xsl:use-attribute-sets="dc-language">
            <xsl:value-of select="."/>
        </LANGUAGEDECLARATION>
    </xsl:template>

    <xsl:template match="eac:conventionDeclaration">
        <CONVENTIONDECLARATION>
            <xsl:value-of select="."/>
        </CONVENTIONDECLARATION>
    </xsl:template>

    <xsl:template match="eac:maintenanceHistory">
        <EVENTDATETIME xsl:use-attribute-sets="dc-date">
            <xsl:value-of select="descendant::eac:maintenanceEvent/eac:eventDateTime"/>
        </EVENTDATETIME>
        <AGENT xsl:use-attribute-sets="dc-creator">
            <xsl:value-of select="descendant::eac:maintenanceEvent/eac:agent"/>
        </AGENT>
        <EVENTDESCRIPTION xsl:use-attribute-sets="dc-description">
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
                        select="./*[namespace-uri() = 'http://www.tei-c.org/ns/1.0' and local-name() = 'title']"
                    />, <xsl:value-of
                        select="./*[namespace-uri() = 'http://www.tei-c.org/ns/1.0' and local-name() = 'imprint']"
                    />
                </SOURCE>
            </xsl:for-each>
        </SOURCES>
        <DESCRIPTIVENOTE>
            <xsl:value-of select="eac:source/eac:descriptiveNote/eac:p"/>
        </DESCRIPTIVENOTE>
    </xsl:template>


    <!-- **************** Templates for cpfDescription ******************* -->

    <!-- dc-subject for Catalog Search plugin -->
    <xsl:template name="dcsubject" match="eac:identity/eac:nameEntry" mode="copy">
        <DCSUBJECT xsl:use-attribute-sets="dc-subject">
            <xsl:value-of select="eac:part[@localType = 'prénom']"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="eac:part[@localType = 'nom']"/>
        </DCSUBJECT>
    </xsl:template>

    <!-- others templates for cpfDescription -->
    <xsl:template match="eac:entityType">
        <ENTITYTYPE xsl:use-attribute-sets="dc-type">
            <xsl:value-of select="."/>
        </ENTITYTYPE>
    </xsl:template>

    <xsl:template name="nameEntry" match="eac:identity/eac:nameEntry">
        <NAMEENTRY_TITLE xsl:use-attribute-sets="dc-title">
            <xsl:value-of select="eac:part[@localType = 'prénom']"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="eac:part[@localType = 'nom']"/>
        </NAMEENTRY_TITLE>
    </xsl:template>

    <xsl:template match="eac:nameEntryParallel">
        <NAMEENTRYPARALLEL>
            <xsl:for-each select="eac:nameEntry">
                <NAMEENTRY>
                    <xsl:value-of select="."/>
                </NAMEENTRY>
            </xsl:for-each>
        </NAMEENTRYPARALLEL>
    </xsl:template>

    <xsl:template match="eac:existDates">
        <!-- Summary: The dates of existence of the entity being described, 
            such as dates of establishment and dissolution for corporate bodies and dates of birth and death or flourit for persons  -->
        <EXISTDATE>
            <xsl:text>From: </xsl:text>
            <xsl:value-of select="eac:dateRange/eac:fromDate"/>
            <xsl:text> To: </xsl:text>
            <xsl:value-of select="eac:dateRange/eac:toDate"/>
            <xsl:choose>
                <xsl:when test="string-length(eac:descriptiveNote) != 0">
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="descendant::eac:descriptiveNote"/>
                    <xsl:text>)</xsl:text>
                </xsl:when>
            </xsl:choose>
        </EXISTDATE>
    </xsl:template>

    <xsl:template match="eac:places">
        <!-- Summary: A grouping element used to bundle together individual <place> elements -->
        <PLACES>
            <xsl:for-each select="eac:place">
                <PLACE>
                    <xsl:value-of select="eac:placeEntry"/>
                    <xsl:choose>
                        <xsl:when test="string-length(eac:placeRole) != 0">
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="eac:placeRole"/>
                            <xsl:text>)</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </PLACE>
            </xsl:for-each>
        </PLACES>
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
                    <xsl:choose>
                        <xsl:when test="string-length(eac:descriptiveNote) != 0">
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="eac:descriptiveNote"/>
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
            <xsl:for-each select="eac:cpfRelation">
                <CPFRELATION>
                    <xsl:value-of select="eac:relationEntry"/>
                    <xsl:choose>
                        <xsl:when test="string-length(eac:descriptiveNote) != 0">
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="eac:descriptiveNote"/>
                            <xsl:text>)</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </CPFRELATION>
            </xsl:for-each>
        </RELATIONS>
    </xsl:template>


</xsl:stylesheet>
