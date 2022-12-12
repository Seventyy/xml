<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output name="text"/>
    
    <!-- Songs Longest columns: -->
    <xsl:param name="longest_title">
        <xsl:for-each select="music_list/songList/song">
            <xsl:sort select="string-length(@name)" data-type="number" order="ascending"/>
            <xsl:if test="position()=last()">
                <xsl:value-of select="string-length(@name)+3"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:param>
    
    
    <xsl:param name="longest_author">
        <xsl:for-each select="music_list/songList/song">
            <xsl:sort select="string-length(author)" data-type="number" order="ascending"/>
            <xsl:if test="position()=last()">
                <xsl:value-of select="string-length(author)+3"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:param>
    
    <xsl:param name="longest_genre">
        <xsl:for-each select="music_list/songList/song">
            <xsl:sort select="string-length(genre)" data-type="number" order="ascending"/>
            <xsl:if test="position()=last()">
                <xsl:value-of select="string-length(genre)+3"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:param>
    
    <xsl:param name="longest_views">
        <xsl:for-each select="music_list/songList/song">
            <xsl:sort select="string-length(@views)" data-type="number" order="ascending"/>
            <xsl:if test="position()=last()">
                <xsl:value-of select="string-length(@views)+3"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:param>
    
    <!-- authors longes columns: -->
    
    <xsl:param name="longest_name">
        <xsl:for-each select="music_list/authorList/author">
            <xsl:sort select="string-length(name)" data-type="number" order="ascending"/>
            <xsl:if test="position()=last()">
                <xsl:value-of select="string-length(name)+3"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:param>
    
    <xsl:param name="longest_SCFollowers">
        <xsl:for-each select="music_list/authorList/author">
            <xsl:sort select="string-length(@scFollowers)" data-type="number" order="ascending"/>
            <xsl:if test="position()=last()">
                <xsl:value-of select="string-length(@scFollowers)+7"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:param>
    
    <!-- longest genre name: -->

    <xsl:param name="longest_genre_name">
        <xsl:for-each select="music_list/genres/genre">
            <xsl:sort select="string-length(.)" data-type="number" order="ascending"/>
            <xsl:if test="position()=last()">
                <xsl:value-of select="string-length(.)+3"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:param>
    
    <xsl:template match="/">
        <xsl:value-of select="'This is a text file listing all Librarry music, authors and genres (ordered alphabetically): &#xA; &#xA;'"/>
        <xsl:value-of select="'Song List: &#xA;'"/>
        <xsl:value-of select="'======================================================================================================= &#xA;'"/>
        <xsl:call-template name="song_row">
            <xsl:with-param name="Title" select="'Title'"/>
            <xsl:with-param name="Author" select="'Author'"/>
            <xsl:with-param name="Genre" select="'Genre'"/>
            <xsl:with-param name="Date" select="'Date'"/>
            <xsl:with-param name="Views" select="'Views'"/>
            <xsl:with-param name="Languages" select="'Languages'"/>
        </xsl:call-template>
        <xsl:value-of select="'-------------------------------------------------------------------------------------------------------  &#xA;'"/>
        
        <xsl:for-each select="music_list/songList/song">
            <xsl:call-template name="song_row">
                
                <xsl:with-param name="Title" select="@name"/>
                <xsl:with-param name="Author" select="author"/>
                <xsl:with-param name="Genre" select="genre"/>
                <xsl:with-param name="Date" select="@subbmisionDate"/>
                <xsl:with-param name="Views" select="@views"/>
                <xsl:with-param name="Languages" select="@language"/>
                
            </xsl:call-template>
        </xsl:for-each>
        
        <xsl:value-of select="'&#xA; &#xA; Author List: &#xA;'"/>
        <xsl:value-of select="'======================================================================================================= &#xA;'"/>
        <xsl:call-template name="author_row">
            <xsl:with-param name="Name" select="'Name'"/>
            <xsl:with-param name="Debut" select="'Debut'"/>
            <xsl:with-param name="Rating" select="'Rating'"/>
            <xsl:with-param name="SCFollowers" select="'SCFollowers'"/>
            <xsl:with-param name="YTFollowers" select="'YTFollowers'"/>
        </xsl:call-template>
        <xsl:value-of select="'-------------------------------------------------------------------------------------------------------  &#xA;'"/>
        
        <xsl:for-each select="music_list/authorList/author">
            <xsl:call-template name="author_row">
                <xsl:with-param name="Name" select="name"/>
                <xsl:with-param name="Debut" select="@debut"/>
                <xsl:with-param name="Rating" select="@rating"/>
                <xsl:with-param name="SCFollowers" select="@scFollowers"/>
                <xsl:with-param name="YTFollowers" select="@ytFollowers"/>
            </xsl:call-template>
        </xsl:for-each>

        <xsl:value-of select="'&#xA; &#xA; Genre List: &#xA;'"/>
        <xsl:value-of select="'======================================================================================================= &#xA;'"/>
        <xsl:for-each select="music_list/genres/genre">
            <!-- max length of genre name: 40 characters -->
            <xsl:variable name="space_bank" select="'                                        '"/>
            <xsl:value-of select="concat(., substring($space_bank, 1 , ($longest_genre_name - string-length(.))), '- ', @songs_of_genre, ' songs of this genre in the Librarry &#xA;')"/>
        </xsl:for-each>
        
    </xsl:template>
    
    <xsl:template name="song_row">
        
        <xsl:param name="Author"/>
        <xsl:param name="Title"/>
        <xsl:param name="Genre"/>
        <xsl:param name="Date"/>
        <xsl:param name="Views"/>
        <xsl:param name="Languages"/>
        
        <!-- max lenght of any column: 70 characters -->
        <xsl:variable name="space_bank" select="'                                                                      '"/>
        
        <xsl:value-of select="concat(
                $Title,    substring($space_bank, 1, ($longest_title - string-length($Title))), 
                $Author,    substring($space_bank, 1, ($longest_author - string-length($Author))),
                $Genre,     substring($space_bank, 1, ($longest_genre - string-length($Genre))), 
                $Date,      substring($space_bank, 1, (13 - string-length($Date))),
                $Views,     substring($space_bank, 1, ($longest_views - string-length($Views))), 
                $Languages, '&#xA;')"/>
        
    </xsl:template>
    
    <xsl:template name="author_row">
        
        <xsl:param name="Name"/>
        <xsl:param name="Debut"/>
        <xsl:param name="Rating"/>
        <xsl:param name="SCFollowers"/>
        <xsl:param name="YTFollowers"/>
        
        <!-- max lenght of any column: 70 characters -->
        <xsl:variable name="space_bank" select="'                                                                      '"/>
        
        <xsl:value-of select="concat(
                $Name,          substring($space_bank, 1, ($longest_name - string-length($Name))), 
                $Debut,         substring($space_bank, 1, (8 - string-length($Debut))),
                $Rating,        substring($space_bank, 1, (9 - string-length($Rating))), 
                $SCFollowers,   substring($space_bank, 1, ($longest_SCFollowers - string-length($SCFollowers))),
                $YTFollowers,   '&#xA;')"/>
        
    </xsl:template>
    
</xsl:stylesheet>
