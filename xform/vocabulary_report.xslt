<?xml version="1.0" encoding="UTF-8"?>

<!--
Copyright 2013, 2017, Oracle and/or its affiliates. All rights reserved.
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
	xmlns:dg="http://xmlns.endeca.com/ene/dgraph">

<xsl:output method="html" encoding="utf-8" doctype-system="about:legacy-compat"/>

<xsl:template match="/dg:vocabulary_report">
	<html>
		<title>
			<xsl:value-of select="@title"/>
		</title>
		<head>
			<style>
				h1.title, h1.title + ul {
					font-size: 1.25em;
					margin: 0 0 0.3em 0;
					font-family: monospace;
				}
				h1.title > a {
					font-size: 0.75em;
					text-decoration: none;
				}
				li.vocab_tab .lang,
				li.vocab_tab .parser,
				li.vocab_tab .diacritic_folding,
				li.vocab_tab .decompounding,
				li.vocab_tab .unknown {
					padding: 1px 5px;
					border: 1px solid #ccc;
					border-radius: 5px;
					font-size: 90%;
				}
				li.vocab_tab .lang {
					text-transform: uppercase;
					background-color: #037;
					border: none;
					color: #fff;
					font-weight: bold;
				}
				li.vocab_tab .parser {
					background-color: #ffc;
				}
				li.vocab_tab .unknown {
					background-color: #c30;
					border: none;
					color: #fff;
				}
				div.vocab_pane > h2 {
					display: none;
				}
				h3 {
					text-transform: capitalize;
				}
				h3 > em {
					text-transform: none;
				}
				td {
					text-overflow: ellipsis;
					overflow: hidden;
					white-space: wrap;
					max-width: 30em;
				}
				td.count {
					text-align: right;
				}
			</style>
			<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css"/>
			<link rel="stylesheet" href="https://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables_themeroller.css"/>
			<script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-1.9.1.js"/>
			<script type="text/javascript" language="javascript" src="https://code.jquery.com/ui/1.10.4/jquery-ui.js"/>
			<script type="text/javascript" language="javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.js"/>
			<script>$(function() {
				$(".tabgroup").tabs();
				$(".accgroup").accordion({
					collapsible: true,
					heightStyle: "content"
				});
				$(document).tooltip();
				jQuery.extend( jQuery.fn.dataTableExt.oSort, {
					"formatted-num-pre": function ( a ) {
							a = (a === "-" || a === "") ? 0 : a.replace( /[^\d\-\.]/g, "" );
							return parseFloat( a );
					},
					"formatted-num-asc": function ( a, b ) {
							return a - b;
					},
					"formatted-num-desc": function ( a, b ) {
							return b - a;
					}
				} );
				$("table.sortable").each(function(i) {
					num_col_idx = [ ];
					$(this).find("th").each(function(i) {
						if ($(this).hasClass("count")) {
							num_col_idx.push(i);
						}
					} );
					$(this).dataTable({
						"aaSorting": [],
						"bSortClasses": false, // do not highlight cells in the sort column
						"aoColumnDefs": [
							{ "sType": "formatted-num", "aTargets": num_col_idx }
						],
						"bJQueryUI": true,
						"bAutoWidth": false,
						"aLengthMenu": [[10, 25, 100, 1000, -1], [10, 25, 100, 1000, "All"]],
						"bPaginate": true,
						"sPaginationType": "full_numbers"
					});
				});
				var more_less = [ "(more...)", "(less...)" ];
				$("a.toggle").click(function() {
					var tgt = $($(this).attr("href"));
					$(this).text(more_less[tgt.is(":visible") ? 0 : 1]);
					tgt.toggle();
					return false;
				}).click();
			});</script>
		</head>
		<body>
			<xsl:variable name="data_origins" select="./dg:meta[@name='data-origin']/@content"/>
			<h1 class="title">
				<xsl:value-of select="@title"/>,
				<xsl:value-of select="@current_time"/>
				<xsl:if test="$data_origins">
					<xsl:text> </xsl:text>
					<a class="toggle" href="#data_origins"/>
				</xsl:if>
			</h1>
			<ul id="metas">
				<xsl:if test="$data_origins">
					<xsl:for-each select="$data_origins">
						<li>Terms sourced via <xsl:value-of select="."/></li>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="./dg:meta[@name='olt-version']">
					<li>
						<xsl:text>OLT version is  </xsl:text>
						<xsl:value-of select="./dg:meta[@name='olt-version']/@content"/>
					</li>
				</xsl:if>
			</ul>
			<div class="tabgroup">
				<ul>
					<xsl:apply-templates mode="bylang_TOC"/>
				</ul>
				<xsl:apply-templates mode="bylang"/>
			</div>
		</body>
	</html>
