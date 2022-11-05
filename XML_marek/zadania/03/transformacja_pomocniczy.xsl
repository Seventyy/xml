<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="dokument.xsd" xmlns:au="http://autor.example.com" xmlns:zd="http://zadanie.example.com" xmlns:pm="http://płyta.example.com" xmlns:wk="http://wykonawca.example.com">
	<xsl:output method="xml" encoding="utf-8" indent="yes"/>
	
	<xsl:template match="/dokument">
		<dokument>
			<xsl:apply-templates/>
			<xsl:call-template name="podsumowanie"/>
		</dokument>
	</xsl:template>
	
	<xsl:template match="/dokument/nagłówek">
		<nagłówek>
			<xsl:copy-of select="uczelnia"/>
			<xsl:copy-of select="wydział"/>
			<xsl:copy-of select="przedmiot"/>
			<xsl:copy-of select="rok_akademicki"/>
			<zd:zadanie>
				<xsl:apply-templates select="zd:zadanie"/>
			</zd:zadanie>
			<au:autorzy>
				<xsl:apply-templates select="au:autorzy/au:autor"/>
			</au:autorzy>
		</nagłówek>
	</xsl:template>
	
	<xsl:template match="/dokument/nagłówek/zd:zadanie">
		<zd:numer>
			<xsl:value-of select="./@numer"/>
		</zd:numer>
		<xsl:copy-of select="zd:temat"/>
		<xsl:copy-of select="zd:termin_oddania"/>
	</xsl:template>
	
	<xsl:template match="/dokument/nagłówek/au:autorzy/au:autor">
		<au:autor>
			<xsl:copy-of select="au:imię"/>
			<xsl:copy-of select="au:nazwisko"/>
			<xsl:copy-of select="au:indeks"/>
			<au:specjalność>
				<xsl:value-of select="./@specjalność"/>
			</au:specjalność>
		</au:autor>
	</xsl:template>
	
	<xsl:template match="/dokument/pm:płyty_muzyczne">
		<pm:płyty_muzyczne>
			<xsl:for-each select="/dokument/pm:płyty_muzyczne/pm:płyta">
				<xsl:sort select="pm:rok_wydania" data-type="text" order="descending"/>
				<xsl:apply-templates select="."/>
			</xsl:for-each>
		</pm:płyty_muzyczne>
	</xsl:template>
	
	<xsl:template match="/dokument/pm:płyty_muzyczne/pm:płyta">
		<pm:płyta>
			<xsl:copy-of select="pm:tytuł"/>
			<xsl:variable name="wykonawca" select="./@id_wykonawcy"/>
			<pm:wykonawca>
				<xsl:value-of select="/dokument/wk:wykonawcy/wk:wykonawca[@id_wykonawcy=$wykonawca]/wk:nazwa"/>
			</pm:wykonawca>
			<xsl:copy-of select="pm:rok_wydania"/>
			<xsl:copy-of select="pm:gatunek"/>
			<xsl:copy-of select="pm:cena"/>
			<xsl:variable name="cena" select="./pm:cena"/>
			<pm:cena_pln>
				<xsl:if test="./pm:cena/@waluta = 'PLN'">
					<xsl:value-of select="format-number(pm:cena, '0.00')"/>
				</xsl:if>
				<xsl:if test="./pm:cena/@waluta = 'USD'">
					<xsl:value-of select="format-number(pm:cena * 3.85, '0.00')"/>
				</xsl:if>
				<xsl:if test="./pm:cena/@waluta = 'EUR'">
					<xsl:value-of select="format-number(pm:cena * 4.29, '0.00')"/>
				</xsl:if>
				<xsl:if test="./pm:cena/@waluta = 'GBP'">
					<xsl:value-of select="format-number(pm:cena * 4.97, '0.00')"/>
				</xsl:if>
				<xsl:if test="./pm:cena/@waluta = 'AUD'">
					<xsl:value-of select="format-number(pm:cena * 2.70, '0.00')"/>
				</xsl:if>
				<xsl:if test="./pm:cena/@waluta = 'JPY'">
					<xsl:value-of select="format-number(pm:cena * 3.44, '0.00')"/>
				</xsl:if>
				<xsl:if test="./pm:cena/@waluta = 'CHF'">
					<xsl:value-of select="format-number(pm:cena * 3.77, '0.00')"/>
				</xsl:if>
			</pm:cena_pln>
			<pm:ocena>
				<xsl:value-of select="./@ocena"/>
			</pm:ocena>
			<xsl:copy-of select="pm:okładka"/>
		</pm:płyta>
	</xsl:template>
	
	<xsl:template match="/dokument/wk:wykonawcy">
		<wk:wykonawcy>
			<xsl:for-each select="/dokument/wk:wykonawcy/wk:wykonawca">
				<xsl:sort select="wk:nazwa" data-type="text" lang="pl"/>
				<xsl:apply-templates select="."/>
			</xsl:for-each>
		</wk:wykonawcy>
	</xsl:template>
	
	<xsl:template match="/dokument/wk:wykonawcy/wk:wykonawca">
		<wk:wykonawca>
			<xsl:copy-of select="wk:nazwa"/>
			<xsl:copy-of select="wk:rok_powstania"/>
			<xsl:copy-of select="wk:rok_urodzenia"/>
			<xsl:copy-of select="wk:lider"/>
		</wk:wykonawca>
	</xsl:template>
	
	<xsl:template name="podsumowanie">
		<podsumowanie>
			<data_raportu>
				<xsl:value-of select="format-date(current-date(), '[D01]-[M01]-[Y0001]')"/>
			</data_raportu>
			<płyty>
				<liczba>
					<xsl:value-of select="count(//pm:płyta)"/>
				</liczba>
				<średnia_ocen>
					<xsl:value-of select="format-number(sum(//pm:płyta/@ocena) div count(//pm:płyta/@ocena), '#.00')"/>
				</średnia_ocen>
			</płyty>
			<wykonawcy>
				<liczba>
					<xsl:value-of select="count(//wk:wykonawca)"/>
				</liczba>
			</wykonawcy>
		</podsumowanie>
	</xsl:template>
	
</xsl:stylesheet>
