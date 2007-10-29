<cfparam name="form.thisLocale" type="string" default="th_TH">
<cfscript>
	thisDir= GetDirectoryFromPath(expandpath("*.*"));
	rb=createObject("component","javaRB");
	rbFile=thisDir & "testJavaRB.properties"; //base resource file
	textConstants=rb.getResourceBundle("#rbFile#","#form.thisLocale#");
	keys=rb.getRBKeys("#rbFile#","#form.thisLocale#");
	cancelButton=rb.getRBString("#rbFile#","Cancel","#form.thisLocale#");
</cfscript>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Test resourceBundle CFC: core Java version</title>
	<style type="text/css" media="screen" title="unicodeTxt">
	        TABLE {
		    font-size : 85%;
	       	font-family : "Arial Unicode MS";
	        }
	</style>    
</head>

<body>
<form action="javaRB.cfm" method="post">
<table border="0" cellspacing="2" cellpadding="2">
<caption align="left">
<b><u>javaRB CFC testbed</u></b>
</caption>
<tr>
<td>
<b>locale</b>:
&nbsp;
<select name="thisLocale" size="1">
		<option value="th_TH" SELECTED>thai</option>
		<option value="en_US">english</option>
</select>
&nbsp;&nbsp;&nbsp;
<input type="submit" value="go">
</td>
</tr>
<tr>
<td>
<b>
<cfoutput>
text from resourceBundle [#thisLocale#]:
<br>
<font color="##009900">
Go: #textConstants.go#
<br>
Cancel:  #textConstants.cancel#
</font>
</cfoutput>
</b>
</td>
</tr>
</table>
</form>
<b><u>javaRB utils methods</u></b>:
<br>
<br>
<cfdump var="#keys#" label="using getRBKeys()">
<br>
<b>Text for "cancel" key using <i>getRBString()</i></b>: 
<font color="##009900" face="Arial Unicode MS"><b><cfoutput>#cancelButton#</cfoutput></b></font>
</body>
</html>