</xsl:template>

<xsl:template match="/dg:vocabulary_report/dg:vocabulary" mode="bylang_TOC">
	<li class="vocab_tab">
		<a class="lang_name">
			<xsl:attribute name="href">
				<xsl:text>#lang_</xsl:text>
				<xsl:value-of select="@lang"/>
				<xsl:text>_</xsl:text>
				<xsl:value-of select="generate-id(.)"/>
			</xsl:attribute>
			<xsl:value-of select="@lang_name"/>
			<br/>
			<span class="lang" title="RFC 3066 language identifier">
				<xsl:value-of select="@lang"/>
			</span>
			<xsl:text> </xsl:text>
			<span class="parser" title="Parser">
				<xsl:value-of select="@parser"/>
			</span>
			<xsl:if test="@diacritic_folding='yes'">
				<xsl:text> </xsl:text>
				<span class="diacritic_folding" title="Diacritic folding enabled">
					<xsl:text>ã‣a</xsl:text>
				</span>
			</xsl:if>
			<xsl:if test="@decompounding='yes'">
				<xsl:text> </xsl:text>
				<span class="decompounding" title="Decompounding enabled">
					<xsl:text>a⁞b</xsl:text>
				</span>
			</xsl:if>
			<xsl:if test="./dg:terms[@class='unknown']/@count &gt; 0">
				<xsl:text> </xsl:text>
				<!--span class="unknown" title="Unknown term occurrences">
					<xsl:value-of select="format-number(./dg:terms[@class='unknown']/@count,'###,###')"/>
				</span-->
				<span class="unknown" title="Distinct unknown terms">
					<xsl:value-of select="format-number(count(./dg:terms[@class='unknown']/dg:term),'###,###')"/>
				</span>
			</xsl:if>
		</a>
	</li>
</xsl:template>

<xsl:template match="/dg:vocabulary_report/dg:vocabulary" mode="bylang">
	<div class="vocab_pane">
		<xsl:attribute name="id">
			<xsl:text>lang_</xsl:text>
			<xsl:value-of select="@lang"/>
			<xsl:text>_</xsl:text>
			<xsl:value-of select="generate-id(.)"/>
		</xsl:attribute>
		<h2>
			<a>
				<xsl:attribute name="name">
					<xsl:text>lang_</xsl:text>
					<xsl:value-of select="@lang"/>
					<xsl:text>_</xsl:text>
					<xsl:value-of select="generate-id(.)"/>
				</xsl:attribute>
				<xsl:value-of select="@lang_name"/>
			</a>
		</h2>
		<div class="accgroup">
			<xsl:apply-templates select="./dg:terms" mode="table"/>
			<xsl:call-template name="byprop-aggr-table"/>
		</div>
	</div>
</xsl:template>

<xsl:template match="dg:terms" mode="table">
	<h3>
		<xsl:value-of select="@class"/> terms <em>(
		<xsl:value-of select="format-number(count(./dg:term),'###,###')"/> distinct terms,
		<xsl:value-of select="format-number(@count,'###,###')"/> total occurrences
		)</em>
	</h3>
	<div>
		<xsl:apply-templates select="." mode="table-impl"/>
	</div>
</xsl:template>

