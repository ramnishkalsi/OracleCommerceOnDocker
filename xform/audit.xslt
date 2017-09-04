<?xml version="1.0" encoding="UTF-8"?>

<!-- 
Copyright 2009, 2017, Oracle and/or its affiliates. All rights reserved.
Oracle and Java are registered trademarks of Oracle and/or its 
affiliates. Other names may be trademarks of their respective owners.
UNIX is a registered trademark of The Open Group.

This software and related documentation are provided under a license 
agreement containing restrictions on use and disclosure and are 
protected by intellectual property laws. Except as expressly permitted 
in your license agreement or allowed by law, you may not use, copy, 
reproduce, translate, broadcast, modify, license, transmit, distribute, 
exhibit, perform, publish, or display any part, in any form, or by any 
means. Reverse engineering, disassembly, or decompilation of this 
software, unless required by law for interoperability, is prohibited.
The information contained herein is subject to change without notice 
and is not warranted to be error-free. If you find any errors, please 
report them to us in writing.
U.S. GOVERNMENT END USERS: Oracle programs, including any operating 
system, integrated software, any programs installed on the hardware, 
and/or documentation, delivered to U.S. Government end users are 
"commercial computer software" pursuant to the applicable Federal 
Acquisition Regulation and agency-specific supplemental regulations. 
As such, use, duplication, disclosure, modification, and adaptation 
of the programs, including any operating system, integrated software, 
any programs installed on the hardware, and/or documentation, shall be 
subject to license terms and license restrictions applicable to the 
programs. No other rights are granted to the U.S. Government.
This software or hardware is developed for general use in a variety 
of information management applications. It is not developed or 
intended for use in any inherently dangerous applications, including 
applications that may create a risk of personal injury. If you use 
this software or hardware in dangerous applications, then you shall 
be responsible to take all appropriate fail-safe, backup, redundancy, 
and other measures to ensure its safe use. Oracle Corporation and its 
affiliates disclaim any liability for any damages caused by use of this 
software or hardware in dangerous applications.
This software or hardware and documentation may provide access to or 
information on content, products, and services from third parties. 
Oracle Corporation and its affiliates are not responsible for and 
expressly disclaim all warranties of any kind with respect to 
third-party content, products, and services. Oracle Corporation and 
its affiliates will not be responsible for any loss, costs, or damages 
incurred due to your access to or use of third-party content, products, 
or services.
-->

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:dg="http://xmlns.endeca.com/ene/dgraph"
>
  <xsl:output method="html"/>


  <!-- Variables -->
  <xsl:variable name="expand_image">stats_components/expandon.gif</xsl:variable>
  <xsl:variable name="collapse_image">stats_components/collapseon.gif</xsl:variable>

  <xsl:template match="/">

    <html>



      <title>
        <xsl:value-of select="dg:statistics/@title"/>
      </title>

      <head>

        <!-- Dependencies for yahoo widgets-->
        <script type="text/javascript" src="stats_components/yahoo-dom-event.js"></script>
        <script type="text/javascript" src="stats_components/element-beta-min.js"></script>
        <script type="text/javascript" src="stats_components/tabview-min.js"></script>
        <script type="text/javascript" src="stats_components/yahoo-min.js"></script>
        <script type="text/javascript" src="stats_components/event-min.js"></script>

        <link rel="stylesheet" type="text/css" href="stats_components/tabview.css"></link>
        <link rel="stylesheet" type="text/css" href="stats_components/bordertabs.css"></link>
        <link rel="stylesheet" type="text/css" href="stats_components/example.css"></link>








        <script type="text/javascript">

          //initializes the tabs
          function tabInit() {
          var tabView = new YAHOO.widget.TabView('demo');
          }

          //gets the absolute path of an image from the relative path.
          //useful when comparing paths
          function getAbsPath( relPath)
          {
          image = new Image();
          image.src = relPath;
          return image.src;
          }

          //hides or shows the layer, the id is passed in
          function toggleLayer( whichLayer )
          {
          var elem, vis;

          elem = document.getElementById( whichLayer );

          vis = elem.style;
          if (vis.display=='' &amp;&amp; elem.offsetWidth!=undefined &amp;&amp; elem.offsetHeight!=undefined)
          vis.display = (elem.offsetWidth!=0 &amp;&amp; elem.offsetHeight!=0)?'block':'none';



          if (vis.display=='' || vis.display=='none')
          {
          vis.display = 'block';
          }
          else
          {
          vis.display = 'none';
          }
          }




          //switches between expandon and collapseon images.
          //the id of the image is passed in
          function toggleImage( whichImage)
          {
          var image = document.getElementById(whichImage);

          if (image.src == getAbsPath('<xsl:value-of select="$expand_image"/>'))
          {
          image.src = '<xsl:value-of select="$collapse_image"/>';
          }
          else
          {
          image.src = '<xsl:value-of select="$expand_image"/>';
          }
          return;
          }


          //expands all top level layers in the tab
          function expandAll(tabName)
          {
          var tab = document.getElementById(tabName);

          for (i=0; i&lt;tab.childNodes.length; i++)
          {

          if (tab.childNodes[i].nodeName=="DIV" &amp;&amp;
          (tab.childNodes[i].className=="toggle-open" ||
          tab.childNodes[i].className=="toggle-closed"))
          {
          var vis = tab.childNodes[i].style;
          vis.display = 'block';
          tabID = tab.childNodes[i].getAttribute("id");
          var image = document.getElementById(tabID + "_img");
          image.src = '<xsl:value-of select="$collapse_image"/>';
          }
          }
          }

          //collapses all top level layers in the tab
          function collapseAll(tabName)
          {
          var tab = document.getElementById(tabName);

          for (i=0; i&lt;tab.childNodes.length; i++)
          {

          if (tab.childNodes[i].nodeName=="DIV" &amp;&amp;
          (tab.childNodes[i].className=="toggle-open" ||
          tab.childNodes[i].className=="toggle-closed"))
          {
          var vis = tab.childNodes[i].style;
          vis.display = 'none';
          tabID = tab.childNodes[i].getAttribute("id");
          var image = document.getElementById(tabID + "_img");
          image.src = '<xsl:value-of select="$expand_image"/>';
          }
          }
          }






        </script>

        <!-- CSS - the specified divs can be shown or hidden. -->
        <!-- If display is set to none, the div is initially hidden -->
        <!-- If the display is set to block, the div is initially visible -->
        <style type="text/css">

          A {text-decoration:none; color:black}
          p {font:verdana}
          body {background:#white}


          div.toggle-open
          {
          margin: 0px 20px 0px 20px;
          display: block;
          }

          div.toggle-closed
          {
          margin: 0px 20px 0px 20px;
          display: none;

          }

          div.toggle-closed-inside
          {
          display:none;
          }

          div.title
          {
          left:.5%;
          padding-bottom:5px;
          font-size:medium;
          }




        </style>



      </head>
      <body>


        <h1>
          <xsl:value-of select="dg:statistics/@title"/>
        </h1>
        
        <p>
          Product: <xsl:value-of
          select="dg:statistics/dg:general_information/dg:product_information/@product"/>,
          <xsl:value-of
          select="dg:statistics/dg:general_information/dg:product_information/@version"/>
        </p>

        <div id="doc">

          <!-- Tabs  -->
          <div id="demo" class="yui-navset">
            <ul class="yui-nav">
              <li class="selected"><a href="#audit"><em><b>Audit Stats</b></em></a></li>
              <li><a href="#genInfo"><em><b>General Information</b></em></a></li>
            </ul>
            <div class="yui-content">

              <!--Details tab -->
              <div id="audit">
                <p/>

                <a href="javascript:expandAll('audit');" style="position:absolute; right:5%; font-size:x-small">Expand All</a>
                <br/>
                <a href="javascript:collapseAll('audit');" style="position:absolute; right:5%; font-size:x-small">Collapse All</a>

                <!--Query Load-->
                <div class="title">
                  <a href="javascript:toggleLayer('ql'); toggleImage('ql_img');"  >
                    <img src="{$collapse_image}" id="ql_img" border="0"/>
                    Query Load
                  </a>
                </div>

                <div id="ql" class="toggle-open">
                  <table border="1">
                    <tr>
                      <th>Period</th>
                      <th>Period Length</th>
                      <th>Peak Interval</th>
                      <th>Interval Length</th>
                      <th>Peak Value</th>
                    </tr>
                    <xsl:for-each select="dg:statistics/dg:query_load">
                      <xsl:apply-templates/>
                    </xsl:for-each>
                  </table>
                </div>

                <div class="title">
                  <a href="javascript:toggleLayer('ql'); toggleImage('ql_img');"  >
                    <img src="{$collapse_image}" id="ql_img" border="0"/>
                    Net Query Load
                  </a>
                </div>

                <div id="ql" class="toggle-open">
                  <table border="1">
                    <tr>
                      <th>Period</th>
                      <th>Period Length</th>
                      <th>Peak Interval</th>
                      <th>Interval Length</th>
                      <th>Peak Value</th>
                    </tr>
                    <xsl:for-each select="dg:statistics/dg:net_query_load">
                      <xsl:apply-templates/>
                    </xsl:for-each>
                  </table>
                </div>

                <div class="title">
                  <a href="javascript:toggleLayer('ql'); toggleImage('ql_img');"  >
                    <img src="{$collapse_image}" id="ql_img" border="0"/>
                    WS Query Load
                  </a>
                </div>

                <div id="ql" class="toggle-open">
                  <table border="1">
                    <tr>
                      <th>Period</th>
                      <th>Period Length</th>
                      <th>Peak Interval</th>
                      <th>Interval Length</th>
                      <th>Peak Value</th>
                    </tr>
                    <xsl:for-each select="dg:statistics/dg:ws_query_load">
                      <xsl:apply-templates/>
                    </xsl:for-each>
                  </table>
                </div>

                <!--Number of Records-->
                <div class="title">
                  <a href="javascript:toggleLayer('nr'); toggleImage('nr_img');"  >
                    <img src="{$collapse_image}" id="nr_img" border="0"/>
                    Number Of Records
                  </a>
                </div>

                <div id="nr" class="toggle-open">
                  <table border="1">
                    <tr>
                      <th>Period</th>
                      <th>Period Length</th>
                      <th>Peak Time</th>
                      <th>Peak Value</th>
                    </tr>
                    <xsl:for-each select="dg:statistics/dg:number_of_records">
                      <xsl:apply-templates/>
                    </xsl:for-each>
                  </table>
                </div>

                <!--Number of Columns-->
                <div class="title">
                  <a href="javascript:toggleLayer('nc'); toggleImage('nc_img');"  >
                    <img src="{$collapse_image}" id="nc_img" border="0"/>
                    Number Of Columns
                  </a>
                </div>

                <div id="nc" class="toggle-open">
                  <table border="1">
                    <tr>
                      <th>Period</th>
                      <th>Period Length</th>
                      <th>Peak Time</th>
                      <th>Peak Value</th>
                    </tr>
                    <xsl:for-each select="dg:statistics/dg:number_of_columns">
                      <xsl:apply-templates/>
                    </xsl:for-each>
                  </table>
                </div>

                <!--Number of Words-->
                <div class="title">
                  <a href="javascript:toggleLayer('nw'); toggleImage('nw_img');"  >
                    <img src="{$collapse_image}" id="nw_img" border="0"/>
                    Number Of Words
                  </a>
                </div>

                <div id="nw" class="toggle-open">
                  <table border="1">
                    <tr>
                      <th>Period</th>
                      <th>Period Length</th>
                      <th>Peak Time</th>
                      <th>Peak Value</th>
                    </tr>
                    <xsl:for-each select="dg:statistics/dg:number_of_words">
                      <xsl:apply-templates/>
                    </xsl:for-each>
                  </table>
                </div>
                <!--Number of Assignments-->
                <div class="title">
                  <a href="javascript:toggleLayer('na'); toggleImage('na_img');"  >
                    <img src="{$collapse_image}" id="na_img" border="0"/>
                    Number Of Assignments
                  </a>
                </div>

                <div id="na" class="toggle-open">
                  <table border="1">
                    <tr>
                      <th>Period</th>
                      <th>Period Length</th>
                      <th>Peak Time</th>
                      <th>Peak Value</th>
                    </tr>
                    <xsl:for-each select="dg:statistics/dg:number_of_assignments">
                      <xsl:apply-templates/>
                    </xsl:for-each>
                  </table>
                </div>

              <!--Size of Data-->
              <div class="title">
                <a href="javascript:toggleLayer('sd'); toggleImage('sd_img');"  >
                  <img src="{$collapse_image}" id="sd_img" border="0"/>
                  Size Of Data
                </a>
              </div>

              <div id="sd" class="toggle-open">
                <table border="1">
                  <tr>
                    <th>Period</th>
                    <th>Period Length</th>
                    <th>Peak Time</th>
                    <th>Peak Value</th>
                  </tr>
                  <xsl:for-each select="dg:statistics/dg:size_of_data">
                    <xsl:apply-templates/>
                  </xsl:for-each>
                </table>
              </div>
            </div>

              <!--General Information Tab -->
                <div id="genInfo">
                  <p/>

                  <a href="javascript:expandAll('genInfo');" style="position:absolute; right:5%; font-size:x-small">Expand All</a>
                  <br/>
                  <a href="javascript:collapseAll('genInfo');" style="position:absolute; right:5%; font-size:x-small">Collapse All</a>

                  <!-- Information-->
                  <div class="title">
                    <a href="javascript:toggleLayer('info'); toggleImage('info_img');"  >
                      <img src="{$collapse_image}" id="info_img" border="0"/>
                      Information
                    </a>
                  </div>

                  <div id="info" class="toggle-open">
                    <table border="1">

                      <xsl:for-each select="dg:statistics/dg:general_information/dg:dgraph_process_information/@*">
                        <tr>
                          <td>
                            <xsl:value-of select="name(.)"/>
                          </td>
                          <td>
                            <xsl:value-of select="."/>
                          </td>
                        </tr>
                      </xsl:for-each>
                      <xsl:for-each select="dg:statistics/dg:general_information/dg:data_information/@*">
                        <tr>
                          <td>
                            <xsl:value-of select="name(.)"/>
                          </td>
                          <td>
                            <xsl:value-of select="."/>
                          </td>
                        </tr>
                      </xsl:for-each>
                    </table>
                  </div>

                  <!-- Arguments -->
                  <div class="title">
                    <a href="javascript:toggleLayer('args'); toggleImage('args_img');"  >
                      <img src="{$expand_image}" id="args_img" border="0" />
                      Arguments
                    </a>
                  </div>

                  <div id="args" class="toggle-closed">
                    <xsl:for-each select="dg:statistics/dg:general_information/dg:arguments/dg:argument">
                      <xsl:if test="starts-with(., '-')">
                        <br> </br>
                      </xsl:if>
                      <xsl:value-of select="."/>
                      <xsl:text> </xsl:text>
                    </xsl:for-each>
                  </div>
              </div>
              <!-- close yui-content-->
            </div>
            <!--close tabs-->
          </div>
          <!--close doc-->
        </div>
        <script>
          //call the tab initialization function
          tabInit();


        </script>









      </body>
    </html>
  </xsl:template>

  <xsl:template match="dg:count_stat">
    <tr>
      <td>
        <xsl:value-of select="@time_period"/>
      </td>
      <td>
        <xsl:value-of select="@period_length"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="@period_unit"/>
        <xsl:if test="@period_unit != 1">
          <xsl:text>s</xsl:text>
        </xsl:if>
      </td>
      <td>
        <xsl:value-of select="@peak_interval"/>
      </td>
      <td>
        <xsl:value-of select="@interval_length"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="@interval_unit"/>
        <xsl:if test="@interval_unit != 1">
          <xsl:text>s</xsl:text>
        </xsl:if>
      </td>
      <td>
        <xsl:value-of select="@peak_value"/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="dg:value_stat">
    <tr>
      <td>
        <xsl:value-of select="@time_period"/>
      </td>
      <td>
        <xsl:value-of select="@period_length"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="@period_unit"/>
        <xsl:if test="@period_unit != 1">
          <xsl:text>s</xsl:text>
        </xsl:if>
      </td>
      <td>
        <xsl:value-of select="@peak_time"/>
      </td>
      <td>
        <xsl:value-of select="@peak_value"/>
      </td>
    </tr>
  </xsl:template>

</xsl:stylesheet>


