<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:exsl="http://exslt.org/common"
    xmlns="http://www.w3.org/2000/svg"
    version="2.0" 
    >

    <xsl:param name="canvas_width" select="1280"/>
    <xsl:param name="canvas_height" select="60*steam/statistics/games_amount+120"/>

    <xsl:param name="list_offset_x" select="40"/>
    <xsl:param name="list_offset_y" select="60"/>
    
    <xsl:param name="graph_offset_x" select="400"/>

    <xsl:param name="overhwelmingly_positive_color" select="'#0b744a'"/>
    <xsl:param name="very_positive_color" select="'#25b038'"/>
    <xsl:param name="positive_color" select="'#41f025'"/>
    <xsl:param name="mostly_positive_color" select="'#a0e526'"/>
    <xsl:param name="mixed_color" select="'#ffda27'"/>
    <xsl:param name="mostly_negative_color" select="'#ff8627'"/>
    <xsl:param name="negative_color" select="'#ff3727'"/>

    <xsl:template match="/" mode="#default">
        <svg width="{$canvas_width}" height="{$canvas_height}">
            <style>
                .heading {
                    font: bold 26px sans-serif;
                    fill: white;
                }

                .entry {
                    font: bold 16px sans-serif;
                    fill: white;
                }

                .price {
                    font: 14px sans-serif;
                    fill: white;
                }

            </style>
            <defs>
                <linearGradient id="backgroud" gradientTransform="rotate(-45)">
                    <stop offset="0%" stop-color="#132936" />
                    <stop offset="60%" stop-color="#2A475E" />
                </linearGradient>
            </defs>
            <rect x="0" y="0" width="{$canvas_width}" height="{$canvas_height}" fill="url('#backgroud')"/>
            <text x="20" y="50" class="heading">
                The Steam Library
            </text>
            <xsl:for-each select="steam/games/game">
                <xsl:sort select="release_date" order="descending"/>
                <text 
                    x="{$list_offset_x}" 
                    y="{$list_offset_y + 60 * position()}">
                    <tspan class="entry"><xsl:value-of select="@title"/></tspan>
                </text>
                <xsl:variable name="calculate_width" select="price_in_euro * 10 + 10"/>
                <rect 
                    x="{$graph_offset_x}" 
                    y="{$list_offset_y + 60 * position() - 15}" 
                    height="20"
                    width="{$calculate_width}"
                    fill="{
                        if(steam_reviews = 'Overhwelmingly Positive')
                        then($overhwelmingly_positive_color)
                        else if(steam_reviews = 'Very Positive')
                        then($very_positive_color)
                        else if(steam_reviews = 'Positive')
                        then($positive_color)
                        else if(steam_reviews = 'Mostly Positive')
                        then($mostly_positive_color)
                        else if(steam_reviews = 'Mixed')
                        then($mixed_color)
                        else if(steam_reviews = 'Mostly Negative')
                        then($mostly_negative_color)
                        else if(steam_reviews = 'Negative')
                        then($negative_color)
                        else ('black')}"
                    stroke="white"
                    stroke-width="2"
                    >
                    <animate
                        attributeName="width"
                        from="5"
                        to="{$calculate_width}"
                        dur="{$calculate_width div 30}s"/>
                    <animate
                        attributeName="height"
                        from="2"
                        to="2"
                        dur="{$calculate_width div 30}s"/>
                    <animate
                        attributeName="y"
                        from="{$list_offset_y + 60 * position() - 15 + 9}"
                        to="{$list_offset_y + 60 * position() - 15 + 9}"
                        dur="{$calculate_width div 30}s"/>
                    <animate
                        attributeName="height"
                        from="2"
                        to="20"
                        dur="2s"
                        begin="{$calculate_width div 30}s"/>
                    <animate
                        attributeName="y"
                        from="{$list_offset_y + 60 * position() - 15 + 9}"
                        to="{$list_offset_y + 60 * position() - 15}"
                        dur="2s"
                        begin="{$calculate_width div 30}s"/>
                </rect>
                <text 
                    x="{$graph_offset_x + $calculate_width + 10}" 
                    y="{$list_offset_y + 60*position()}" 
                    class="price" 
                    fill-opacity="1">
                    <animate 
                        attributeName="fill-opacity"
                        from="0"
                        to="0"
                        dur="{$calculate_width div 30}s"/>
                    <animate 
                        attributeName="fill-opacity"
                        from="0"
                        to="1"
                        dur="0.5s"
                        begin="{$calculate_width div 30}s"/>
                    <animate 
                        attributeName="x"
                        from="{$graph_offset_x + $calculate_width + 10 + 10}" 
                        to="{$graph_offset_x + $calculate_width + 10}" 
                        dur="0.5s"
                        begin="{$calculate_width div 30}s"/>
                        
                    <xsl:value-of select="price_in_euro"/> €
                </text>
            </xsl:for-each>
        </svg>
    </xsl:template>
</xsl:stylesheet>