<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output name="text"/>
    
    <xsl:param name="max_length_title">
        <xsl:for-each select="steam/games/game">
            <xsl:sort select="string-length(@title)" data-type="number" order="ascending"/>
            <xsl:if test="position()=last()">
                <xsl:value-of select="string-length(@title)+5"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:param> 
    
    <xsl:param name="max_length_developer">
        <xsl:for-each select="steam/games/game">
            <xsl:sort select="string-length(developer)" data-type="number" order="ascending"/>
            <xsl:if test="position()=last()">
                <xsl:value-of select="string-length(developer)+5"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:param>
    
    <xsl:param name="max_length_reviews">
        <xsl:for-each select="steam/games/game">
            <xsl:sort select="string-length(steam_reviews)" data-type="number" order="ascending"/>
            <xsl:if test="position()=last()">
                <xsl:value-of select="string-length(steam_reviews)+5"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:param>
    
    <xsl:param name="max_length_price">
        <xsl:for-each select="steam/games/game">
            <xsl:sort select="string-length(price_in_euro)" data-type="number" order="ascending"/>
            <xsl:if test="position()=last()">
                <xsl:value-of select="string-length(price_in_euro)"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:param>
    
    <xsl:variable name="max_length_date" select="10 + 1"/>    

    <xsl:template match="/">
        <xsl:value-of select="'&#xa;'"/>
        <xsl:call-template name="game_row">
            <xsl:with-param name="title" select="'Title'"/>
            <xsl:with-param name="developer" select="'Developer'"/>
            <xsl:with-param name="price" select="'Price'"/>
            <xsl:with-param name="reviews" select="'Reviews'"/>
            <xsl:with-param name="release_date" select="'Release'"/>
        </xsl:call-template>
        <xsl:value-of select="'----------------------------------------------------------------------------------------------------------- &#xa;'"/>
        
        <xsl:for-each select="steam/games/game">
            <xsl:call-template name="game_row">
                
                <xsl:with-param name="title" select="@title"/>
                <xsl:with-param name="developer" select="developer"/>
                <xsl:with-param name="price" select="price_in_euro"/>
                <xsl:with-param name="reviews" select="steam_reviews"/>
                <xsl:with-param name="release_date" select="release_date"/>
                
            </xsl:call-template>
        </xsl:for-each>

        
    </xsl:template>

    <xsl:template name="game_row">
        
        <xsl:param name="title"/>
        <xsl:param name="developer"/>
        <xsl:param name="price"/>
        <xsl:param name="reviews"/>
        <xsl:param name="release_date"/>
        
        <xsl:variable name="empty_row" select="'                                                                                                    '"/>
        
        <xsl:value-of select="concat(
            $title, substring($empty_row, 1, ($max_length_title - string-length($title))), '| ',
            $developer, substring($empty_row, 1, ($max_length_developer - string-length($developer))), '| ',
            substring($empty_row, 1, ($max_length_price - string-length($price))), $price, ' | ',
            $release_date, substring($empty_row, 1, ($max_length_date - string-length($release_date))), '| ',
            $reviews, '&#xA;')"/>
        
    </xsl:template>
    
</xsl:stylesheet>
