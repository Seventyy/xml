<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                version="2.0">
    

    <!-- this output method does not work -->
    <xsl:output method="xhtml" 
                omit-xml-declaration="yes" 
                indent="yes" 
                encoding="UTF-8"
                version="1.0"
                doctype-public="-//W3C//DTD XHTML 1.1//EN" 
                />
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Music_List</title>
                <style type="text/css">
                    
                    * {
                    box-sizing: border-box;
                    }
                    
                    body {
                    font-family: Arial;
                    margin: 0;
                    }
                    
                    .header {
                    padding: 30px;
                    text-align: center;
                    color: white;
                    font-size: 24px;
                    background: #4257f5;
                    }
                    
                    .header h1 {
                    font-size: 36px;
                    }
                    
                    .divider {
                    width: auto;
                    padding: 20px;
                    background-color: #2c2a31;
                    }
                    
                    .caption {
                    text-align: left;
                    font-size: 24px;
                    margin-bottom: 20px;
                    margin-right: 60%;
                    color: white;
                    background: #4257f5;
                    padding: 20px;
                    }
                    
                    .main {
                    background-color: white;
                    font-size: 20px;
                    padding: 20px;
                    }
                    
                    table, th, td { 
                    font-size: 18px; 
                    border: 3px solid white;
                    margin-bottom: 30px;
                    }
                    
                    th {
                    color: white;
                    background: #505dbd;
                    padding: 15px;
                    font-size: 20px;
                    }
                    
                    td {
                    background: #cbd0f7;
                    padding: 10px;
                    }
                    
                </style>
            </head>
            
            
            <body>
                <div class="header">
                    <h1>My Music Library</h1>
                    <p>Made by Filip Andrzejewski, id: 242207</p>
                </div>
                
                <div class="divider"/>
                
                
                <div class="main">
                    
                    <div class="caption">
                        <b>SONGS</b>
                    </div>
                    <table>
                        <tr>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Genre</th>
                            <th>Date</th>
                            <th>Views</th>
                            <th>language</th>
                        </tr>
                        <xsl:for-each select="music_list/songList/song">
                            <xsl:sort select="@views" data-type="number" order="descending"/>
                            <tr>
                                <td style="background-color:#a7d2d7"><xsl:value-of select="@name"/></td>
                                <td ><xsl:value-of select="author"/></td>
                                <td ><xsl:value-of select="genre"/></td>
                                <td ><xsl:value-of select="@subbmisionDate"/></td>
                                <td ><xsl:value-of select="@views"/></td>
                                <td ><xsl:value-of select="@language"/></td>
                            </tr>
                        </xsl:for-each>
                    </table>
                    
                    <div class="caption">
                        <b>AUTHORS</b>
                    </div>
                    <table>
                        <tr>
                            <th>Name</th>
                            <th>Rating</th>
                            <th>Debut</th>
                            <th>SC_Followers</th>
                            <th>YT_Followers</th>
                        </tr>
                        <xsl:for-each select="music_list/authorList/author">
                            <xsl:sort select="@rating_numeric" data-type="number" order="descending"/>
                            <tr>
                                <td style="background-color:#caa7d7"><xsl:value-of select="name"/></td>
                                <td ><xsl:value-of select="@rating"/></td>
                                <td ><xsl:value-of select="@debut"/></td>
                                <td ><xsl:value-of select="@scFollowers"/></td>
                                <td ><xsl:value-of select="@ytFollowers"/></td>
                            </tr>
                        </xsl:for-each>
                    </table>
                    
                    
                    <div class="caption">
                        <b>ADDITIONAL INFO</b>
                    </div>
                    <table>
                        <tr>
                            <th>Genre</th>
                            <th>Songs of This Genre in The Library</th>
                        </tr>
                        <xsl:for-each select="music_list/genres/genre">
                            <xsl:sort select="@songs_of_genre" data-type="number" order="descending"/>
                            <tr>
                                <td ><xsl:value-of select="."/></td>
                                <td ><xsl:value-of select="@songs_of_genre"/></td>
                            </tr>
                        </xsl:for-each>
                    </table>
                    
                    <table>
                        <tr>
                            <th>Number of Songs in The Library</th>
                            <th>Whole Length (seconds)</th>
                            <th>Whole Length (munutes)</th>
                        </tr>
                        
                        <tr>
                            <td ><xsl:value-of select="music_list/songStats/songs_in_library"/></td>
                            <td ><xsl:value-of select="music_list/songStats/@whole_time_in_seconds"/></td>
                            <td ><xsl:value-of select="music_list/songStats/@whole_time_in_minutes"/></td>
                        </tr>
                    </table>
                    
                    <table>
                        <tr>
                            <th>Number of authors in the Library</th>
                            <th>Average Rating</th>
                        </tr>
                        
                        <tr>
                            <td ><xsl:value-of select="music_list/authorStats/authors_in_library"/></td>
                            <td ><xsl:value-of select="music_list/authorStats/@avergae_rating"/></td>
                        </tr>
                    </table>
                    
                    
                </div>
                
            </body>
        </html>
    </xsl:template>
    
    
    
    
</xsl:stylesheet>