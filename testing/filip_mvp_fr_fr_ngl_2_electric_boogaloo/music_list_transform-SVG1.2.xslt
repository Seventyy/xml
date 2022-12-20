<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:exsl="http://exslt.org/common"
    xmlns="http://www.w3.org/2000/svg"
    version="2.0" 
    >
    
    <!-- file parameters -->
    <xsl:param name="whole_width" select="if($authors_in_lib>9) then(1600 + 100 * ($authors_in_lib - 5)) else(1600)"/>
    <xsl:param name="whole_height" select="60*music_list/songStats/songs_in_library+120"/>


    <!-- diagrams parameters -->
    <xsl:param name="c_radius" select="160"/>
    <xsl:param name="c_inner_radius" select="90"/>
    <xsl:param name="c_inner_circuit" select="$c_inner_radius*2*3.14"/>
    <xsl:param name="c1_x" select="850"/>
    <xsl:param name="c1_y" select="200"/>
    <xsl:param name="c2_x" select="600"/>
    <xsl:param name="c2_y" select="800"/>
    <xsl:param name="main_list_x" select="40"/>
    <xsl:param name="main_list_y" select="60"/>
    <xsl:param name="ES-color" select="'deepskyblue'"/>
    <xsl:param name="P-color" select="'palegreen'"/>
    <xsl:param name="R-color" select="'tomato'"/>

    <!-- statistics parameters -->
    <xsl:param name="lib_viewes_total" select="sum(music_list/songList/song/@views)"/>
    <xsl:param name="ES_viewes_perc" select="floor((sum(music_list/songList/song/@views [../genre = 'Electro_Swing']) div $lib_viewes_total)*10000) div 10000"/>
    <xsl:param name="P_viewes_perc" select="floor((sum(music_list/songList/song/@views [../genre = 'Pop']) div $lib_viewes_total)*10000) div 10000"/>
    <xsl:param name="R_viewes_perc" select="floor((sum(music_list/songList/song/@views [../genre = 'Rock']) div $lib_viewes_total)*10000) div 10000"/>
    <xsl:param name="authors_in_lib" select="count(music_list/authorList/author)"/>


    <xsl:template match="/" mode="#default">
        <svg width="{$whole_width}" height="{$whole_height}">

            <style>
                .title{
                    font: bold 26px sans-serif;
                }

                .highlight {
                    font: bold 16px sans-serif;
                }

                .normal {
                    font: 14px sans-serif
                }
            </style>

            <text x="20" y="50" class="title">
                Songs Popularity Diagrams Based on Viewes!
            </text>
            <text x="{$whole_width - 450}" y="{$whole_height - 40}" class="title">
                Filip Andrzejewski, id: 242207
            </text>
            <xsl:for-each select="music_list/songList/song">
                <xsl:sort select="@views" data-type="number" order="descending"/>
                <text x="{$main_list_x}" y="{$main_list_y + 60*position()}">
                    <tspan class="highlight"><xsl:value-of select="@name"/></tspan>
                    <tspan>- <xsl:value-of select="author"/></tspan>
                </text>
                <xsl:variable name="calculate_width" select="math:sqrt(@views) div 100"/>
                <rect x="{$main_list_x + 280}" y="{$main_list_y + 60*position() - 15}" 
                    height="20"
                    width="{$calculate_width}"
                    fill="{
                        if(genre = 'Electro_Swing')
                        then($ES-color)
                        else if(genre = 'Pop')
                        then($P-color)
                        else if(genre = 'Rock')
                        then($R-color)
                        else('black')}">
                    
                    <animate
                        attributeName="width"
                        from="0"
                        to="{$calculate_width}"
                        dur="{
                            if(position()>50)
                            then(0)
                            else(5 - 0.1*position())}s"/>
                </rect>
                <text x="{$main_list_x + 280 + $calculate_width + 10}" y="{$main_list_y + 60*position()}" class="normal" fill-opacity="1">

                    <animate 
                        attributeName="fill-opacity"
                        from="0"
                        to="0"
                        dur="{
                            if(position()>40)
                            then(0)
                            else(4 - 0.1*position())}s"/>
                    <animate 
                        attributeName="fill-opacity"
                        from="0"
                        to="1"
                        dur="0.8s"
                        begin="{
                            if(position()>40)
                            then(0)
                            else(4 - 0.1*position())}s"/>
                        
                    <xsl:value-of select="@views div 1000000"/> mln
                </text>
            </xsl:for-each>
                
            <circle r="{$c_radius}" cx="{$c1_x}" cy="{$c1_y}" fill="lightgrey"/>

            <!-- Electro Swing Slice --> 
            <circle r="{$c_inner_radius}" cx="{$c1_x}" cy="{$c1_y}" fill-opacity="0"
                    stroke="{$ES-color}"
                    stroke-width="{$c_radius}"
                    stroke-dasharray="{$ES_viewes_perc * $c_inner_circuit} {$c_inner_circuit}"
                    transform="rotate({-90} {$c1_x} {$c1_y})"> 
                <animate
                    attributeName="stroke-dasharray"
                    from="0 {$c_inner_circuit}"
                    to="{$ES_viewes_perc * $c_inner_circuit} {$c_inner_circuit}"
                    dur="5s"/>
            </circle>

            <!-- Pop Slice --> 
            <circle r="{$c_inner_radius}" cx="{$c1_x}" cy="{$c1_y}" fill-opacity="0"
                    stroke="{$P-color}"
                    stroke-width="{$c_radius}"
                    stroke-dasharray="{$P_viewes_perc * $c_inner_circuit} {$c_inner_circuit}"
                    transform="rotate({$ES_viewes_perc*360 - 90} {$c1_x} {$c1_y})">
                <animate
                    attributeName="stroke-dasharray"
                    from="0 {$c_inner_circuit}"
                    to="{$P_viewes_perc * $c_inner_circuit} {$c_inner_circuit}"
                    dur="5s"/> 
             </circle>

            <!-- Rock Slice -->
            <circle r="{$c_inner_radius}" cx="{$c1_x}" cy="{$c1_y}" fill-opacity="0"
                    stroke="tomato"
                    stroke-width="{$c_radius}"
                    stroke-dasharray="{$R_viewes_perc * $c_inner_circuit} {$c_inner_circuit}"
                    transform="rotate({($ES_viewes_perc+$P_viewes_perc)*360 - 90} {$c1_x} {$c1_y})">
                <animate
                    attributeName="stroke-dasharray"
                    from="0 {$c_inner_circuit}"
                    to="{$R_viewes_perc * $c_inner_circuit} {$c_inner_circuit}"
                    dur="5s"/> 
             </circle>

            <circle r="{$c_inner_radius}" cx="{$c1_x}" cy="{$c1_y}"
                    fill="white"/>

            <rect x="{$c1_x + 230}" y="{$c1_y - 100}" height="40" width="40" fill="{$ES-color}"/>
            <rect x="{$c1_x + 230}" y="{$c1_y - 30}" height="40" width="40" fill="{$P-color}"/>
            <rect x="{$c1_x + 230}" y="{$c1_y + 40}" height="40" width="40" fill="{$R-color}"/>

            <text x="{$c1_x + 280}" y="{$c1_y - 100 + 20}" class="highlight">Electro Swing - <xsl:value-of select="floor($ES_viewes_perc * 10000) div 100"/>% of the viewes in Lib</text>
            <text x="{$c1_x + 280}" y="{$c1_y - 30  + 20}" class="highlight">Pop - <xsl:value-of select="floor($P_viewes_perc * 10000) div 100"/>% of the viewes in Lib</text>
            <text x="{$c1_x + 280}" y="{$c1_y + 40  + 20}" class="highlight">Rock - <xsl:value-of select="floor($R_viewes_perc * 10000) div 100"/>% of the viewes in Lib</text>
            

            <rect x="{$c2_x + 50}" y="{$c2_y - 30}" height="10" width="{100*$authors_in_lib}" fill="lightgrey"/>
            <xsl:for-each select="music_list/authorList/author">
                <xsl:sort select="@name"/>
                <text x="{$c2_x + 100*position()}" y="{$c2_y}" class="highlight" transform="rotate(70 {$c2_x + 100*position()} {$c2_y})">
                    <xsl:value-of select="name"/>
                </text>

                <xsl:variable name="this_author_name" select="name"/>
                <xsl:variable name="this_author_views" select="(sum(../../songList/song/@views [../author = $this_author_name]))"/>
                <xsl:variable name="calculate_height" select="math:sqrt($this_author_views) div 100"/>

                <rect x="{$c2_x + 100*position()}" y="{$c2_y - 10}" 
                    height="{$calculate_height}"
                    width="{16}"
                    transform="rotate(180 {$c2_x + 100*position() + 10} {$c2_y - 20})"
                    fill="midnightblue">
                    <animate
                        attributeName="height"
                        from="0"
                        to="0"
                        dur="5s"/>
                    <animate
                        attributeName="height"
                        from="0"
                        to="{$calculate_height}"
                        begin="5s"
                        dur="2.5s"/>
                </rect>
                <text x="{$c2_x + 100*position() - 10}" y="{$c2_y - $calculate_height - 40}" class="normal" fill-opacity="1">

                    <animate 
                        attributeName="fill-opacity"
                        from="0"
                        to="0"
                        dur="6.5s"/>
                    <animate 
                        attributeName="fill-opacity"
                        from="0"
                        to="1"
                        dur="0.8s"
                        begin="6.5s"/>
                    <xsl:value-of select="$this_author_views div 1000000"/> mln
                </text>
                

            </xsl:for-each>

        </svg>
        
        
    </xsl:template>
    
    
</xsl:stylesheet>