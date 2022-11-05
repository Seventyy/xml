<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:noNameindentchemaLocation="dokument.xsd"
                xmlns:au="http://autor.example.com"
                xmlns:zd="http://zadanie.example.com"
                xmlns:pm="http://płyta.example.com"
                xmlns:wk="http://wykonawca.example.com"
                exclude-result-prefixes="xsi au zd pm wk">
    
    <xsl:output method="xml"
                indent="yes"
                encoding="utf-8"/>
    
    <xsl:variable name="nl">
        <xsl:text>&#xa;</xsl:text>
    </xsl:variable>
    
    <xsl:attribute-set name="all-borders-centered">
        <xsl:attribute name="border-top-style">solid</xsl:attribute>
        <xsl:attribute name="border-top-width">0.2mm</xsl:attribute>
        <xsl:attribute name="border-right-style">solid</xsl:attribute>
        <xsl:attribute name="border-right-width">0.2mm</xsl:attribute>
        <xsl:attribute name="border-left-style">solid</xsl:attribute>
        <xsl:attribute name="border-left-width">0.2mm</xsl:attribute>
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">0.2mm</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="header-attributes">
        <xsl:attribute name="font-family">Arial</xsl:attribute>
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="color">#000080</xsl:attribute>
        <xsl:attribute name="padding">1mm</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="column-name-attributes">
        <xsl:attribute name="font-family">Arial</xsl:attribute>
        <xsl:attribute name="font-size">11pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="field-attributes">
        <xsl:attribute name="font-family">Arial</xsl:attribute>
        <xsl:attribute name="font-size">9pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:template match="/dokument">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="default" margin-left="15mm" margin-right="15mm" margin-top="15mm" margin-bottom="15mm">
                    <fo:region-body/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <xsl:apply-templates/>
        </fo:root>
    </xsl:template>
    
    <xsl:template match="/dokument/nagłówek">
        <fo:page-sequence master-reference="default">
            <fo:flow flow-name="xsl-region-body">
                <fo:table>
                    <fo:table-column column-width="25mm"/>
                    <fo:table-column column-width="25mm"/>
                    <fo:table-column column-width="25mm"/>
                    <fo:table-column column-width="25mm"/>
                    <fo:table-column column-width="25mm"/>
                    <fo:table-column column-width="25mm"/>
                    <fo:table-column column-width="25mm"/>
                    <fo:table-header>
                        <fo:table-row>
                            <fo:table-cell number-columns-spanned="7" text-align="center">
                                <fo:block xsl:use-attribute-sets="header-attributes">
                                    Nagłówek
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Uczelnia</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Wydział</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Przedmiot</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Rok akademicki</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Numer zadania</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Temat zadania</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Termin oddania</fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-header>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="field-attributes">
                                    <xsl:value-of select="uczelnia"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="field-attributes">
                                    <xsl:value-of select="wydział"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="field-attributes">
                                    <xsl:value-of select="przedmiot"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="field-attributes">
                                    <xsl:value-of select="rok_akademicki"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="field-attributes">
                                    <xsl:value-of select="zd:zadanie/zd:numer"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="field-attributes">
                                    <xsl:value-of select="zd:zadanie/zd:temat"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="field-attributes">
                                    <xsl:value-of select="zd:zadanie/zd:termin_oddania"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
                <fo:table>
                    <fo:table-column column-width="44mm"/>
                    <fo:table-column column-width="44mm"/>
                    <fo:table-column column-width="44mm"/>
                    <fo:table-column column-width="44mm"/>
                    <fo:table-header>
                        <fo:table-row>
                            <fo:table-cell number-columns-spanned="4" text-align="center">
                                <fo:block xsl:use-attribute-sets="header-attributes">
                                    Autorzy
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Imiona</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Nazwisko</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Indeks</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Specjalność</fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-header>
                    <fo:table-body>
                        <xsl:apply-templates select="/dokument/nagłówek/au:autorzy/au:autor"/>
                    </fo:table-body>
                </fo:table>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <xsl:template match="/dokument/nagłówek/au:autorzy/au:autor">
        <fo:table-row>
            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                <fo:block xsl:use-attribute-sets="field-attributes" linefeed-treatment="preserve">
                    <xsl:for-each select="au:imię">
                        <xsl:value-of select="concat(text(), $nl)"/>
                    </xsl:for-each>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                <fo:block xsl:use-attribute-sets="field-attributes">
                    <xsl:value-of select="au:nazwisko"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                <fo:block xsl:use-attribute-sets="field-attributes">
                    <xsl:value-of select="au:indeks"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                <fo:block xsl:use-attribute-sets="field-attributes">
                    <xsl:value-of select="au:specjalność"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>

    <xsl:template match="/dokument/pm:płyty_muzyczne">
        <fo:page-sequence master-reference="default">
            <fo:flow flow-name="xsl-region-body">
                <fo:table>
                    <fo:table-column column-width="30mm"/>
                    <fo:table-column column-width="30mm"/>
                    <fo:table-column column-width="30mm"/>
                    <fo:table-column column-width="30mm"/>
                    <fo:table-column column-width="20mm"/>
                    <fo:table-column column-width="20mm"/>
                    <fo:table-column column-width="20mm"/>
                    <fo:table-header>
                        <fo:table-row>
                            <fo:table-cell number-columns-spanned="7">
                                <fo:block xsl:use-attribute-sets="header-attributes">
                                    Płyty muzyczne
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Tytuł</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Wykonawca</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Rok wydania</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Gatunek</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Cena</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Cena (PLN)</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Ocena</fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-header>
                    <fo:table-body>
                        <xsl:apply-templates select="/dokument/pm:płyty_muzyczne/pm:płyta"/>
                    </fo:table-body>
                </fo:table>
            </fo:flow>
        </fo:page-sequence>                    
    </xsl:template>
    
    <xsl:template match="/dokument/pm:płyty_muzyczne/pm:płyta">
        <fo:table-row>
            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                <fo:block xsl:use-attribute-sets="field-attributes">
                    <xsl:value-of select="pm:tytuł"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                <fo:block xsl:use-attribute-sets="field-attributes">
                    <xsl:value-of select="pm:wykonawca"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                <fo:block xsl:use-attribute-sets="field-attributes">
                    <xsl:value-of select="pm:rok_wydania"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                <fo:block xsl:use-attribute-sets="field-attributes" linefeed-treatment="preserve">
                    <xsl:for-each select="pm:gatunek">
                        <xsl:value-of select="concat(text(), $nl)"/>
                    </xsl:for-each>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                <fo:block xsl:use-attribute-sets="field-attributes">
                    <xsl:value-of select="concat(pm:cena, ' ', pm:cena/@waluta)"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                <fo:block xsl:use-attribute-sets="field-attributes">
                    <xsl:value-of select="pm:cena_pln"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                <fo:block xsl:use-attribute-sets="field-attributes">
                    <xsl:value-of select="pm:ocena"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
    <xsl:template match="/dokument/wk:wykonawcy">
        <fo:page-sequence master-reference="default">
            <fo:flow flow-name="xsl-region-body">
                <fo:table>
                    <fo:table-column column-width="40mm"/>
                    <fo:table-column column-width="40mm"/>
                    <fo:table-column column-width="40mm"/>
                    <fo:table-column column-width="40mm"/>
                    <fo:table-header>
                        <fo:table-row>
                            <fo:table-cell number-columns-spanned="4" text-align="center">
                                <fo:block xsl:use-attribute-sets="header-attributes">
                                    Wykonawcy
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Nazwa</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Rok powstania (zespoły)</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Rok urodzenia (artyści)</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Lider/-rzy</fo:block>
                            </fo:table-cell>                         
                        </fo:table-row>
                    </fo:table-header>
                    <fo:table-body>
                        <xsl:apply-templates select="/dokument/wk:wykonawcy/wk:wykonawca"/>
                    </fo:table-body>
                </fo:table>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    <xsl:template match="/dokument/wk:wykonawcy/wk:wykonawca">
        <fo:table-row>
            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                <fo:block xsl:use-attribute-sets="field-attributes">
                    <xsl:value-of select="wk:nazwa"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                <fo:block xsl:use-attribute-sets="field-attributes">
                    <xsl:if test="wk:rok_powstania">
                        <xsl:value-of select="wk:rok_powstania"/>
                    </xsl:if>
                    <xsl:if test="wk:rok_urodzenia">
                        -
                    </xsl:if>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                <fo:block xsl:use-attribute-sets="field-attributes">
                    <xsl:if test="wk:rok_powstania">
                        -
                    </xsl:if>
                    <xsl:if test="wk:rok_urodzenia">
                        <xsl:value-of select="wk:rok_urodzenia"/>
                    </xsl:if>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                <fo:block xsl:use-attribute-sets="field-attributes" linefeed-treatment="preserve">
                    <xsl:choose>                    
                        <xsl:when test="wk:lider">
                           <xsl:for-each select="wk:lider">
                               <xsl:value-of select="concat(text(), $nl)"/>
                           </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            -
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
    <xsl:template match="/dokument/podsumowanie">
        <fo:page-sequence master-reference="default">
            <fo:flow flow-name="xsl-region-body">
                <fo:table>
                    <fo:table-column column-width="40mm"/>
                    <fo:table-column column-width="40mm"/>
                    <fo:table-column column-width="40mm"/>
                    <fo:table-column column-width="40mm"/>
                    <fo:table-header>
                        <fo:table-row>
                            <fo:table-cell number-columns-spanned="4" text-align="center">
                                <fo:block xsl:use-attribute-sets="header-attributes">
                                    Podsumowanie
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Data raportu</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Liczba płyt</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Średnia ocen płyt</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="column-name-attributes">Liczba wykonawców</fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-header>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="field-attributes">
                                    <xsl:value-of select="data_raportu"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="field-attributes">
                                    <xsl:value-of select="płyty/liczba"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="field-attributes">
                                    <xsl:value-of select="płyty/średnia_ocen"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="all-borders-centered">
                                <fo:block xsl:use-attribute-sets="field-attributes">
                                    <xsl:value-of select="wykonawcy/liczba"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
</xsl:stylesheet>
