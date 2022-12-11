<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:genre="http://genre.types.com"
                xmlns:music="http://music.types.com"
                xmlns:author="http://author.types.com" 
                version="1.0">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    
    <xsl:key name="ThisGenre" match="music_list/songList/music:song/genre" use="@genreID"/>
    
    <xsl:template match="/">  
        <xsl:element name="music_list">
            
            
            <xsl:element name="genres">
                
                <xsl:for-each select="music_list/genreList/genre:genre">
                    <xsl:sort select="." order="ascending"/>
                    <xsl:variable name="G_ID" select="@genreID"/>
                    
                    <xsl:element name="genre">
                        
                        <xsl:attribute name="songs_of_genre">
                            <xsl:value-of select="count(key('ThisGenre', $G_ID))"/>
                            <!--<xsl:value-of select="count(../../songList/music:song/genre[@genreID = $G_ID])"/>--> 
                        </xsl:attribute>
                        <xsl:value-of select="."/>
                        
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
            
            <xsl:element name="songList">
                <xsl:for-each select="music_list/songList/music:song">
                    <xsl:sort select="name" order="ascending"/>
                    <xsl:variable name="SG_ID" select="genre/@genreID"/>
                    <xsl:variable name="SA_ID" select="author/@authorID"/>
                    
                    <xsl:element name="song">
                        
                        <xsl:attribute name="name" select="name"/>
                        <xsl:attribute name="views" select="views"/>
                        <xsl:attribute name="subbmisionDate" select="subbmisionDate"/>
                        <xsl:attribute name="language" select="languagesUsed"/>
                        
                        <xsl:element name="genre">
                            <xsl:value-of select="../../genreList/genre:genre[@genreID = $SG_ID]"/>
                        </xsl:element>
                        <xsl:element name="author">
                            <xsl:value-of select="../../authorList/author:author/name[../@authorID = $SA_ID]"/>
                        </xsl:element>
                        
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
            
            <xsl:element name="authorList">
                <xsl:for-each select="music_list/authorList/author:author">
                    <xsl:sort select="name" order="ascending"/>
                    <xsl:element name="author">
                        <xsl:call-template name="autor_template"/>
                    </xsl:element>
                    
                </xsl:for-each>
            </xsl:element>
            
            <xsl:call-template name="List_Statistics"/>
            
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="List_Statistics">
        
        <xsl:element name="songStats">
            
            <xsl:attribute name="whole_time_in_seconds" select="sum(music_list/songList/music:song/wholeLength/(seconds-from-duration(@time)+minutes-from-duration(@time)*60))"/>
            <xsl:attribute name="whole_time_in_minutes" select="'~',floor(sum(music_list/songList/music:song/wholeLength/(minutes-from-duration(@time)+seconds-from-duration(@time)div 60)))"/>
            <xsl:element name="songs_in_library">
                <xsl:value-of select="count(music_list/songList/music:song)"/>
            </xsl:element>
            
        </xsl:element>
        
        <xsl:variable name="sum_authors" select="count(music_list/authorList/author:author)"/>
        <xsl:element name="authorStats">
            
            <xsl:attribute name="avergae_rating" select="floor(sum(music_list/authorList/author:author/number(substring(rating, 1,2))) div $sum_authors)"/>
            <xsl:element name="authors_in_library">
                <xsl:value-of select="$sum_authors"/>
            </xsl:element>
            
        </xsl:element>
        
    </xsl:template>
    
    
    <xsl:template name="autor_template">
        
        <xsl:attribute name="debut" select="debut"/>
        <xsl:attribute name="rating" select="rating"/>
        <xsl:attribute name="rating_numeric" select="
            if(string-length(rating)=5) 
                then(number(substring(rating, 1,1))) 
            else(number(substring(rating, 1,2)))"/>
        
        <xsl:if test="contains(scFollowers/@units, 'thousand')">
            <xsl:attribute name="scFollowers" select="scFollowers/@amount*(1000)"/>
        </xsl:if>
        <xsl:if test="contains(scFollowers/@units, 'million')">
            <xsl:attribute name="scFollowers" select="scFollowers/@amount*(1000000)"/>
        </xsl:if>
        
        <xsl:if test="contains(ytFollowers/@units, 'thousand')">
            <xsl:attribute name="ytFollowers" select="ytFollowers/@amount*(1000)"/>
        </xsl:if>
        <xsl:if test="contains(ytFollowers/@units, 'million')">
            <xsl:attribute name="ytFollowers" select="ytFollowers/@amount*(1000000)"/>
        </xsl:if>
        
        <xsl:element name="name">
            <xsl:value-of select="name"/>
        </xsl:element>
        
    </xsl:template>
    
    
</xsl:stylesheet>