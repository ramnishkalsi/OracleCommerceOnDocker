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



<title><xsl:value-of select="dg:statistics/@title"/></title>

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

  
    <h1><xsl:value-of select="dg:statistics/@title"/></h1>

<p>Product: <xsl:value-of
select="dg:statistics/dg:general_information/dg:product_information/@product"/>,
<xsl:value-of
select="dg:statistics/dg:general_information/dg:product_information/@version"/>
</p>
<div id="doc">

    <!-- Tabs  -->
    <div id="demo" class="yui-navset">
        <ul class="yui-nav">
            <li class="selected"><a href="#perfSum"><em><b>Performance Summary</b></em></a></li>
            <li><a href="#genInfo"><em><b>General Information</b></em></a></li>
            <li><a href="#indexPrep"><em><b>Index Preparation</b></em></a></li>
	    <li><a href="#cache"><em><b>Cache</b></em></a></li>
	    <li><a href="#details"><em><b>Details</b></em></a></li>
	    

        </ul>
        <div class="yui-content">

	<!-- Perfomance Summary Tab -->
            <div id="perfSum">

	    <!-- Performance -->
	    <!-- each toggle-able div has a table with the image and the title -->
	    <!-- image is set to collapseon if the div is initially visible -->
	    <!-- image is set to expandon if the div is initially hidden -->
	    <!-- on click (a href) toggleLayer and toggleImage are called -->
	    <br/>

	    <a href="javascript:expandAll('perfSum');" style="position:absolute; right:5%; font-size:x-small">Expand All</a>
	    <br/>
	    <a href="javascript:collapseAll('perfSum');" style="position:absolute; right:5%; font-size:x-small">Collapse All</a>
	    
	    <div class="title">
	    <a href="javascript:toggleLayer('perf'); toggleImage('perf_img');">
	      <img src="{$collapse_image}" id="perf_img" border="0"/>
	     Performance 
	      </a>
	      </div>
	      
	      
	      <div id="perf" class="toggle-open">
	      <xsl:value-of select="dg:statistics/dg:general_information/dg:requests_information/@num_requests"/>
	      <xsl:text> </xsl:text> requests received,
	      <xsl:value-of select="dg:statistics/dg:general_information/dg:requests_information/@num_unfinished_requests"/>
	      <xsl:text> </xsl:text> outstanding.  Last request finished at
	      <xsl:value-of select="dg:statistics/dg:general_information/dg:requests_information/@last_request_time"/>.
	      <xsl:if test="dg:statistics/dg:resource_usage_stats/dg:rusage">
	      <p>
	      Total CPU usage:
	      <xsl:value-of select="dg:statistics/dg:resource_usage_stats/dg:rusage/@user_time_seconds"/> 
	      of user time,
	      <xsl:value-of select="dg:statistics/dg:resource_usage_stats/dg:rusage/@system_time_seconds"/>
	      of system time.
	      </p>
	      </xsl:if>

		  <!--Resident Set Size-->
		  <table border="1">
			  <tr><th>What</th><th>Count</th><th>Average</th>
				  <th>Standard Deviation</th><th>Min</th><th>Max</th><th>Total</th><th>Last Value</th></tr>
			  <xsl:for-each select="dg:statistics/dg:resource_usage_stats">
				  <xsl:apply-templates/>
			  </xsl:for-each>
		  </table>
	  </div>

	      <!-- Throughput -->
	      <div class="title" style="left:.5%; font-size:medium;">
	      <a href="javascript:toggleLayer('throughput'); toggleImage('throughput_img');">
	      <img src="{$expand_image}" id="throughput_img" border="0"/>
	      Throughput (<xsl:value-of select="dg:statistics/dg:performance_summary/dg:throughput/@units"/>) 
	      </a>
	      </div>
	      
	      
	      <div id="throughput" class="toggle-closed">
	      <table border="1">
	      <tr><th>Time</th><th>Average</th></tr>
	      <tr><td>5-minute</td>
	      <td><xsl:value-of select="dg:statistics/dg:performance_summary/dg:throughput/@five_minute_avg"/></td>
	      </tr>
	      <tr><td>1-minute</td>
	      <td><xsl:value-of select="dg:statistics/dg:performance_summary/dg:throughput/@one_minute_avg"/></td>
	      </tr>	      
		  <tr><td>10-second</td>
	      <td><xsl:value-of select="dg:statistics/dg:performance_summary/dg:throughput/@ten_second_avg"/></td>
	      </tr>
	      </table>
	      </div> 

	    <!--close perfsum tab div-->
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
		 <tr><td><xsl:value-of select="name(.)"/></td>
		 <td><xsl:value-of select="."/></td></tr>
		 </xsl:for-each>
		 <xsl:for-each select="dg:statistics/dg:general_information/dg:data_information/@*">
		 <tr><td><xsl:value-of select="name(.)"/></td>
		 <td><xsl:value-of select="."/></td></tr>
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
		 <xsl:value-of select="."/><xsl:text> </xsl:text>
		 </xsl:for-each>
		 </div>

            <!--close geninfo tab-->
            </div>

	 <!-- Index Preparation Tab -->
            <div id="indexPrep">
	    <p/>

	    <a href="javascript:expandAll('indexPrep');" style="position:absolute; right:5%; font-size:x-small">Expand All</a>
	    <br/>
	    <a href="javascript:collapseAll('indexPrep');" style="position:absolute; right:5%; font-size:x-small">Collapse All</a>

	    <div class="title">
	    <a href="javascript:toggleLayer('update_totals'); toggleImage('update_totals_img');"  >
	    <img src="{$collapse_image}" id="update_totals_img" border="0"/>
	    Update Totals
	    </a>
	    </div>		
	    <!--Totals-->
	    <div id="update_totals" class="toggle-open">
		<xsl:choose>
		<xsl:when test="dg:statistics/dg:updates/dg:totals/@num_update_cycles=1">
		1 update (initial)
		</xsl:when>
		<xsl:otherwise>
		<xsl:value-of select="dg:statistics/dg:updates/dg:totals/@num_update_cycles"/> updates (including initial).
		</xsl:otherwise>
		</xsl:choose>
		<table border="1">
		<tr><th>What</th><th>Count</th><th>Average</th>
		<th>Standard Deviation</th><th>Min</th><th>Max</th><th>Total</th></tr>
		<xsl:for-each select="dg:statistics/dg:updates">
		<xsl:apply-templates/>
		</xsl:for-each>
		</table>
		</div>

	    <div class="title">
	    <a href="javascript:toggleLayer('configupdates'); toggleImage('configupdates_img');"  >
	    <img src="{$collapse_image}" id="configupdates_img" border="0"/>
	    Config Update Totals
	    </a>
	    </div>	
	    <div id="configupdates" class="toggle-open">
		<table border="1">
		<tr><th>What</th><th>Count</th><th>Average</th>
		<th>Standard Deviation</th><th>Min</th><th>Max</th><th>Total</th></tr>
		<xsl:for-each select="dg:statistics/dg:configupdates">
		<xsl:apply-templates/>
		</xsl:for-each>
		</table>
		</div>

		<!-- Same thing again, but for XQuery -->
	    <div class="title">
	    <a href="javascript:toggleLayer('xquery_update_totals'); toggleImage('xquery_update_totals_img');"  >
	    <img src="{$collapse_image}" id="xquery_update_totals_img" border="0"/>
	    XQuery Update Totals
	    </a>
	    </div>		
	    <!--Totals-->
	    <div id="xquery_update_totals" class="toggle-open">
		<xsl:value-of select="dg:statistics/dg:xqueryupdates/dg:totals/@num_update_cycles"/> updates (including initial).
		<table border="1">
		<tr><th>What</th><th>Count</th><th>Average</th>
		<th>Standard Deviation</th><th>Min</th><th>Max</th><th>Total</th></tr>
		<xsl:for-each select="dg:statistics/dg:xqueryupdates">
		<xsl:apply-templates/>
		</xsl:for-each>
		</table>
		</div>

	    <div class="title">
	    <a href="javascript:toggleLayer('xqueryconfigupdates'); toggleImage('xqueryconfigupdates_img');"  >
	    <img src="{$collapse_image}" id="xqueryconfigupdates_img" border="0"/>
	    XQuery Config Update Totals
	    </a>
	    </div>		
	    <!--Totals-->
	    <div id="xqueryconfigupdates" class="toggle-open">
		<table border="1">
		<tr><th>What</th><th>Count</th><th>Average</th>
		<th>Standard Deviation</th><th>Min</th><th>Max</th><th>Total</th></tr>
		<xsl:for-each select="dg:statistics/dg:xqueryconfigupdates">
		<xsl:apply-templates/>
		</xsl:for-each>
		</table>
		</div>

	    <!--Index Prep -->
	    <div class="title">
	    <a href="javascript:toggleLayer('ind_prep'); toggleImage('ind_prep_img');"  >
	    <img src="{$expand_image}" id="ind_prep_img" border="0"/>
	    Precomputed Sorts
	    </a>
	    </div>
	    
	    <div id="ind_prep" class="toggle-closed"> 
		<table border="1">
		<tr><th>What</th><th>Count</th><th>Average</th>
		<th>Standard Deviation</th><th>Min</th><th>Max</th><th>Total</th></tr>
		<xsl:for-each select="dg:statistics/dg:precomputed_sorts">
		<xsl:apply-templates/>
		</xsl:for-each>
		</table>
	    </div>

	   <!--close index prep tab-->
            </div>

	  <!-- Cache Tab -->
            <div id="cache">
	    <p/>

	    <a href="javascript:expandAll('cache');" style="position:absolute; right:5%; font-size:x-small">Expand All</a>
	    <br/>
	    <a href="javascript:collapseAll('cache');" style="position:absolute; right:5%; font-size:x-small">Collapse All</a>

	    <!-- Main Cache -->
	    <div class="title">
	    <a href="javascript:toggleLayer('main_cache'); toggleImage('main_cache_img');"  >
	    <img src="{$collapse_image}" id="main_cache_img" border="0"/>
	    Main Cache
	    </a>
	    </div>
	    
	    <div id="main_cache" class="toggle-open">
		<table border="1">
		<tr>
		  <th>Type of entry</th>
		  <th># of entries</th>
		  <th>Size of entries</th>
		  <th># of lookups</th>
		  <th>Hit rate</th>
		  <th>Miss rate</th>
		  <th># of evictions</th>
		  <th># of unproductive evictions</th>
		  <th>Size of evictions</th>
		  <th>Avg creation time</th>
		  <th>Avg eviction time</th>
		  <th>Avg unproductive eviction time</th>
		  <th># of rejections</th>
		  <th># of reinsertions</th>
		  <th>Total reinsertion time</th>
		  <th>Eviction candidates per quartile</th>
		</tr>
		<xsl:for-each select="dg:statistics/dg:cache_section/dg:main_cache">

		<xsl:apply-templates/>
		</xsl:for-each>
		</table>
		
	    </div>
	    
	    <!-- Slice Cache -->
	    <div class="title">
	    <a href="javascript:toggleLayer('cache_slices'); toggleImage('main_cache_img');"  >
	    <img src="{$collapse_image}" id="main_cache_img" border="0"/>
	    Per Slice Cache Stats
	    </a>
	    </div>
	    
	    
	    <div id="cache_slices" class="toggle-closed">
	    <xsl:for-each select="dg:statistics/dg:cache_section/dg:cache_slices/dg:slice">
		<table border="1">
		<tr>
		  <th>Type of entry</th>
		  <th># of entries</th>
		  <th>Size of entries</th>
		  <th># of lookups</th>
		  <th>Hit rate</th>
		  <th>Miss rate</th>
		  <th># of evictions</th>
		  <th># of unproductive evictions</th>
		  <th>Size of evictions</th>
		  <th>Avg creation time</th>
		  <th>Avg eviction time</th>
		  <th>Avg unproductive eviction time</th>
		  <th># of rejections</th>
		  <th># of reinsertions</th>
		  <th>Total reinsertion time</th>
		  <th>Eviction candidates per quartile</th>
		</tr>

		<xsl:apply-templates/>
		</table>
		
		<br/>
		</xsl:for-each>
	    </div>
		
		
		
	     <!--close cache div-->
            </div>
		
	 <!--Details tab -->
	    <div id="details">
	    <p/>

	    <a href="javascript:expandAll('details');" style="position:absolute; right:5%; font-size:x-small">Expand All</a>
	    <br/>
	    <a href="javascript:collapseAll('details');" style="position:absolute; right:5%; font-size:x-small">Collapse All</a>

	    <!--Most Expensive Binary Queries-->
	    <div class="title">
	    <a href="javascript:toggleLayer('meq'); toggleImage('meq_img');"  >
	    <img src="{$expand_image}" id="meq_img" border="0"/>
	    Most Expensive Queries
	    </a>	    
	    </div>

	    <div id="meq" class="toggle-closed">
	       <xsl:for-each select="dg:statistics/dg:most_expensive_queries/dg:query">
	       <div>
	       	Query <xsl:value-of select="@rank"/>: <xsl:value-of select="@computation_time_ms"/> ms - &quot;
	        <xsl:value-of select="@url"/>&quot;
	
		</div>
		</xsl:for-each>
	    </div>

	    <!--Hotspots-->
	    <div class="title">
	    <a href="javascript:toggleLayer('hotspot'); toggleImage('hotspot_img');"  >
	    <img src="{$expand_image}" id="hotspot_img" border="0"/>
	    Hotspots
	    </a>	    
	    </div>
	    
	    <div id="hotspot" class="toggle-closed">
	       <table border="1">
	       <tr><th>What</th><th>Num</th><th>Avg</th>
	       <th>Std Dev</th><th>Min</th><th>Max</th><th>Total</th></tr>
	       <xsl:for-each select="dg:statistics/dg:hot_spot_analysis">
	       <xsl:apply-templates/>
	       </xsl:for-each>
	       </table>
	    </div>
	    
	    <!--Results-->
	    <div class="title">
	    <a href="javascript:toggleLayer('results'); toggleImage('results_img');"  >
	    <img src="{$expand_image}" id="results_img" border="0"/>
	    Results
	    </a>	    	
	    </div>    

	    <div id="results" class="toggle-closed">
	        <table border="1">
		<tr><th>What</th><th>Count</th><th>Average</th>
		<th>Standard Deviation</th><th>Min</th><th>Max</th><th>Total</th></tr>
		<xsl:for-each select="dg:statistics/dg:result_page_stats">
		<xsl:apply-templates/>
		</xsl:for-each>
		</table>
	    </div>

	    <!--Server-->
	    <div class="title">
	    <a href="javascript:toggleLayer('server'); toggleImage('server_img');"  >
	    <img src="{$expand_image}" id="server_img" border="0"/>
	    Server
	    </a>	    	
	    </div>    

	    <div id="server" class="toggle-closed">
	        <table border="1">
		<tr><th>What</th><th>Count</th><th>Average</th>
		<th>Standard Deviation</th><th>Min</th><th>Max</th><th>Total</th></tr>
		<xsl:for-each select="dg:statistics/dg:server_stats">
		<xsl:apply-templates/>
		</xsl:for-each>
		</table>
		
		<xsl:for-each select="dg:statistics/dg:server_stats/dg:query_lists/dg:query_list">
		<table border="1">
			<caption><xsl:value-of select="@name"/></caption>
			<tr>
				<th>Rank</th>
				<th>Time (ms)</th>
				<th>Identifier</th>
			</tr>
			<xsl:for-each select="dg:query">
			<tr>
				<td><xsl:value-of select="@rank"/></td>
				<td><xsl:value-of select="@computation_time_ms"/></td>
				<td><xsl:value-of select="@url"/></td>
			</tr>
			</xsl:for-each>
		</table>
		</xsl:for-each>
	    </div>

	    <!--Navigation-->
	    <div class="title">
	    <a href="javascript:toggleLayer('nav'); toggleImage('nav_img');"  >
	    <img src="{$expand_image}" id="nav_img" border="0"/>
	    Navigation
	    </a>	    	
	    </div>    	    

	    <div id="nav" class="toggle-closed">
	        <table border="1">
		<tr><th>What</th><th>Count</th><th>Average</th>
		<th>Standard Deviation</th><th>Min</th><th>Max</th><th>Total</th></tr>
		<xsl:for-each select="dg:statistics/dg:navigation">
		<xsl:apply-templates/>
		</xsl:for-each>
		</table>
	    </div>

	    <!--Record Sorting -->
	    <div class="title">
	    <a href="javascript:toggleLayer('recsorting'); toggleImage('recsorting_img');"  >
	    <img src="{$expand_image}" id="recsorting_img" border="0"/>
	    Record Sorting
	    </a>
	    </div>	    	    	    
	    
	    <div id="recsorting" class="toggle-closed">
	        <table border="1">
		<tr><th>Class of sort</th><th># of sorts</th><th>% of total</th>
		<th># defaulted</th><th>% defaulted</th></tr>
		<xsl:for-each select="dg:statistics/dg:record_sorting_stats/dg:sort_stats">
		<tr>
		<td><xsl:value-of select="@name"/></td>
		<td><xsl:value-of select="@count"/></td>
		<td><xsl:value-of select="@pct_of_total"/>%</td>
		<td><xsl:value-of select="@count_defaulted"/></td>
		<td><xsl:value-of select="@pct_defaulted"/>%</td>
		</tr>
		</xsl:for-each>
		</table>
	    </div>

	    <!--Analytics -->
	    <div class="title">
	    <a href="javascript:toggleLayer('analytics'); toggleImage('analytics_img');"  >
	    <img src="{$expand_image}" id="analytics_img" border="0"/>
	    Analytics
	    </a>	    	
	    </div>    	    
	    
	    <div id="analytics" class="toggle-closed">
	        <table border="1">
		<tr><th>What</th><th>Count</th><th>Average</th>
		<th>Standard Deviation</th><th>Min</th><th>Max</th><th>Total</th></tr>
		<xsl:for-each select="dg:statistics/dg:analytics_performance">
		<xsl:apply-templates/>
		</xsl:for-each>
		</table>
	    </div>

		<!--Disk Usage-->
		<div class="title">
			<a href="javascript:toggleLayer('diskuse'); toggleImage('diskuse_img');">
				<img src="{$collapse_image}" id="diskuse_img" border="0"/>
				Disk Usage
			</a>
		</div>

		<div id="diskuse" class="toggle-open"> 
			<p>
				Total disk usage:
				<xsl:value-of select="dg:statistics/dg:disk_usage/dg:current_disk_usage/@value"/> 
				<xsl:value-of select="dg:statistics/dg:disk_usage/dg:current_disk_usage/@units"/>
			</p>
			<p>
				Disk usage high water mark:
				<xsl:value-of select="dg:statistics/dg:disk_usage/dg:disk_usage_high_water_mark/@value"/> 
				<xsl:value-of select="dg:statistics/dg:disk_usage/dg:disk_usage_high_water_mark/@units"/>
			</p>
		</div>

	    <!--Search-->
	    <div class="title">
	    <a href="javascript:toggleLayer('search'); toggleImage('search_img');"  >
	    <img src="{$expand_image}" id="search_img" border="0"/>
	    Search
	    </a>	    	
	    </div>    	    
	    	   
	    <div id="search" class="toggle-closed">
	        <table border="1">
	        <tr><th>What</th><th>Count</th><th>Average</th>
	        <th>Standard Deviation</th><th>Min</th><th>Max</th><th>Total</th></tr>
	        <xsl:for-each select="dg:statistics/dg:search_performance_analysis">
	        <xsl:apply-templates/>
	        </xsl:for-each>
		</table>
	    </div>

	    <!--Data Layer-->
		<div class="title">
			<a href="javascript:toggleLayer('datalayer'); toggleImage('datalayer_img');"  >
				<img src="{$expand_image}" id="datalayer_img" border="0"/>
				Data Layer Performance
			</a>	    	
		</div>    	    

		<div id="datalayer" class="toggle-closed">
			<p>
				Manager name:
				<xsl:value-of select="dg:statistics/dg:data_layer_performance/dg:manager/@name"/> 
			</p>
			<table border="1">
				<tr><th>What</th><th>Count</th><th>Average</th>
					<th>Standard Deviation</th><th>Min</th><th>Max</th><th>Total</th></tr>
				<xsl:for-each select="dg:statistics/dg:data_layer_performance">
					<xsl:apply-templates/>
				</xsl:for-each>
			</table>
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