<xsl:template match="/dg:vocabulary_report/dg:vocabulary/dg:terms" mode="table-impl">
	<xsl:variable name="has_stem" select="./dg:term/dg:stem"/>
	<xsl:variable name="has_comp" select="./dg:term/dg:comp"/>
	<table class="sortable">
		<thead>
			<tr>
				<th class="term">Term</th>
				<th class="count">Occurrences</th>
				<xsl:if test="$has_stem">
					<th class="term">Best stem</th>
				</xsl:if>
				<xsl:if test="$has_comp">
					<th class="terms">Components</th>
				</xsl:if>
			</tr>
		</thead>
		<tbody>
			<xsl:for-each select="./dg:term">
				<xsl:sort select="@value" data-type="text" order="ascending"/>
				<tr>
					<td>
						<xsl:value-of select="@value"/>
					</td>
					<td class="count">
						<xsl:value-of select="format-number(@count,'###,###')"/>
					</td>
					<xsl:if test="$has_stem">
						<td>
							<xsl:value-of select="./dg:stem/@value"/>
						</td>
					</xsl:if>
					<xsl:if test="$has_comp">
						<td>
							<xsl:for-each select="./dg:comp">
								<xsl:value-of select="./@value"/>
								<xsl:if test="position() != last()">
									<xsl:text>, </xsl:text>
								</xsl:if>
							</xsl:for-each>
						</td>
					</xsl:if>
				</tr>
			</xsl:for-each>
		</tbody>
	</table>
</xsl:template>

<xsl:template match="/dg:vocabulary_report/dg:vocabulary/dg:terms[@class='unknown']" mode="table-impl">
	<table class="sortable">
		<thead>
			<tr>
				<th class="term">Unknown term</th>
				<th class="count">Occurrences</th>
			</tr>
		</thead>
		<tbody>
			<xsl:for-each select="./dg:term">
				<xsl:sort select="@count" data-type="number" order="descending"/>
				<xsl:sort select="@value" data-type="text" order="ascending"/>
				<tr>
					<td>
						<xsl:value-of select="@value"/>
					</td>
					<td class="count">
						<xsl:value-of select="format-number(@count,'###,###')"/>
					</td>
				</tr>
			</xsl:for-each>
		</tbody>
	</table>
</xsl:template>

<xsl:key name="k_all_prop_names" match="dg:by_property/@name" use="."/>
<xsl:template name="byprop-aggr-table">
	<xsl:variable name="has_knowns" select="./dg:terms[@class='known']"/>
	<h3>
		unknown terms, by property
	</h3>
	<div>
		<table class="sortable">
			<thead>
				<tr>
					<th class="prop">Property</th>
					<th class="count">Unknown term<br/>occurrences</th>
					<xsl:if test="$has_knowns">
						<th class="count">Known term<br/>occurrences</th>
					</xsl:if>
				</tr>
			</thead>
			<tbody>
				<!-- using Muenchian grouping -->
				<xsl:variable name="vocabulary" select="."/>
				<xsl:for-each select="./dg:terms/dg:by_property/@name[generate-id() = generate-id(key('k_all_prop_names',.)[1])]">
					<xsl:sort select="$vocabulary/dg:terms[@class='unknown']/dg:by_property[@name=current()]/@count" data-type="number" order="descending"/>
					<xsl:sort select="sum($vocabulary/dg:terms[not(@class='unknown')]/dg:by_property[@name=current()]/@count)" data-type="number" order="descending"/>
					<tr>
						<td>
							<xsl:value-of select="current()"/>
						</td>
						<td class="count">
							<xsl:variable name="unknown_cnt" select="$vocabulary/dg:terms[@class='unknown']/dg:by_property[@name=current()]/@count"/>
							<xsl:if test="$unknown_cnt &gt; 0">
								<xsl:value-of select="format-number($unknown_cnt,'###,###')"/>
							</xsl:if>
						</td>
						<xsl:if test="$has_knowns">
							<td class="count">
								<xsl:variable name="known_cnt" select="sum($vocabulary/dg:terms[not(@class='unknown')]/dg:by_property[@name=current()]/@count)"/>
								<xsl:if test="$known_cnt &gt; 0">
									<xsl:value-of select="format-number($known_cnt,'###,###')"/>
								</xsl:if>
							</td>
						</xsl:if>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</div>
</xsl:template>

</xsl:stylesheet>