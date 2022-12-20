<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="dokument.xsd" xmlns:au="http://autor.example.com" xmlns:zd="http://zadanie.example.com" xmlns:pm="http://płyta.example.com" xmlns:wk="http://wykonawca.example.com" exclude-result-prefixes="xsi au zd pm wk">
    
    <xsl:output method="xhtml"
                version="1.0"
                encoding="utf-8"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
                doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                omit-xml-declaration="no" 
                indent="yes" />
    
    <xsl:template match="/dokument">
        <html>
            <head>
                <title>Płytoteka</title>
            </head>
            <body>
                <h1>Dokument XHTML 1.0 Strict</h1>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="/dokument/nagłówek">
        <h3>
            <xsl:value-of select="uczelnia"/><br/>
            <xsl:value-of select="wydział"/><br/>
            <xsl:value-of select="przedmiot"/><br/>
            <xsl:value-of select="rok_akademicki"/><br/>
        </h3>
        <p style="font-size: large;">Zadanie:</p>
        <xsl:apply-templates select="zd:zadanie"/>
        <p style="font-size: large;">Autorzy:</p>
        <xsl:apply-templates select="au:autorzy/au:autor"/>
    </xsl:template>
        
    <xsl:template match="/dokument/nagłówek/zd:zadanie">
        <div>
            <p style="font-size: large;">
                <span>
                    Numer: <xsl:value-of select="zd:numer"/>
                </span>
                <br/>
                <span style="font-style: italic;">
                    Temat: <xsl:value-of select="zd:temat"/>
                </span>
                <br/>
                <span>
                    Termin oddania: <xsl:value-of select="zd:termin_oddania"/>
                </span>
                <br/>
            </p>
        </div>
	</xsl:template>
    
    <xsl:template match="/dokument/nagłówek/au:autorzy/au:autor">
        <div>
            <p style="font-size: large;">
                <span>
                    <xsl:value-of select="au:imię"/>
                </span>
                <span style="font-variant: small-caps;">
                    &#160;<xsl:value-of select="au:nazwisko"/>
                </span>
                <br/>
                <span style="font-style: italic;">
                    <xsl:value-of select="au:indeks"/>
                </span>
                <br/>
                <span>
                    <xsl:value-of select="au:specjalność"/>
                </span>
            </p>
        </div>
    </xsl:template>
    
    <xsl:template match="/dokument/pm:płyty_muzyczne">
        <table>
            <tr>
                <th>Płyty muzyczne:</th>
            </tr>
            <xsl:for-each select="/dokument/pm:płyty_muzyczne/pm:płyta">
                <xsl:apply-templates select="."/>     
            </xsl:for-each>                            
        </table>
        <br/>
    </xsl:template>
    
    <xsl:template match="/dokument/pm:płyty_muzyczne/pm:płyta">
        <tr>
            <td>
				<img alt="Okładka albumu" width="200" height="200">
					<xsl:attribute name="src">
						<xsl:value-of select="pm:okładka"/>
					</xsl:attribute>
				</img>
                <p style="font-weight: bold;">Tytuł: <xsl:value-of select="pm:tytuł"/></p>
                <p>Wykonawca: <xsl:value-of select="pm:wykonawca"/></p>
                <p>Rok wydania: <xsl:value-of select="pm:rok_wydania"/></p>
                <p>Gatunek: </p>
                <ul>
					<xsl:for-each select="pm:gatunek">
						<li><xsl:value-of select="text()"/></li>
					</xsl:for-each>
				</ul>
                <p>Cena: <xsl:value-of select="concat('Cena: ', pm:cena, ' ', pm:cena/@waluta)"/></p>
                <p>Cena w PLN: <xsl:value-of select="pm:cena_pln"/></p>
                <p>Ocena: <xsl:value-of select="pm:ocena"/></p>
                <br/>
                <br/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="/dokument/wk:wykonawcy">
        <table>
            <tr>
                <th>Wykonawcy:</th>
            </tr>
            <xsl:for-each select="/dokument/wk:wykonawcy/wk:wykonawca">
                <xsl:apply-templates select="."/>     
            </xsl:for-each>                            
        </table>
        <br/>
    </xsl:template>
    
	<xsl:template match="/dokument/wk:wykonawcy/wk:wykonawca">
		<tr>
			<td>
				<p style="font-weight: bold;">Nazwa: <xsl:value-of select="wk:nazwa"/></p>
				<xsl:if test="wk:rok_powstania"><p>Rok powstania: <xsl:value-of select="wk:rok_powstania"/></p></xsl:if>
				<xsl:if test="wk:rok_urodzenia"><p>Rok urodzenia: <xsl:value-of select="wk:rok_urodzenia"/></p></xsl:if>
				<xsl:if test="wk:lider">
					<p>Lider/-rzy: </p>
					<ul>
						<xsl:for-each select="wk:lider">
							<li><xsl:value-of select="text()"/></li>
						</xsl:for-each>
					</ul>
				</xsl:if>
			</td>
		</tr>
	</xsl:template>
    
    <xsl:template match="/dokument/podsumowanie">
		<table>
			<tr>
				<th>Podsumowanie:</th>
			</tr>
			<tr>
				<td>
					<p>Data raportu: <xsl:value-of select="data_raportu"/></p>
					<p>Liczba płyt: <xsl:value-of select="płyty/liczba"/></p>
					<p>Suma wartości płyt: <xsl:value-of select="format-number(sum(//pm:płyta/pm:cena_pln), '#.00')"/> PLN</p>
					<p>Średnia ocen płyt: <xsl:value-of select="płyty/średnia_ocen"/></p>
					<p>Liczba wykonawców: <xsl:value-of select="wykonawcy/liczba"/></p>
				</td>
			</tr>
		</table>
    </xsl:template>
    
</xsl:stylesheet>