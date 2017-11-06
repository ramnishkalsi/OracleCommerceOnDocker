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

<xsl:stylesheet version='1.0' 
	xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
	xmlns:stratify='http://www.stratify.com/hierarchy'
	exclude-result-prefixes="stratify">


<xsl:output method="xml" indent="yes" encoding="UTF-8"/>

<xsl:template match="stratify:hierarchy">
	<external_dimensions>
		<xsl:apply-templates select="stratify:topics" />
	</external_dimensions>
</xsl:template>

<xsl:template match="stratify:topics">
	<xsl:apply-templates select="stratify:topic"/>
</xsl:template>

<xsl:template match="stratify:topic">
  <node>
	  <xsl:attribute name="name">
		  <xsl:value-of select="@name"/>
		</xsl:attribute>
		<xsl:attribute name="id">
		  <xsl:value-of select="@id"/>
		</xsl:attribute>
		<xsl:if test="@id != @parentID">
		  <xsl:attribute name="parent">
			  <xsl:value-of select="@parentID"/>
			</xsl:attribute>
		</xsl:if>
		<xsl:attribute name="classify">false</xsl:attribute>
		<synonym>
		  <xsl:attribute name="name">
			  <xsl:value-of select="@id"/>
			</xsl:attribute>
			<xsl:attribute name="classify">true</xsl:attribute>
			<xsl:attribute name="search">false</xsl:attribute>
		</synonym>
	</node>
</xsl:template>

</xsl:stylesheet>