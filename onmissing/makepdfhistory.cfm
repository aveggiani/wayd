<cfsilent>
	<cfscript>
		url.username = url.myparam;
		myuser = application.userObj.getUserFromUsername(url.username);
		mywayds = application.waydObj.get(myuser.userid);
		nophoto = true;
		nouser	= true;
	</cfscript>
</cfsilent>

<cfdocument saveasname="#myuser.username#.pdf" format="pdf" backgroundvisible="yes" overwrite="no">
	<cfoutput>
		<cffile action="read" file="#request.pathmapping#/css/styles.css" variable="mystyle">
		<html>
			<head>
				<title>#myuser.username# #getstring('history')#</title>
				<style>
					#mystyle#
				</style>
			</head>
			<body>
				<cfdocumentitem type="header">
					<style>
						#mystyle#
					</style>
					<div class="pdfheader">
						#myuser.username# #getstring('history')#
					</div>
				</cfdocumentitem>
				<cfdocumentitem type="footer">
					<style>
						#mystyle#
					</style>
					<div class="pdffooter">
						<i>#getstring('page')# <cfoutput>#cfdocument.currentpagenumber# #getstring('of')# #cfdocument.totalpagecount#</cfoutput></i>
					</div>
				</cfdocumentitem>
				<div style="text-align:left">
					<table width="100%" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top">
								<h1>#myuser.username#</h1>
								#getstring('location')#: #myuser.country#
								<br />
								#getstring('web')#: <a href="#myuser.siteurl#">#myuser.siteurl#</a>
								<br />
								#getstring('bio')#: #myuser.bio#
							</td>
							<td align="right">
								<cfif fileexists('#request.pathmapping#/photos/#myuser.photo#')>
									<img src="/photos/96/#myuser.photo#" width="96" height="96" border="1" />
								<cfelse>
									<img src="/images/ico_chefai.png" width="96" height="96" border="1" />
								</cfif>
							</td>
						</tr>
					</table>
					<div style="width:100%;border-bottom:1px solid black;margin-top:5px;"></div>
					<div id="waydrecent">
						<cfloop query="mywayds">
							<cfinclude template="/include/mywayd.cfm">
						</cfloop>
					</div>
				</div>
			</body>
		</html>
	</cfoutput>	
</cfdocument>