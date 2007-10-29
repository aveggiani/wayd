<cfsilent>
	<cfscript>
		myuser 		= application.userObj.getUserFromUsername(url.username);
		follow		= application.userObj.getFollows(myuser.userid);
		followers 	= application.userObj.getFollowers(myuser.userid);
		howmany 	= application.waydObj.getCount(userid=myuser.userid);
	</cfscript>
</cfsilent>
<cfoutput>
	<h3>#getstring('about')#</h3>
	<strong>#getstring('name')#</strong>: #myuser.username#
	<br />
	<strong>#getstring('location')#</strong>: #myuser.country#
	<br />
	<strong>#getstring('web')#</strong>: <a href="#myuser.siteurl#">#myuser.siteurl#</a>
	<br />
	<strong>#getstring('bio')#</strong>: <a href="#myuser.siteurl#">#myuser.bio#</a>
	<h3>#getstring('stats')#</h3>
	<table width="100%" class="text">
		<tr>
			<td><strong>#getstring('follow')#</strong></td>
			<td align="right">#follow.recordcount#</td>
		</tr>
		<tr>
			<td><strong>#getstring('followers')#</strong></td>
			<td align="right">#followers.recordcount#</td>
		</tr>
		<tr>
			<td><strong>#getstring('updates')#</strong></td>
			<td align="right">#howmany#</td>
		</tr>
	</table>
	<h3>#getstring('following')#</h3>
	<cfloop query="follow">
		<cfif fileexists('#request.pathmapping#/photos/#follow.photo#')>
			<a href="/#follow.username#/index.cfm"><img src="/photos/24/#follow.photo#" width="24" height="24" class="userico" border="1" /></a>
		<cfelse>
			<a href="/#follow.username#/index.cfm"><img src="/images/24/ico_chefai.png" width="24" height="24" class="userico" border="1" /></a>
		</cfif>
	</cfloop>
</cfoutput>
