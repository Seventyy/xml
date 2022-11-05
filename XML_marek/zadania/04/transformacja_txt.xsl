<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:noNameindentchemaLocation="dokument.xsd"
                xmlns:au="http://autor.example.com"
                xmlns:zd="http://zadanie.example.com"
                xmlns:pm="http://płyta.example.com"
                xmlns:wk="http://wykonawca.example.com"
                exclude-result-prefixes="xsi au zd pm wk">
    <xsl:output method="text"
                encoding="utf-8"/>

    <xsl:variable name="nl">
        <xsl:text>&#xa;</xsl:text>
    </xsl:variable>
    
    <xsl:template name="format">
        <xsl:param name="text"/>
        <xsl:param name="length"/>
        <xsl:choose>
            <xsl:when test="string-length($text) &lt; $length">
                <xsl:call-template name="format">
                    <xsl:with-param name="text" select="concat($text, $text)"/>
                    <xsl:with-param name="length" select="$length"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="substring($text, 1, $length)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:apply-templates/> 
    </xsl:template>
    
    <xsl:template match="/dokument/nagłówek">
		<xsl:value-of select="$nl"/>
		<xsl:value-of select="concat('Dokument TXT', $nl)"/>
        <xsl:value-of select="$nl"/>
        <xsl:value-of select="concat(uczelnia, $nl)"/>
        <xsl:value-of select="concat('Wydział ', wydział, $nl)"/>
        <xsl:value-of select="concat('Przedmiot: ', przedmiot, $nl)"/>
        <xsl:value-of select="concat('Rok akademicki: ', rok_akademicki, $nl)"/>
		<xsl:text>Zadanie:</xsl:text>
		<xsl:value-of select="$nl"/>
        <xsl:apply-templates select="zd:zadanie"/>
        <xsl:apply-templates select="au:autorzy"/>
    </xsl:template>
    
    <xsl:template match="/dokument/nagłówek/zd:zadanie">
        <xsl:variable name="indent">2</xsl:variable>
        <xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
        <xsl:value-of select="concat('Numer: ', zd:numer, $nl)"/>
        <xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
        <xsl:value-of select="concat('Temat: ', zd:temat, $nl)"/>
        <xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
        <xsl:value-of select="concat('Termin oddania: ', zd:termin_oddania, $nl)"/>
    </xsl:template>
    
    <xsl:template match="/dokument/nagłówek/au:autorzy">
        <xsl:text>Autorzy:</xsl:text>
        <xsl:value-of select="$nl"/>
        <xsl:value-of select="$nl"/>
        <xsl:apply-templates select="au:autor"/>
    </xsl:template>
    
    <xsl:template match="/dokument/nagłówek/au:autorzy/au:autor">
        <xsl:variable name="indent">2</xsl:variable>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
        <xsl:for-each select="au:imię">
			<xsl:value-of select="concat(text(), ' ')"/>
        </xsl:for-each>
        <xsl:value-of select="concat(au:nazwisko, $nl)"/>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat('Indeks: ', au:indeks, $nl)"/>
        <xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
        <xsl:value-of select="concat('Specjalność: ', au:specjalność, $nl)"/>
        <xsl:value-of select="$nl"/>
    </xsl:template>
    
    <xsl:template match="/dokument/pm:płyty_muzyczne">
        <xsl:value-of select="$nl"/>
        <xsl:text>Płytoteka:</xsl:text>
        <xsl:value-of select="$nl"/>
        <xsl:value-of select="$nl"/>
        <xsl:apply-templates select="pm:płyta"/>
    </xsl:template>
    
    <xsl:template match="/dokument/pm:płyty_muzyczne/pm:płyta">
		<xsl:variable name="indent">2</xsl:variable>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat('Tytuł: ', pm:tytuł, $nl)"/>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat('Wykonawca: ', pm:wykonawca, $nl)"/>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat('Rok wydania: ', pm:rok_wydania, $nl)"/>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat('Gatunek:', $nl)"/>
		<xsl:for-each select="pm:gatunek">
			<xsl:variable name="indent_gatunek">4</xsl:variable>
			<xsl:call-template name="format"><xsl:with-param name="text" select="' '" /><xsl:with-param name="length" select="$indent_gatunek" /></xsl:call-template>
			<xsl:value-of select="concat(text(), $nl)"/>
        </xsl:for-each>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat('Cena: ', pm:cena, ' ', pm:cena/@waluta, $nl)"/>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat('Cena w PLN: ', pm:cena_pln, $nl)"/>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat('Ocena: ', pm:ocena, $nl)"/>
		<xsl:value-of select="$nl"/>
    </xsl:template>
    
    <xsl:template match="/dokument/wk:wykonawcy">
        <xsl:value-of select="$nl"/>
        <xsl:text>Wykonawcy:</xsl:text>
        <xsl:value-of select="$nl"/>
        <xsl:value-of select="$nl"/>
        <xsl:apply-templates select="wk:wykonawca"/>
    </xsl:template>
    
    <xsl:template match="/dokument/wk:wykonawcy/wk:wykonawca">
		<xsl:variable name="indent">2</xsl:variable>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat('Nazwa: ', wk:nazwa, $nl)"/>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
		<xsl:if test="wk:rok_powstania">
			<xsl:value-of select="concat('Rok powstania: ', wk:rok_powstania, $nl)"/>
		</xsl:if>
		<xsl:if test="wk:rok_urodzenia">
			<xsl:value-of select="concat('Rok urodzenia: ', wk:rok_urodzenia, $nl)"/>
		</xsl:if>
		<xsl:if test="wk:lider">
			<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
			<xsl:value-of select="concat('Lider/-rzy:', $nl)"/>
			<xsl:for-each select="wk:lider">
				<xsl:variable name="indent_lider">4</xsl:variable>
				<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent_lider"/></xsl:call-template>
				<xsl:value-of select="concat(text(), $nl)"/>
			</xsl:for-each>
		</xsl:if>

       <xsl:value-of select="$nl"/>
    </xsl:template>
    
    <xsl:template match="/dokument/podsumowanie">
		<xsl:variable name="indent">2</xsl:variable>
		<xsl:value-of select="$nl"/>
		<xsl:text>Podsumowanie:</xsl:text>
		<xsl:value-of select="$nl"/>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat('Data raportu: ', data_raportu, $nl)"/>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat('Liczba płyt: ', płyty/liczba, $nl)"/>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
        <xsl:value-of select="concat('Wartość płyt w PLN: ', format-number(sum(//pm:płyta/pm:cena_pln), '#.00'), $nl)"/>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '"/><xsl:with-param name="length" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat('Średnia ocen: ', płyty/średnia_ocen, $nl)"/>
		<xsl:call-template name="format"><xsl:with-param name="text" select="' '" /><xsl:with-param name="length" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat('Liczba wykonawców: ', wykonawcy/liczba, $nl)"/>
    </xsl:template>
    
</xsl:stylesheet>
