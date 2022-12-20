<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="2.0">
    

    <xsl:template match="/">
        <html>
            <head>
                <title>Steam Library</title>
                <style type="text/css">
                    
                    * {
                        font-family: sans-serif;
                        font-size: 20px;
                        color: aliceblue;
                        text-align: left;
                        margin: 0;
                     }

                     table, th, td {
                        padding: 20;
                        margin: 10;
                    }

                    h1 {
                        font-size: 40px;
                        padding: 30;
                    }

                    #bg {
                        background-image: radial-gradient(ellipse at top right, #2A475E, #132936);
                    }

                </style>
            </head>
            <body>
                <div id="bg"></div>
                
                <h1>Steam Library</h1>
                
                <table>
                    <tr>
                        <th>Title</th>
                        <th>Developer</th>
                        <th>Reviews</th>
                        <th>Relese Date</th>
                        <th>Price</th>
                    </tr>
                    <xsl:for-each select="steam/games/game">
                        <xsl:sort select="release_date" order="descending"/>
                        <tr>
                            <td><xsl:value-of select="@title"/></td>
                            <td><xsl:value-of select="developer"/></td>
                            <td><xsl:value-of select="steam_reviews"/></td>
                            <td><xsl:value-of select="release_date"/></td>
                            <td><xsl:value-of select="price_in_euro"/></td>
                        </tr>
                    </xsl:for-each>
                </table>

            </body>
        </html>
    </xsl:template>
    
    
    
    
</xsl:stylesheet>