<!--Templates-->
<xsl:template match="dg:integration_merge">
  <tr><td>Integration merge</td>
  <td></td><td></td><td></td><td></td><td></td><td></td>
  <td><table border="1" style="font-size:smaller">
  <tr><th>What</th><th>Count</th><th>Average</th><th>Standard Deviation</th><th>Min</th><th>Max</th><th>Total</th></tr>
    <xsl:apply-templates/>
  </table></td>
  </tr>
</xsl:template>


<xsl:template match="dg:stat"><tr><td><xsl:value-of select="@name"/></td><td><xsl:value-of select="@n"/><xsl:text> </xsl:text></td><td><xsl:value-of select="@avg"/><xsl:text> </xsl:text>
   <xsl:value-of select="@units"/></td>
  <td><xsl:value-of select="@stddev"/><xsl:text> </xsl:text>
   <xsl:value-of select="@units"/></td>
  <td><xsl:value-of select="@min"/><xsl:text> </xsl:text>
   <xsl:value-of select="@units"/></td>
  <td><xsl:value-of select="@max"/><xsl:text> </xsl:text>
	  <xsl:value-of select="@units"/></td>
  <td><xsl:if test="@total">
	  <xsl:value-of select="@total"/><xsl:text> </xsl:text>
		  <xsl:value-of select="@units"/>
  </xsl:if></td>
  <td><xsl:if test="@lastvalue">
	  <xsl:value-of select="@lastvalue"/><xsl:text> </xsl:text>
		  <xsl:value-of select="@units"/>
  </xsl:if></td>
  <xsl:if test="dg:stat">

	<xsl:variable name="subsection_name">
		<!-- Create an ID based on unique data from here all the way to the root -->
		<xsl:for-each select="ancestor-or-self::*">
	  		<xsl:text>_</xsl:text><xsl:value-of select="local-name()" /><xsl:text>_</xsl:text><xsl:value-of select="@name" />
		</xsl:for-each>
	</xsl:variable>

	  <td>
       <a href="javascript:toggleLayer('{$subsection_name}'); toggleImage('{$subsection_name}_img');"  >
       <img src="{$expand_image}" id="{$subsection_name}_img" border="0"/>
       </a>
	   <td>
	    <div id="{$subsection_name}" class="toggle-closed-inside">
	    <table width="100%" border="0" style="font-size:smaller"><tr><th>What</th><th>Num</th><th>Avg</th><th>Std Dev</th><th>Min</th><th>Max</th><th>Total</th></tr><xsl:apply-templates/></table>
	    
	    </div>
	</td></td>
  </xsl:if>
