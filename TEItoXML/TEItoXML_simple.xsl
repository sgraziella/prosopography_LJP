<?xml version="1.0" encoding="UTF-8"?>
<!--@sgraziella https://github.com/sgraziella/prosopography_LJP
    @licence Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
    Really basic transformation from TEI persName (listPerson) into a flat XML 
    Could be used in order to add an intermediate stylesheet on XMLImport Omeka plugin https://github.com/Daniel-KM/XmlImport 
    version 0.1 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="xs xlink tei" version="1.0">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    
    <!-- To define the elements for which white space should be removed -->
    <xsl:strip-space elements="tei:teiHeader tei:text" xml:space="default"/>

    <!-- main template -->
    <xsl:template match="/">
        <AUTORITYFILE>
            <PERSON>
                <xsl:apply-templates/>
            </PERSON>
        </AUTORITYFILE>
    </xsl:template>


    <!-- ********************* templates for teiHeader ************************ -->
    <xsl:template match="tei:teiHeader/tei:fileDesc/tei:titleStmt">
        <RECORDID>
            <xsl:value-of select="tei:title"/>
        </RECORDID>
        <AGENT>
            <xsl:value-of select="tei:principal/tei:persName/tei:forename"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="tei:principal/tei:persName/tei:surname"/>
        </AGENT>
        <AGENCYNAME>
            <xsl:value-of select="tei:principal/tei:affiliation/tei:orgName"/>
        </AGENCYNAME>
    </xsl:template>

    <xsl:template match="tei:teiHeader/tei:fileDesc/tei:publicationStmt">
        <EVENTDATETIME>
            <xsl:value-of select="tei:date"/>
        </EVENTDATETIME>
        <PUBLISHER>
            <xsl:value-of select="tei:authority"/>
        </PUBLISHER>
    </xsl:template>

    <xsl:template match="tei:teiHeader/tei:fileDesc/tei:seriesStmt">
        <CONVENTIONDECLARATION>
            <xsl:value-of select="."/>
        </CONVENTIONDECLARATION>
    </xsl:template>

    <xsl:template match="tei:teiHeader/tei:fileDesc/tei:sourceDesc">
        <EVENTDESCRIPTION>
            <xsl:value-of select="."/>
        </EVENTDESCRIPTION>
    </xsl:template>

    <!-- for collaborators -->
    <xsl:template match="tei:teiHeader/tei:fileDesc/tei:titleStmt">
        <xsl:for-each select="tei:respStmt">
            <RESPONSABILITY>
                <xsl:value-of select="child::tei:resp"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="child::tei:name"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="child::tei:persName"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="child::tei:orgName"/>
            </RESPONSABILITY>
        </xsl:for-each>
    </xsl:template>

    <!-- revisionDesc -->
    <xsl:template match="tei:teiHeader/tei:revisionDesc">
        <REVISION>
            <xsl:for-each select="descendant::tei:change">
                <SOURCE>
                    <xsl:value-of select="."/>
                </SOURCE>
            </xsl:for-each>
        </REVISION>
    </xsl:template>


    <!-- ******************     templates for text (listPerson)     ************************ -->
    <xsl:template name="person" match="tei:text/tei:body/tei:listPerson">
        <xsl:for-each select="child::tei:person">
            <NAMEENTRY_TITLE>
                <xsl:value-of select="child::tei:persName"/>
            </NAMEENTRY_TITLE>
            <BIRTH>
                <BIRTH_DATE>
                    <xsl:value-of select="child::tei:birth/@notBefore"/>
                    <xsl:value-of select="child::tei:birth/@notAfter"/>
                    <xsl:value-of select="child::tei:birth/@when"/>
                </BIRTH_DATE>
                <BIRTH_PLACE>
                    <xsl:value-of select="child::tei:birth/tei:placeName"/>
                </BIRTH_PLACE>
            </BIRTH>
            <DEATH>
                <DEATH_DATE>
                    <xsl:value-of select="child::tei:death/@notBefore"/>
                    <xsl:value-of select="child::tei:death/@notAfter"/>
                    <xsl:value-of select="child::tei:death/@when"/>
                </DEATH_DATE>
                <DEATH_PLACE>
                    <xsl:value-of select="child::tei:death/tei:placeName"/>
                </DEATH_PLACE>
            </DEATH>
            <xsl:for-each select="child::tei:occupation">
                <OCCUPATION>
                    <xsl:value-of select="."/>
                </OCCUPATION>
            </xsl:for-each>
            <SOURCES>
                <xsl:for-each select="child::tei:bibl">
                    <SOURCE>
                        <xsl:value-of select="."/>
                    </SOURCE>
                </xsl:for-each>
            </SOURCES>
            
            <!-- § work in progress -->
            <BIOGHIST>
                <xsl:for-each select="child::tei:listEvent/tei:event"/>
                <CRONITEM>
                    <xsl:value-of select="child::tei:listEvent/tei:event"/>
                </CRONITEM>
            </BIOGHIST>
        </xsl:for-each>
    </xsl:template>



</xsl:stylesheet>
