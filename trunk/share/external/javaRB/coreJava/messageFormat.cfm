<cfparam name="form.locale" type="string" default="en_US">
<cfscript>
rb=createObject("component","javaRB");
pattern='On <font color="##FF0000">{1,date,full}</font> at <font color="##FF0000">{1,time,medium}</font>, I left <b>{2}</b> for the <font color="##FF0000">{3}</font>. I took <b>{4,number,currency}</b> with me.does rounding work? <b>{4,number,integer}</b>!';
args=arrayNew(1);
args[1]=now();
args[2]="the office";
args[3]="tawan dang microbrewery";
args[4]=10001.75;
thisMsg=rb.messageFormat(pattern,args,form.locale);
localeObj=createObject("java","java.util.Locale");
locales=localeObj.getAvailableLocales();
</cfscript>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>MessageFormat TestBed: core Java version</title>
</head>

<body>
<cfoutput>
<form action="messageFormat.cfm" method="post" name="messageFormat" id="messageFormat">
<table width="75%">
<tr valign="top" bgcolor="##c0c0c0">
	<td align="right"><b>locale</b>:</td>
	<td>
	<select name="locale" size="1">
		<cfloop index="i" from="1" to="#arrayLen(locales)#">
			<option value="#locales[i].toString()#">#locales[i].toString()#</option>
		</cfloop>
	</select>	
	&nbsp;&nbsp;<input type="submit" value="go">
	</td>
</tr>
<tr valign="top">
	<td align="right" bgcolor="##c0c0c0"><b>this locale</b>:</td>
	<td>#form.locale#</td>
</tr>	
<tr valign="top">
	<td align="right" bgcolor="##c0c0c0"><b>data</b>:</td>
	<td>#now()#,"the office", "tawan dang microbrewery", 10001.75</td>
</tr>
<tr valign="top">
	<td align="right" bgcolor="##c0c0c0"><b>pattern</b>:</td>
	<td>#pattern#</td>
</tr>
<tr valign="top">
	<td align="right" bgcolor="##c0c0c0"><b>formatted</b>:</td>
	<td>#thisMsg#</td>
</tr>
</table>
</form>
</cfoutput>
</body>
</html>
