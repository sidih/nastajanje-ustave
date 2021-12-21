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
      
      <div class="row">
         <div class="small-12 columns">
            <div class="callout secondary" data-closable="">
               <p>Ustava Republike Slovenije, razglašena 23. decembra 1991, je eden najpomembnejših
                  dokumentov v zgodovini slovenskega naroda. Po eni strani pomeni utrditev slovenske
                  državne suverenosti, ki jo je 25. junija 1991 vzpostavila Temeljna ustavna listina o
                  samostojnosti in neodvisnosti Republike Slovenije. Po drugi strani daje slovenski
                  državi temeljno politično in pravno vsebino, saj zagotavlja demokratični politični
                  sistem, varstvo človekovih pravic in svoboščin, pravno in socialno državo, lokalno
                  samoupravo ter druge demokratične vrednote in institucije. Kot vrhovni pravni akt
                  ustava državljankam in državljanom jamči osebno svobodo in človeško dostojanstvo,
                  družbi kot celoti pa nudi vrednostno sidro, ki tudi v spreminjajočih se družbenih
                  razmerah zagotavlja kontinuiteto ter vsaj relativno in okvirno stabilnost slovenske
                  pravne ureditve.</p>
               <p>Spletna stran <a href="https://nastajanje-ustave.si">https://nastajanje-ustave.si</a> obeležuje 30. obletnico obstoja Ustave
                  Republike Slovenije. Na njej so objavljena prvič zbrana in sistematično urejena vsa
                  dostopna gradiva Skupščine Republike Slovenije in njene Komisije za ustavna
                  vprašanja, ki pričajo o času slovenskega osamosvajanja in izgradnje nove ustavne
                  ureditve v letih 1990 in 1991. Objavljena gradiva razkrivajo polemično ozračje ter
                  raznolikost idej in predlogov v ustavni razpravi, hkrati pa tudi privrženost
                  skupnemu cilju, to je suvereni in demokratični Republiki Sloveniji.</p>
               <button class="close-button" aria-label="Dismiss alert" type="button" data-close="" style="background-color: inherit;">
                  <span aria-hidden="true">&#xD7;</span>
               </button>
            </div>
         </div>
      </div>
      
      
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
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Povozim privzeto procesiranje kolofona iz teiHeader</desc>
   </doc>
   <xsl:template match="tei:TEI/tei:teiHeader/tei:fileDesc | tei:teiCorpus/tei:teiHeader/tei:fileDesc" mode="kolofon">
      <h3>Nastajanje Ustave Republike Slovenije 1990–1991 <br/>Digitalizirana kronološka zbirka gradiv <br/>https://nastajanje-ustave.si</h3>
      <p>Ob 30. obletnici razglasitve ustave Republike Slovenije (23. 12. 1991–23. 12. 2021)
         je spletno stran www.nastajanje-ustave.si z digitalizirano kronološko zbirko gradiv:
         Nastajanje Ustave Republike Slovenije 1990–1991 zasnoval in pripravil uredniški
         odbor: dr. Miro Cerar (Pravna fakulteta Univerze v Ljubljani), Gordana Černe
         (Državni zbor), dr. Jure Gašparič (Inštitut za novejšo zgodovino), Urška Mohar
         (Državni zbor), dr. Andrej Pančur (Inštitut za novejšo zgodovino), mag. Borut
         Peršolja (Državni zbor) in dr. Jure Spruk.</p>
      <p>Vodji projekta: dr. Miro Cerar, mag. Borut Peršolja</p>
      <p>Odgovorna oseba: mag. Borut Peršolja</p>
      <p>Avtorji besedil: dr. Miro Cerar (Kronologija, Ustavna diskontinuiteta, skupščinski
         sistem, mejniki v procesu nastajanja ustave in priznanje Slovenije, Nastajanje
         ustave Republike Slovenije, Pojem ustave in obči razvoj ustavnosti, Temeljna
         izhodišča, viri in cilji ustavne ureditve Republike Slovenije, Ustavna razprava,
         Ustava Republike Slovenije: preambula in splošne določbe, Ustava Republike
         Slovenije: človekove pravice in temeljne svoboščine, Ustava Republike Slovenije:
         gospodarska in socialna razmerja in Ustava Republike Slovenije: državna ureditev in
         lokalna samouprava) in dr. Jure Gašparič (Ustavna diskontinuiteta, skupščinski
         sistem, mejniki v procesu nastajanja ustave in priznanje Slovenije, Razvoj
         ustavnosti na Slovenskem 1848–1991). Pri nastajanju dveh besedil je sodelovala Tjaša
         Konovšek.</p>
      <p>Uporabljeno arhivsko gradivo Državnega zbora:</p>
      <p>Fond Skupščina Republike Slovenije, Zbirka kopij gradiva predanega Državnemu zboru s
         strani dr. Miroslava Cerarja za namen digitalizacije gradiva povezanega z
         nastajanjem Ustave Republike Slovenije, Projekt: Nastajanje Ustave Republike
         Slovenije 1990–1991:</p>
      <ul>
         <li>Fond Skupščina Republike Slovenije: Seje Komisije za ustavna vprašanja Skupščine
         Republike Slovenije, številka zadeve 0610-12/ 90-1 do 0610-12/90-51.</li>
         <li>Fond Skupščina Republike Slovenije: Seje Koordinacijske skupine Komisije Skupščine
         Republike Slovenije za ustavna vprašanja, številka zadeve 0610-120/90.</li>
         <li>Fond Skupščina Republike Slovenije: Seje Skupine za preambulo in splošne določbe
         Komisije za ustavna vprašanja, številka zadeve 0610-12/90-0.</li>
         <li>Fond Skupščina Republike Slovenije: Seje podskupine za simbole Komisije za ustavna
         vprašanja Skupščine Republike Slovenije, številka zadeve 0610-12/90-7.</li>
         <li>Fond Skupščina Republike Slovenije: Seje skupine za ekonomska in socialna razmerja
         Komisije za ustavna vprašanja, številka zadeve 0610-12/90-1.</li>
         <li>Fond Skupščina Republike Slovenije: Seje skupine za lokalno in drugo samoupravo
         komisije za ustavna vprašanja, številka zadeve 0610-12/90-2.</li>
         <li>Fond Skupščina Republike Slovenije: Seje Skupine za upravo, vojsko, sodstvo, javno
         tožilstvo, odvetništvo in notariat komisije za ustavna vprašanja, številka zadeve
         0610-12/90-4.</li>
         <li>Fond Skupščina Republike Slovenije: Seje skupine za državno ureditev Komisije za
         ustavna vprašanja, številka zadeve 0610-12/90-5.</li>
         <li>Fond Skupščina Republike Slovenije: Seje Skupine za pravice, svoboščine in
         dolžnosti človeka in državljana komisije za ustavna vprašanja, številka zadeve
         0610-12/90-3.</li>
         <li>Fond Skupščina Republike Slovenije: Seje skupine za ustavnost, zakonitost, ustavno
         sodišče in ustavno revizijski postopek Komisije za ustavna vprašanja, številka
         zadeve 0610-12/90-6.</li>
         <li>Fond Skupščina Republike Slovenije: Pobude, predlogi v javni razpravi k osnutku
         nove ustave RS, številka zadeve: 001-01/89-2, škatla 11 in 12.</li>
         <li>Fond Skupščina Republike Slovenije: Gradivo javnega natečaja za oblikovanje grba in
         idejnih aplikacij grba RS, številka zadeve: 001-01/89-2, škatla 13.</li>
         <li>Fond Skupščina Republike Slovenije: Gradivo povezano s Predlogom Predsedstva RS za
         začetek postopka za sprejem nove Ustave RS, številka zadeve: 001-02/89-2, 10. in 14.
         mapa.</li>
         <li>Fond Skupščina Republike Slovenije: Deklaracija ob neodvisnosti, Zbirka sprejeti
         zakoni in akti, škatla 42 , številka zadeve: 001-02/91-12/3.</li>
         <li>Fond Skupščina Republike Slovenije: Temeljna ustavna listina o samostojnosti in
         neodvisnosti RS, Zbirka sprejeti zakoni in akti, škatla 42 , številka zadeve:
         001-02/81-12/2.</li>
         <li>Fond Skupščina Republike Slovenije: Ustavni zakon za izvedbo temeljne ustavne
         listine o samostojnosti in neodvisnosti RS, Zbirka sprejeti zakoni in akti, škatla
         42 001-02/91-12.</li>
         <li>Fond Skupščina Republike Slovenije: Nova Ustava RS in ustavni zakon za izvedbo
         ustave RS, Zbirka sprejeti zakoni in akti, škatla 43 , številka zadeve:
         001-02/89-2/75 in 001-02/91-12/1.</li>
         <li>Sklep o sprejemu predloga Izvršnega sveta Skupščine, da se začne postopek za
         spremembo ustave RS, Zbirka sprejeti zakoni in akti, škatla 39 , številka zadeve:
         001-02/90-2.</li>
         <li>Fond Skupščina Republike Slovenije: Sklep o javni razpravi o osnutku nove slovenske
         ustave, Zbirka sprejeti zakoni in akti, škatla 39 , številka zadeve:
         001-02/90-2.</li>
         <li>Fond Skupščina Republike Slovenije: Deklaracija o suverenosti RS, Skupščina RS,
         Zbirka sprejeti zakoni in akti, škatla 39 , številka zadeve: 000-01/90-3.</li>
         <li>Fond Skupščina Republike Slovenije: : Skupna Brionska Deklaracija, Zbirka sprejeti
         zakoni in akti, škatla 43 , številka zadeve: 000-01/90-5/43.</li>
      </ul>
      <p>Spletna zasnova in tehnična izvedba: dr. Andrej Pančur</p>
      <p>Avtorstvo in vir slikovnega gradiva: Tone Stojko/Muzej novejše zgodovine
         Slovenije</p>
      <p>Zbirko gradiv sta v letih 2007–2008 zbrala in uredila dr. Miro Cerar in Mojca
         Stropnik. Pri zbiranju gradiv so sodelovali Nataša Mlinarič, Gordana Vrabec in Boris
         Vrišer (vsi Državni zbor).</p>
      <p>Pregled in dodatno urejanje zbirke gradiv so v letu 2021 opravili dr. Miro Cerar,
         Gordana Černe (Državni zbor), Tjaša Konovšek, Karin Konda, Marko Kupljen (vsi
         Inštitut za novejšo zgodovino), Urška Mohar (Državni zbor), dr. Andrej Pančur
         (Inštitut za novejšo zgodovino) in dr. Jure Spruk.</p>
      
      <hr/>
      
      <p><b>Državnost, utemeljena na lastni ustavi <br/>Razstava in spletna razstava</b></p>
      <p>Besedilo: mag. Borut Peršolja (Raziskovalno-dokumentacijski sektor)</p>
      <p>Pregled besedila: dr. Miro Cerar (Pravna fakulteta Univerze v Ljubljani), dr. Jure
         Gašparič (Inštitut za novejšo zgodovino)</p>
      <p>Pregled in izbor dokumentov Arhiva Državnega zbora: Urška Mohar (Oddelek za delo z
         gradivi in pošto)</p>
      <p>Uporabljeno arhivsko gradivo: Arhiv Državnega zbora RS, fond Skupščina Slovenije,
         Zbirka Sprejeti Zakoni in akti, škatla 10, številka zadeve: 011-29/74, škatla 39,
         številka zadeve: 001-02/90-2, škatla 42, številka zadeve: 001-02/91-12/2; Zbirka
         Čestitke, zahvale, podpore in protestna pisma ob sprejemu amandmajev k Ustavi SRS,
         škatla. 8, številka zadeve: 001-02/89-2; Zbirka Osnutki ustave, škatla 10, številka
         zadeve: 001-02/89-2; Zbirka Javna razprava o osnutku Ustave RS, škatla 12 in 13,
         številka zadeve: 001-01/89-2.</p>
      <p>Pregled in izbor dokumentacije časnika Delo: Jurij Šinkovec
         (Dokumentacijsko-knjižnični oddelek)</p>
      <p>Avtorstvo in viri slikovnega gradiva: Arhiv Državnega zbora, Matej Grah/Državni zbor,
         Igor Modic/Delo, Borut Peršolja/Državni zbor, Tone Stojko/Muzej novejše zgodovine
         Slovenije in Matija Sušnik/Državni zbor</p>
      <p>Lektoriranje: Tanja Obreza, Tanja Sernec (Dokumentacijsko-knjižnični oddelek)</p>
      <p>Oblikovanje: Barbara Žejavac (Oddelek tiskarna)</p>
      <p>Izdal: Državni zbor</p>
      <p>23. december 2021</p>
      
      <hr/>
      
      <p>Posebna zahvala: mag. Lovro Lončar, Mojca Prelesnik, Uršula Zore Tavčar in Karmen
         Uglešić (Državni zbor), Nataša Strlič (Muzej novejše zgodovine Slovenije) in Janja
         Papež (Novinarska dokumentacija Delo).</p>
      
      <hr/>
      
      <p>Izvedbo sta financirala Državni zbor in Inštitut za novejšo zgodovino (iz programa
         Raziskovalna infrastruktura slovenskega zgodovinopisja I0-0013, ki ga financira
         Agencija za raziskovalno dejavnost Republike Slovenije).</p>
      <p>Kontakt: rds@dz-rs.si</p>
      <p>Ljubljana, 23. december 2021</p>
      <p>Copyright (c) 2021 Državni zbor in Inštitut za novejšo zgodovino</p>
      
      <hr/>
      
      <p>Splošni pogoji uporabe</p>
      <p>Ste na spletni strani www.nastajanje-ustave.si. Vaš dostop do te spletne strani in
         njegovo uporabo urejajo ta splošna pravila kot zakoni. Prosimo, da splošne pogoje
         pazljivo preberete. Z vstopom na spletno stran potrjujete, da ste s temi splošnimi
         pogoji seznanjeni, da z njimi soglašate ter da vas določbe teh splošnih pogojev
         zavezujejo.</p>
      <p>Ti pogoji uporabe veljajo za celotno spletno stran www.nastajanje-ustave.si.</p>
      <p>1. Splošno</p>
      <p>Vsebina Splošnih pogojev o uporabi spletne strani www.nastajanje-ustave.si se nanaša
         na pogoje uporabe spletnih vsebin na spletni strani ter predstavlja pravno veljaven
         in zavezujoč sporazum med ponudnikom ter uporabniki spletne strani.</p>
      <p>2. Avtorske in sorodne pravice</p>
      <p>Vse pravice na objavljenih vsebinah spletne strani www.nastajanje-ustave.si, ki so
         varovane z avtorsko in sorodnimi pravicami, so pridržane, kar pomeni, da jih je brez
         predhodnega pisnega soglasja imetnika pravic prepovedano uporabljati in izkoriščati,
         kar velja tako za komercialne kot za nekomercialne namene uporabe, pri čemer pa te
         omejitve ne posegajo v dovoljene oblike uporabe avtorsko varovanih vsebin, kot jih
         določa Zakon o avtorski in sorodnih pravicah. Omejitve prav tako ne veljajo za dela
         v javni domeni, na katerih so avtorske pravice že potekle.</p>
      <p>Prepovedano je spreminjanje, kopiranje, distribucija, oddajanje, prikazovanje,
         izvajanje, razmnoževanje, objavljanje, licenciranje, ustvarjanje izpeljank,
         prenašanje ali prodajanje katerih koli podatkov, programske opreme, izdelkov ali
         storitev, ki so del spletne strani www.nastajanje-ustave.si, razen v primeru izrecne
         navedbe v teh pogojih uporabe.</p>
      <br/>
      <br/>
      <br/>
   </xsl:template>
   
   
</xsl:stylesheet>
