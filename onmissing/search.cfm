<cfsilent>
	<cfscript>
		if (isdefined('form.search'))
			{
				url.search	= form.search;
			}
		users = application.userObj.get(search=url.search);
	</cfscript>
</cfsilent>

<cfoutput>
	<h1>#getstring('search')#</h1>
	<form method="post" action="/search/index.cfm">
		<div id="waydinput">
			<input type="text" name="search" size="20" value="#url.search#"><input name="searchbutton" type="submit" value="#getstring('search')#" />
		</div>
	</form>
	<h1>#getstring('searchresult')# - #users.recordcount# #getstring('results')#</h1>
	<div id="waydrecent" style="overflow:auto">
		<table width="100%" class="text">
			<cfloop query="users">
				<tr>
					<td>
						<strong>#getstring('name')#</strong>: <a href="/#users.username#/index.cfm">#users.username#</a>
						(<a href="/makepdfhistory/#users.username#/index.cfm" target="_blank">#getstring('makepdfhistory')#</a>)
					</td>
					<td rowspan="3" align="right" valign="top">
						<cfif fileexists('#request.pathmapping#/photos/#users.photo#')>
							<a href="/#users.username#/index.cfm"><img src="/photos/96/#users.photo#" width="96" height="96" class="userico" border="1" /></a>
						<cfelse>
							<a href="/#users.username#/index.cfm"><img src="/images/ico_chefai.png" width="96" height="96" class="userico" border="1" /></a>
						</cfif>
					</td>
				</tr>
				<tr>
					<td>
						<strong>#getstring('country')#</strong>: #users.country#
					</td>
				</tr>
				<tr>
					<td>
						<strong>#getstring('web')#</strong>: #users.siteurl#
					</td>
				</tr>
				<tr>
					<td>
						<strong>#getstring('bio')#</strong>: #users.bio#
					</td>
				</tr>
				<tr><td colspan="3"><hr></td></tr>
			</cfloop>
		</table>
	</div>
</cfoutput>