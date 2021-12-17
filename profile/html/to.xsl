<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="tei html teidocx xs"
   version="2.0">

   <xsl:import href="../sistory/html5-foundation6/to.xsl"/>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p>TEI stylesheet for making HTML5 output (Zurb Foundation 6 http://foundation.zurb.com/sites/docs/).</p>
         <p>This software is dual-licensed:
            
            1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
            Unported License http://creativecommons.org/licenses/by-sa/3.0/ 
            
            2. http://www.opensource.org/licenses/BSD-2-Clause
            
            
            
            Redistribution and use in source and binary forms, with or without
            modification, are permitted provided that the following conditions are
            met:
            
            * Redistributions of source code must retain the above copyright
            notice, this list of conditions and the following disclaimer.
            
            * Redistributions in binary form must reproduce the above copyright
            notice, this list of conditions and the following disclaimer in the
            documentation and/or other materials provided with the distribution.
            
            This software is provided by the copyright holders and contributors
            "as is" and any express or implied warranties, including, but not
            limited to, the implied warranties of merchantability and fitness for
            a particular purpose are disclaimed. In no event shall the copyright
            holder or contributors be liable for any direct, indirect, incidental,
            special, exemplary, or consequential damages (including, but not
            limited to, procurement of substitute goods or services; loss of use,
            data, or profits; or business interruption) however caused and on any
            theory of liability, whether in contract, strict liability, or tort
            (including negligence or otherwise) arising in any way out of the use
            of this software, even if advised of the possibility of such damage.
         </p>
         <p>Andrej Pančur, Institute for Contemporary History</p>
         <p>Copyright: 2013, TEI Consortium</p>
      </desc>
   </doc>
  
   <!-- Uredi parametre v skladu z dodatnimi zahtevami za pretvorbo te publikacije: -->
   <!-- https://www2.sistory.si/publikacije/ -->
   <!-- ../../../  -->
   <xsl:param name="path-general">https://www2.sistory.si/publikacije/</xsl:param>
   
   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/to.xsl -->
   <xsl:param name="outputDir">docs/</xsl:param>
   
   <xsl:param name="homeLabel">Ustava RS</xsl:param>
   <xsl:param name="homeURL">https://nastajanje-ustave.si</xsl:param>
   
   <xsl:param name="splitLevel">1</xsl:param>
   
   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/my-html_param.xsl -->
   <xsl:param name="title-bar-sticky">false</xsl:param>
   
   <!-- odstranim pri spodnjih param true -->
   <xsl:param name="numberFigures"></xsl:param>
   <xsl:param name="numberFrontTables"></xsl:param>
   <xsl:param name="numberHeadings"></xsl:param>
   <xsl:param name="numberParagraphs"></xsl:param>
   <xsl:param name="numberTables"></xsl:param>
   
   <!-- V html/head izpisani metapodatki -->
   <xsl:param name="description"></xsl:param>
   <xsl:param name="keywords"></xsl:param>
   <xsl:param name="title"></xsl:param>
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc/>
   </xsldoc:doc>
   <xsl:template name="cssHook">
      <xsl:if test="$title-bar-sticky = 'true'">
         <xsl:value-of select="concat($path-general,'themes/css/foundation/6/sistory-sticky_title_bar.css')"/>
      </xsl:if>
      <link href="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.min.css" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'themes/plugin/TipueSearch/6.1/tipuesearch/css/normalize.css')}" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'themes/css/plugin/TipueSearch/6.1/my-tipuesearch.css')}" rel="stylesheet" type="text/css" />
      <!-- dodam projektno specifičen css, ki se nahaja v istem direktoriju kot ostali HTML dokumenti -->
      <link href="project.css" rel="stylesheet" type="text/css"/>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:listBibl[@type='documents']">
      <ul class="accordion" data-accordion="" data-allow-all-closed="true">
         <xsl:for-each select="tei:biblFull">
            <li class="accordion-item" data-accordion-item="">
               <a href="#" class="accordion-title">
                  <xsl:value-of select="tei:titleStmt/tei:title"/>
               </a>
               <div class="accordion-content" data-tab-content="">
                  <xsl:for-each select="tei:titleStmt/tei:title">
                     <div style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;" id="{@xml:id}">
                        <div style="width: 200px;">Naslov:</div>
                        <div style="flex: 1;">
                           <xsl:value-of select="normalize-space(.)"/>
                        </div>
                     </div>
                  </xsl:for-each>
                  <xsl:for-each select="tei:titleStmt/tei:author">
                     <div style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;" id="{@xml:id}">
                        <div style="width: 200px;">Avtor:</div>
                        <div style="flex: 1;">
                           <xsl:value-of select="normalize-space(.)"/>
                        </div>
                     </div>
                  </xsl:for-each>
                  <xsl:for-each select="tei:publicationStmt/tei:date">
                     <div style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;" id="{@xml:id}">
                        <div style="width: 200px;">Datum:</div>
                        <div style="flex: 1;">
                           <xsl:value-of select="@when"/>
                        </div>
                     </div>
                  </xsl:for-each>
                  <xsl:for-each select="tei:publicationStmt/tei:idno">
                     <div style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;" id="{@xml:id}">
                        <div style="width: 200px;">Identifikator:</div>
                        <div style="flex: 1;">
                           <xsl:value-of select="."/>
                        </div>
                     </div>
                  </xsl:for-each>
                  <hr/>
                  <embed src="{tei:publicationStmt/tei:ref/@target}" type="application/pdf" height="600" width="100%"></embed>
               </div>
            </li>
         </xsl:for-each>
      </ul>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za glavno vsebino (glavna navigacija)</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="nav-body-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Dokumenti</xsl:text>
   </xsl:template>
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>K naslovni strani dam dodatno vsebino, ki ni procesirana iz TEI</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template match="tei:titlePage">
      <!-- avtor -->
      <!--<p  class="naslovnicaAvtor">
         <xsl:for-each select="tei:docAuthor">
            <xsl:choose>
               <xsl:when test="tei:forename or tei:surname">
                  <xsl:for-each select="tei:forename">
                     <xsl:value-of select="."/>
                     <xsl:if test="position() ne last()">
                        <xsl:text> </xsl:text>
                     </xsl:if>
                  </xsl:for-each>
                  <xsl:if test="tei:surname">
                     <xsl:text> </xsl:text>
                  </xsl:if>
                  <xsl:for-each select="tei:surname">
                     <xsl:value-of select="."/>
                     <xsl:if test="position() ne last()">
                        <xsl:text> </xsl:text>
                     </xsl:if>
                  </xsl:for-each>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="position() ne last()">
               <br/>
            </xsl:if>
         </xsl:for-each>
      </p>-->
      <!-- naslov -->
      <xsl:for-each select="tei:docTitle/tei:titlePart[1]">
         <h1 class="text-center"><xsl:value-of select="."/></h1>
         <xsl:for-each select="following-sibling::tei:titlePart">
            <h1 class="subheader podnaslov"><xsl:value-of select="."/></h1>
         </xsl:for-each>
      </xsl:for-each>
      <br/>
      <xsl:if test="tei:figure">
         <div class="text-center">
            <p>
               <img src="{tei:figure/tei:graphic/@url}" alt="naslovna slika"/>
            </p>
         </div>
      </xsl:if>
      <xsl:if test="tei:graphic">
         <div class="text-center">
            <p>
               <img src="{tei:graphic/@url}" alt="naslovna slika"/>
            </p>
         </div>
      </xsl:if>
      <br/>
      <!--<p class="text-center">
         <!-\- založnik -\->
         <xsl:for-each select="tei:docImprint/tei:publisher">
            <xsl:value-of select="."/>
            <br/>
         </xsl:for-each>
         <!-\- kraj izdaje -\->
         <xsl:for-each select="tei:docImprint/tei:pubPlace">
            <xsl:value-of select="."/>
            <br/>
         </xsl:for-each>
         <!-\- leto izdaje -\->
         <xsl:for-each select="tei:docImprint/tei:docDate">
            <xsl:value-of select="."/>
            <br/>
         </xsl:for-each>
      </p>-->
      
      <div class="row border-content">
         <div class="small-12 columns border-content-inner">
            <p>Pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo, pojasnilo.</p>
         </div>
      </div>
      
      <div class="row border-content">
         <div class="medium-6 columns border-content-inner">
            <ul class="accordion" data-accordion="" data-allow-all-closed="true">
               <li class="accordion-item" data-accordion-item="">
                  <a href="#" class="accordion-title">Predlog, da se začne postopek za sprejem Ustave RS</a>
                  <div class="accordion-content" data-tab-content="">
                     <p>25. 6. 1990 Predlog, da se začne postopek za sprejem Ustave RS</p>
                     <embed src="https://www.sistory.si/cdn/publikacije/36001-37000/36836/Porocevalec_1990-07-02_11.pdf#toolbar=0" type="application/pdf" height="600" width="100%"></embed>
                  </div>
               </li>
               <li class="accordion-item" data-accordion-item="">
                  <a href="#" class="accordion-title">Delovni osnutek Ustave RS ("Podvinska ustava")</a>
                  <div class="accordion-content" data-tab-content="">
                     <p>31. 8. 1990 Delovni osnutek Ustave RS ("Podvinska ustava")
                        - ta v Poročevalcu ni bila objavljena, zato posredujemo sken iz arhiva Državnega zbora:</p>
                     <embed src="10.12.2021.0452_001.pdf" type="application/pdf" height="600" width="100%"></embed>
                  </div>
               </li>
               <li class="accordion-item" data-accordion-item="">
                  <a href="#" class="accordion-title">Osnutek Ustave RS</a>
                  <div class="accordion-content" data-tab-content="">
                     <p>12. 10. 1990 Osnutek Ustave RS</p>
                     <embed src="https://www.sistory.si/cdn/publikacije/36001-37000/36842/Porocevalec_1990-10-19_17.pdf#toolbar=0" type="application/pdf" height="600" width="100%"></embed>
                  </div>
               </li>
               <li class="accordion-item" data-accordion-item="">
                  <a href="#" class="accordion-title">Predlog Ustave RS</a>
                  <div class="accordion-content" data-tab-content="">
                     <p>12. 12. 1991 Predlog Ustave RS</p>
                     <embed src="https://www.sistory.si/cdn/publikacije/36001-37000/36883/Porocevalec_1991-12-12_30.pdf#toolbar=0" type="application/pdf" height="600" width="100%"></embed>
                  </div>
               </li>
               <li class="accordion-item" data-accordion-item="">
                  <a href="#" class="accordion-title">Predlog Ustave RS - dodatek</a>
                  <div class="accordion-content" data-tab-content="">
                     <p>19. 12. 1991 Predlog Ustave RS - dodatek</p>
                     <embed src="https://www.sistory.si/cdn/publikacije/36001-37000/36885/Porocevalec_1992-01-17_01.pdf#toolbar=0" type="application/pdf" height="600" width="100%"></embed>
                  </div>
               </li>
               <li class="accordion-item" data-accordion-item="">
                  <a href="#" class="accordion-title">Ustava RS je bila po sprejetju objavljena v Ur. l. 33/91 28.12. 1991</a>
                  <div class="accordion-content" data-tab-content="">
                     <p>23. 12. 1991 Ustava RS je bila po sprejetju objavljena v Ur. l. 33/91 28.12. 1991</p>
                     <embed src="https://www.uradni-list.si/glasilo-uradni-list-rs/vsebina/1991-01-1409/ustava-republike-slovenije?h=ustava" type="application/pdf" height="600" width="100%"></embed>
                  </div>
               </li>
            </ul>
         </div>
         <div class="medium-6 columns border-content-inner">
            <p>Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. Zgodovina. </p>
         </div>
      </div>
      
      <div class="row border-content">
         <div class="small-12 columns border-content-inner">
            <p>Gradivlo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo, gradivo.</p>
         </div>
      </div>
      
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:note[@type='accesability']">
      <div class="callout alert">
         <p>
            <xsl:value-of select="."/>
         </p>
      </div>
   </xsl:template>
   
   
</xsl:stylesheet>
