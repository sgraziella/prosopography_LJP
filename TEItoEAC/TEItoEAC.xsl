<?xml version="1.0" encoding="UTF-8"?>
<!-- @sgraziella https://github.com/sgraziella/prosopography_LJP
    Draft for basic transformation from TEI person to EAC-CPF
    Could be used in order to add a pre-intermediate stylesheet on XMLImport Omeka plugin
    *** person ****
    version 0.1 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:eac="urn:isbn:1-931666-33-4"
    exclude-result-prefixes="xs xlink eac tei" version="1.0">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <!-- main -->
    <xsl:template match="/">
        <eac-cpf xsi:schemaLocation="urn:isbn:1-931666-33-4 cpf.xsd" xmlns="urn:isbn:1-931666-33-4"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink">
            <xsl:apply-templates/>
        </eac-cpf>
    </xsl:template>


    <!-- ********************* templates for teiHeader *************************** -->
    <xsl:template match="tei:teiHeader">
        <control>
            <recordID>
                <xsl:value-of select="child::tei:fileDesc/tei:titleStmt/tei:title"/>
            </recordID>
            <maintenanceAgency>
                <agencyName>
                    <xsl:value-of select="child::tei:fileDesc/tei:titleStmt/tei:principal/tei:affiliation"/>
                </agencyName>
            </maintenanceAgency>
            <xsl:apply-templates/>
        </control>
    </xsl:template>

    <!-- creation + enconding + date -->
    <xsl:template match="tei:teiHeader/tei:fileDesc/tei:titleStmt">
        <maintenanceHistory>
            <maintenanceEvent>
                <eventType>created by</eventType>
                <agent>
                    <xsl:value-of select="child::tei:principal/tei:persName"/>
                </agent>
                <eventDateTime>
                    <xsl:value-of select="following-sibling::tei:publicationStmt/tei:date"/>
                </eventDateTime>
            </maintenanceEvent>
            <maintenanceEvent>
                <eventType>
                    <xsl:value-of select="child::tei:respStmt/tei:resp"/>
                </eventType>
                <agent>
                    <xsl:value-of select="child::tei:respStmt/tei:persName"/>
                </agent>
            </maintenanceEvent>
        </maintenanceHistory>
    </xsl:template>
    
    <!-- exclude publicationStmt in this position -->
    <xsl:template match="tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
    
    <!-- exclude seriesStmt in this position -->
    <xsl:template match="tei:teiHeader/tei:fileDesc/tei:seriesStmt"/>
    
    <!-- sources / one source per paragraph -->
    <xsl:template match="tei:teiHeader/tei:fileDesc/tei:sourceDesc">
        <sources>
        <xsl:for-each select="child::tei:p">
            <source>
               <xsl:value-of select="."/>
            </source>
        </xsl:for-each>
        </sources>
    </xsl:template>



    <!-- ********************** templates for text ****************************** -->
    <xsl:template match="tei:person">
        <cpfDescription>
            <xsl:apply-templates/>
        </cpfDescription>
    </xsl:template>

    <!-- principal nameEntry -->
    <xsl:template match="tei:listPerson/tei:person/tei:persName[@xml:lang = 'en']">
        <identity>
            <entityType>person</entityType>
            <nameEntry>
                <xsl:apply-templates/>
            </nameEntry>
        </identity>
    </xsl:template>

    <!-- excluding others languages -->
    <xsl:template match="tei:listPerson/tei:person/tei:persName[@xml:lang = 'la']"/>

    <!-- range of dates $ in progress -->
    <xsl:template match="tei:listPerson/tei:person/tei:birth">
        <description>
            <existDates>
                <dateRange>
                    <xsl:apply-templates/>
                </dateRange>
            </existDates>
        </description>
    </xsl:template>

</xsl:stylesheet>
