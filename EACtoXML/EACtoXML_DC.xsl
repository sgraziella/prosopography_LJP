<?xml version="1.0" encoding="UTF-8"?>
<!--@sgraziella https://github.com/sgraziella/prosopography_LJP
    @licence Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
    Basic transformation from EAC-CPF to XML in order to add an intermediate stylesheet
    on XMLImport Omeka plugin https://github.com/Daniel-KM/XmlImport
    with attribute-set for Dublin Core
    version 0.2-dc -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:eac="urn:isbn:1-931666-33-4" xmlns:dc="http://purl.org/dc/elements/1.1/"
    exclude-result-prefixes="xs xlink eac dc" version="1.0">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <!-- To define the elements for which white space should be removed -->
    <xsl:strip-space elements="eac:control eac:cpfDescription" xml:space="default"/>

    <!-- To create a newline -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>


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
        <xsl:attribute name="dc:type">description</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-format">
        <!-- dc:format : The file format, physical medium, or dimensions of the resource -->
        <xsl:attribute name="dc:type">format</xsl:attribute>
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
        <xsl:attribute name="dc:type">relation</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc:rights">
        <!-- dc:rights : Information about rights held in and over the resource -->
        <xsl:attribute name="type">rights</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-source">
        <!-- dc:source : A related resource from which the described resource is derived -->
        <xsl:attribute name="dc:type">source</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-subject">
        <!-- dc:subject : The topic of the resource -->
        <xsl:attribute name="dc:type">subject</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-title">
        <!-- dc:title : A name given to the resource -->
        <xsl:attribute name="dc:type">title</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="dc-type">
        <!-- dc:type : The nature or genre of the resource -->
        <xsl:attribute name="dc:type">type</xsl:attribute>
    </xsl:attribute-set>



    <!-- ************* MAIN TEMPLATE ************************** -->
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
            <xsl:value-of select="eac:language"/>
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

    <!-- subcolumns for sources; containing ark citation -->
    <xsl:template match="eac:sources">
        <SOURCES>
            <xsl:for-each select="eac:source">
                <SOURCE>
                    <!-- Print the URI pointing to the related resource -->
                    <xsl:choose>
                        <xsl:when test="string-length(eac:sourceEntry) != 0">
                            <xsl:value-of select="eac:sourceEntry"/>
                            <xsl:text> (</xsl:text>
                            <xsl:value-of
                                select="./@*[namespace-uri() = 'http://www.w3.org/1999/xlink' and local-name() = 'href']"/>
                            <xsl:text>)</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </SOURCE>
            </xsl:for-each>
            <!-- XML schema and namespace attribute in case of <tei:bibl> source -->
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
        <!-- An arbitrary field containing the occurrences of the entity into the edition text -->
        <DESCRIPTIVENOTE>
            <xsl:choose>
                <xsl:when
                    test="./eac:source/@*[namespace-uri() = 'http://www.w3.org/XML/1998/namespace' and local-name() = 'id'] = 'edition'">
                    <xsl:value-of select="eac:source/eac:descriptiveNote/eac:p"/>
                </xsl:when>
            </xsl:choose>
        </DESCRIPTIVENOTE>
    </xsl:template>



    <!-- **************** Templates for cpfDescription ******************* -->

    <!-- dc-subject : display nameEntry as a copy in order to map the subject for Catalog Search plugin -->
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
            such as dates of establishment and dissolution for corporate bodies and dates of birth and death or flourit for persons. 
            This element include a generic element <descriptiveNote> that provides additional information and specifications.
            -->
        <EXISTDATE>
            <xsl:choose>
                <xsl:when test="string-length(eac:dateRange/eac:fromDate) != 0">
                    <!-- local translation -->
                    <xsl:text>De : </xsl:text>
                    <xsl:value-of select="eac:dateRange/eac:fromDate"/>
                    <xsl:text> - </xsl:text>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="string-length(eac:dateRange/eac:toDate) != 0">
                    <!-- local translation -->
                    <xsl:text>A : </xsl:text>
                    <xsl:value-of select="eac:dateRange/eac:toDate"/>
                </xsl:when>
                <xsl:when test="string-length(eac:descriptiveNote) != 0">
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="descendant::eac:descriptiveNote"/>
                    <xsl:text>)</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text> ? </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </EXISTDATE>
    </xsl:template>

    <xsl:template match="eac:places">
        <!-- Summary: A grouping element used to bundle together individual <place> elements; 
            this element include an element to identify the contextual role a place or jurisdiction has in relation to the EAC-CPF entity -->
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
        <!-- Summary: A grouping element used to bundle together individual <function> elements. 
            This element include <dateRange>, <term>, <placeEntry>, <citation>, <descriptiveNote>  -->
        <FUNCTIONS>
            <xsl:for-each select="eac:function">
                <FUNCTION>
                    <xsl:text>- </xsl:text>
                    <!-- if dateRange -->
                    <xsl:choose>
                        <xsl:when test="string-length(eac:dateRange/eac:fromDate) != 0">
                            <!-- print attribut as text -->
                            <xsl:choose>
                                <xsl:when test="eac:dateRange/eac:fromDate/@notBefore">
                                    <!-- local translation for attribute -->
                                    <xsl:text>Pas avant</xsl:text>
                                    <xsl:text> </xsl:text>
                                </xsl:when>
                                <xsl:when test="eac:dateRange/eac:fromDate/@notAfter">
                                    <!-- local translation for attribute -->
                                    <xsl:text>Pas après</xsl:text>
                                    <xsl:text> </xsl:text>
                                </xsl:when>
                            </xsl:choose>
                            <xsl:value-of select="eac:dateRange/eac:fromDate"/>
                            <xsl:text> - </xsl:text>
                            <xsl:choose>
                                <xsl:when test="eac:dateRange/eac:toDate/@notBefore">
                                    <!-- local translation for attribute -->
                                    <xsl:text>Pas avant</xsl:text>
                                    <xsl:text> </xsl:text>
                                </xsl:when>
                                <xsl:when test="eac:dateRange/eac:toDate/@notAfter">
                                    <!-- local translation for attribute -->
                                    <xsl:text>Pas après</xsl:text>
                                    <xsl:text> </xsl:text>
                                </xsl:when>
                            </xsl:choose>
                            <xsl:value-of select="eac:dateRange/eac:toDate"/>
                        </xsl:when>
                    </xsl:choose>
                    <!-- close dateRange -->
                    <!-- if single date -->
                    <xsl:choose>
                        <xsl:when test="string-length(eac:dateRange/eac:date) != 0">
                            <!-- print attribut as text -->
                            <xsl:choose>
                                <xsl:when test="eac:dateRange/eac:date/@notBefore">
                                    <!-- local translation for attribute -->
                                    <xsl:text>Pas avant</xsl:text>
                                    <xsl:text> </xsl:text>
                                </xsl:when>
                                <xsl:when test="eac:dateRange/eac:date/@notAfter">
                                    <!-- local translation for attribute -->
                                    <xsl:text>Pas après</xsl:text>
                                    <xsl:text> </xsl:text>
                                </xsl:when>
                            </xsl:choose>
                            <xsl:value-of select="eac:dateRange/eac:date"/>
                            <xsl:text>: </xsl:text>
                        </xsl:when>
                    </xsl:choose>
                    <!-- close single date -->
                    <xsl:text> : </xsl:text>
                    <!-- print <term>, a generic element used to encode a descriptive term in accordance with local descriptive rules -->
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
                    <xsl:value-of select="eac:citation"/>
                    <!-- add a new line after each function -->
                    <xsl:value-of select="$newline"/>
                </FUNCTION>
            </xsl:for-each>
        </FUNCTIONS>
    </xsl:template>

    <xsl:template match="eac:biogHist">
        <!-- Summary: A concise essay and/or chronology that provides biographical or historical information about the EAC-CPF entity.
        <abstract> and <citation> are considered at the same level of <chronItem>-->
        <BIOGHIST>
            <BIOABSTRACT>
                <xsl:value-of select="eac:abstract"/>
            </BIOABSTRACT>
            <BIOCITATION>
                <xsl:value-of select="eac:citation"/>
            </BIOCITATION>
            <!-- list items from chronlist -->
            <xsl:for-each select="eac:chronList/eac:chronItem">
                <CHRONITEM>
                    <xsl:value-of select="eac:dateRange"/>
                    <xsl:value-of select="eac:date"/>
                    <xsl:text> - </xsl:text>
                    <xsl:value-of select="eac:event"/>
                </CHRONITEM>
            </xsl:for-each>
        </BIOGHIST>
    </xsl:template>

    <xsl:template match="eac:relations">
        <!-- Summary: A wrapper element for grouping one or more specific relations -->
        <RELATIONS>
            <xsl:for-each select="eac:cpfRelation">
                <CPFRELATION>
                    <xsl:value-of select="eac:relationEntry"/>
                    <!-- Print descriptiveNote -->
                    <xsl:choose>
                        <xsl:when test="string-length(eac:descriptiveNote) != 0">
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="eac:descriptiveNote"/>
                            <xsl:text>)</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                    <!-- Print the URI defining the purpose of the link -->
                    <xsl:choose>
                        <xsl:when
                            test="string-length(./@*[namespace-uri() = 'http://www.w3.org/1999/xlink' and local-name() = 'arcrole']) != 0">
                            <xsl:text> [xlink:arcrole=</xsl:text>
                            <xsl:value-of
                                select="./@*[namespace-uri() = 'http://www.w3.org/1999/xlink' and local-name() = 'arcrole']"/>
                            <xsl:text>]</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </CPFRELATION>
            </xsl:for-each>
        </RELATIONS>
    </xsl:template>


</xsl:stylesheet>
