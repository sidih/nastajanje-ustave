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
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>[html] Hook where extra Javascript functions can be defined</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="javascriptHook">
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/jquery.js')}"></script>
      <!-- za highcharts -->
      <xsl:if test="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']]">
         <xsl:variable name="jsfile" select="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']][1]/tei:graphic[@mimeType = 'application/javascript']/@url"/>
         <xsl:variable name="chart-jsfile" select="document($jsfile)/html/body/script[1]/@src"/>
         <script src="{$chart-jsfile[1]}"></script>
      </xsl:if>
      <!-- za back-to-top in highcharts je drugače potrebno dati jquery, vendar sedaj ne rabim dodajati jquery kodo,
         ker je že vsebovana zgoraj -->
      <!-- dodan css jstree (mora biti za jquery.js -->
      <link href="{concat($path-general,'themes/plugin/jstree/3.3.5/dist/themes/default/style.min.css')}" rel="stylesheet" type="text/css" />
      <!-- dodan jstree -->
      <script src="{concat($path-general,'themes/plugin/jstree/3.3.5/dist/jstree.min.js')}"></script>
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
      <desc>Novo ime za front front/div</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="nav-front-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Prispevki</xsl:text>
   </xsl:template>
   
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za glavno vsebino (glavna navigacija)</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="nav-body-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Gradivo</xsl:text>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za priloge</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="nav-appendix-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Razstava</xsl:text>
   </xsl:template>
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>K naslovni strani dam dodatno vsebino, ki ni procesirana iz TEI</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template match="tei:titlePage">
      <!-- naslov -->
      <xsl:for-each select="tei:docTitle/tei:titlePart[1]">
         <h1 class="text-center"><xsl:value-of select="."/></h1>
         <xsl:for-each select="following-sibling::tei:titlePart">
            <h1 class="subheader podnaslov"><xsl:value-of select="."/></h1>
         </xsl:for-each>
      </xsl:for-each>
      <br/>
      <figure>
         <img src="{tei:figure/tei:graphic/@url}" alt="naslovna slika"/>
         <figcaption style="font-size: 70%;">Razglasitev Ustave Republike Slovenije, 23. 12. 1991. (Tone Stojko, Muzej novejše zgodovine Slovenije)</figcaption>
      </figure>
      <br/>
      
      <div class="row border-content">
         <div class="medium-6 columns border-content-inner">
            <h4>Od Podvina do ustave:</h4>
            <ul class="accordion" data-accordion="" data-allow-all-closed="true">
               <li class="accordion-item" data-accordion-item="">
                  <a href="#" class="accordion-title">Predlog, da se začne postopek za sprejem Ustave RS, 25. 6. 1990</a>
                  <div class="accordion-content" data-tab-content="">
                     <embed src="https://www.sistory.si/cdn/publikacije/36001-37000/36836/Porocevalec_1990-07-02_11.pdf#toolbar=0" type="application/pdf" height="600" width="100%"></embed>
                  </div>
               </li>
               <li class="accordion-item" data-accordion-item="">
                  <a href="#" class="accordion-title">Delovni osnutek Ustave RS ("Podvinska ustava"), 31. 8. 1990</a>
                  <div class="accordion-content" data-tab-content="">
                     <embed src="10.12.2021.0452_001.pdf" type="application/pdf" height="600" width="100%"></embed>
                  </div>
               </li>
               <li class="accordion-item" data-accordion-item="">
                  <a href="#" class="accordion-title">Osnutek Ustave RS, 12. 10. 1990</a>
                  <div class="accordion-content" data-tab-content="">
                     <embed src="https://www.sistory.si/cdn/publikacije/36001-37000/36842/Porocevalec_1990-10-19_17.pdf#toolbar=0" type="application/pdf" height="600" width="100%"></embed>
                  </div>
               </li>
               <li class="accordion-item" data-accordion-item="">
                  <a href="#" class="accordion-title">Predlog Ustave RS, 12. 12. 1991</a>
                  <div class="accordion-content" data-tab-content="">
                     <embed src="https://www.sistory.si/cdn/publikacije/36001-37000/36883/Porocevalec_1991-12-12_30.pdf#toolbar=0" type="application/pdf" height="600" width="100%"></embed>
                  </div>
               </li>
               <li class="accordion-item" data-accordion-item="">
                  <a href="#" class="accordion-title">Predlog Ustave RS - dodatek, 19. 12. 1991</a>
                  <div class="accordion-content" data-tab-content="">
                     <embed src="https://www.sistory.si/cdn/publikacije/36001-37000/36885/Porocevalec_1992-01-17_01.pdf#toolbar=0" type="application/pdf" height="600" width="100%"></embed>
                  </div>
               </li>
               <li class="accordion-item" data-accordion-item="">
                  <a href="#" class="accordion-title">Ustava RS, 23. 12. 1991</a>
                  <div class="accordion-content" data-tab-content="">
                     <p>Ustava RS je bila po sprejetju objavljena v Ur. l. 33/91, 28.12. 1991</p>
                     <embed src="https://www.uradni-list.si/glasilo-uradni-list-rs/vsebina/1991-01-1409/ustava-republike-slovenije?h=ustava" type="application/pdf" height="600" width="100%"></embed>
                  </div>
               </li>
            </ul>
         </div>
         <div class="medium-6 columns border-content-inner">
            <h4>Prispevki:</h4>
            <ul class="toc toc_front">
               <xsl:for-each select="//tei:front/tei:div">
                  <xsl:call-template name="TOC-title-author-li"/>
               </xsl:for-each>
            </ul>
            <div class="callout secondary" data-closable="" style="font-size: 70%;">
               <p>Literatura, na kateri temeljijo ti prispevki, je strnjeno navedena v
                  posebnem pregledu literature – glej: <a href="#">LINK</a>
                  Za razumevanje širšega zgodovinskega, političnega,
                     pravnega in širšega družbenega konteksta nastajanja slovenske ustave, državnega
                     osamosvajanja in demokratizacije Slovenije ter pomena, vsebine in funkcije
                     slovenske ustave naj bralka in bralec posežeta po njej. <a href="#">LINK</a></p>
               <button class="close-button" aria-label="Dismiss alert" type="button" data-close="" style="background-color: inherit;">
                  <span aria-hidden="true">&#xD7;</span>
               </button>
            </div>
         </div>
      </div>
      
      <div class="row border-content">
         <div class="small-12 columns border-content-inner">
            <h4>Gradivo:</h4>
            <div class="row" id="treeview-container">
               <ul>
                  <xsl:for-each select="//tei:body/tei:div[@type][@xml:id]">
                     <xsl:call-template name="TOC-title-type-li"/>
                  </xsl:for-each>
               </ul>
               <script type="text/javascript">
                  $('#treeview-container').jstree().bind("select_node.jstree", function (e, data) {
                  var href = data.node.a_attr.href;
                  document.location.href = href;
                  });
               </script>
               <br/>
               <br/>
               <br/>
            </div>
         </div>
      </div>
      <br/>
      <br/>
      <br/>
      <br/>
      <br/>
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
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:figure[@type='razstava-PDF']">
      <embed src="{tei:graphic/@url}" type="application/pdf" height="1400" width="100%"></embed>
   </xsl:template>
   
   
</xsl:stylesheet>