</tr></xsl:template>





<xsl:template match="dg:cache_stats">
<tr>
  <xsl:apply-templates/>
  <td><xsl:value-of select="@name"/></td>
  <td><xsl:value-of select="@entry_count"/></td>
  <td><xsl:value-of select="@all_entries_size_mb"/> MB</td>
  <td><xsl:value-of select="@num_lookups"/></td>
  <td><xsl:value-of select="@hit_pct"/>%</td>
  <td><xsl:value-of select="@miss_pct"/>%</td>
  <td><xsl:value-of select="@evictions_count"/></td>
  <td><xsl:value-of select="@unproductive_evictions_count"/></td>
  <td><xsl:value-of select="@evictions_size_mb"/></td>
  <td><xsl:value-of select="@avg_creation_ms"/> ms</td>
  <td><xsl:value-of select="@avg_eviction_ms"/> ms</td>
  <td><xsl:value-of select="@avg_unproductive_eviction_ms"/> ms</td>
  <td><xsl:value-of select="@rejected_count"/></td>
  <td><xsl:value-of select="@reinsertion_count"/></td>
  <td><xsl:value-of select="@reinsertion_creation_ms"/> ms</td>
  <td><xsl:value-of select="@eviction_candidates_per_quartile"/></td>
</tr>
</xsl:template>









</xsl:stylesheet>


