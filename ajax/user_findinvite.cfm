<cfsilent>
	<cfscript>
		if (isdefined('url.follow'))
			application.userObj.follow(listgetat(getauthuser(),1,'|'),url.follow,url.value);
		if (isdefined('form.search'))
			{
				imfollowing = application.userObj.get(search=form.search);
			}
		else
			{
				imfollowing = application.userObj.getMySubscribers(listgetat(getauthuser(),1,'|'));
			}
	</cfscript>
</cfsilent>

<cfoutput>
	<h1>#getstring('findinvite')#</h1>
	<cfform method="post">
		<div id="waydinput">
			<cfinput type="text" name="search" size="20"><input name="searchbutton" type="submit" value="#getstring('search')#" />
		</div>
	</cfform>
	<cfif isdefined('form.search')>
		<h1>#getstring('searchresult')#</h1>
	<cfelse>
		<h1>#getstring('youarefollowing')#</h1>
	</cfif>
	<div id="waydrecent" style="overflow:auto">
		<table width="100%" class="text">
			<cfloop query="imfollowing">
				<tr>
					<td>
						<strong>#getstring('name')#</strong>: <a href="/#imfollowing.username#/index.cfm">#imfollowing.username#</a>
						(<a href="/makepdfhistory/#imfollowing.username#/index.cfm" target="_blank">#getstring('makepdfhistory')#</a>)
					</td>
					<td rowspan="3" align="right">
						#getstring('follow')#
						<input type="radio" <cfif application.userObj.imFollowing(listgetat(getauthuser(),1,'|'),imfollowing.userid)>checked</cfif> name="follow" value="true" onclick="javascript:ColdFusion.navigate('/ajax/user_findinvite.cfm?follow=#imfollowing.userid#&value=true','content');">
						#getstring('true')#
						<input type="radio" <cfif not application.userObj.imFollowing(listgetat(getauthuser(),1,'|'),imfollowing.userid)>checked</cfif> name="follow" value="false" onclick="javascript:ColdFusion.navigate('/ajax/user_findinvite.cfm?follow=#imfollowing.userid#&value=false','content');">
						#getstring('false')#
						<br />
						<br />
						<cfif fileexists('#request.pathmapping#/photos/#imfollowing.photo#')>
							<a href="/#imfollowing.username#/index.cfm"><img src="/photos/#imfollowing.photo#" width="48" height="48" border="1" /></a>
						<cfelse>
							<a href="/#imfollowing.username#/index.cfm"><img src="/images/ico_chefai.png" width="48" height="48" border="1" /></a>
						</cfif>
					</td>
				</tr>
				<tr>
					<td>
						<strong>#getstring('country')#</strong>: #imfollowing.country#
					</td>
				</tr>
				<tr>
					<td>
						<strong>#getstring('web')#</strong>: #imfollowing.siteurl#
					</td>
				</tr>
				<tr>
					<td>
						<strong>#getstring('bio')#</strong>: #imfollowing.bio#
					</td>
				</tr>
				<tr><td colspan="3"><hr></td></tr>
			</cfloop>
		</table>
	</div>
</cfoutput>