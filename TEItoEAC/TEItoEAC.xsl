<?xml version="1.0" encoding="UTF-8"?>
<!-- @sgraziella https://github.com/sgraziella/prosopography_LJP
    Draft for basic transformation from TEI person to EAC-CPF to XML 
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
            <xsl:apply-templates/>
        </control>
    </xsl:template>


    <!-- ********************** templates for text ****************************** -->
    <xsl:template match="tei:person">
        <cpfDescription>
            <xsl:apply-templates/>
        </cpfDescription>
    </xsl:template>

    <!-- défini le nameEntry principal -->
    <xsl:template match="tei:listPerson/tei:person/tei:persName[@xml:lang = 'en']">
        <identity>
            <entityType>person</entityType>
            <nameEntry>
                <xsl:apply-templates/>
            </nameEntry>
        </identity>
    </xsl:template>
    
    <!-- exclu pour le moment les autres langues -->
    <xsl:template match="tei:listPerson/tei:person/tei:persName[@xml:lang = 'la']"/>

    <!-- défini le nameEntry principal -->
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
