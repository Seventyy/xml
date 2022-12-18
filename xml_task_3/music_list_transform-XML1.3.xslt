<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:developers="http://developers.com"
    xmlns:games="http://games.com"
    version="1.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />

    <xsl:template match="/">
        <xsl:element name="steam">

            <xsl:element name="games">
                <xsl:for-each select="steam/games/games:game">
                    <xsl:sort select="title" order="ascending" />
                    <xsl:variable name="dev_id" select="@developer_id" />

                    <xsl:element name="game">
                        <xsl:attribute name="title">
                            <xsl:value-of name="title" select="title" />
                        </xsl:attribute>
                        <xsl:element name="developer">
                            <xsl:value-of select="../../developers/developers:developer/name[../@developer_id = $dev_id]" />
                        </xsl:element>
                        <xsl:element name="steam_reviews">
                            <xsl:value-of name="steam_reviews" select="steam_reviews" />
                        </xsl:element>
                        <xsl:element name="release_date">
                            <xsl:value-of name="release_date" select="release_date" />
                        </xsl:element>
                        <xsl:element name="price_in_euro">
                            <xsl:value-of name="price" select="floor(price*(0.20+0.01))" />
                            <xsl:value-of name="price" select="'.00'" />
                        </xsl:element>

                    </xsl:element>
                </xsl:for-each>
            </xsl:element>

            <xsl:call-template name="statistics" />

        </xsl:element>
    </xsl:template>

    <xsl:template name="statistics">
        <xsl:element name="statistics">
            <xsl:variable name="games_amount" select="count(steam/games/games:game)" />
            <xsl:element name="games_amount">
                <xsl:attribute name="average_price">
                    <xsl:value-of select="round(sum(steam/games/games:game/price) div $games_amount * 21) div 100" />
                </xsl:attribute>
                <xsl:value-of select="$games_amount" />
            </xsl:element>
        </xsl:element>


    </xsl:template>


</xsl:stylesheet>