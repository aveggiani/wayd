<cfsilent>
	<cfscript>
		myuser = application.userObj.getUserFromUsername(url.username);
	</cfscript>
</cfsilent>

<cfoutput>
	<div id="profilephoto">
		<cfif fileexists('#request.pathmapping#/photos/#myuser.photo#')>
			<img src="/photos/96/#myuser.photo#" width="96" height="96" class="userico" border="1" />
		<cfelse>
			<img src="/images/ico_chefai.png" width="96" height="96" class="userico" border="1" />
		</cfif>
	</div>
	<h1>#myuser.username# - (<a href="/makepdfhistory/#myuser.username#/index.cfm" target="_blank">#getstring('makepdfhistory')#</a>)</h1>
	<br />
	<div id="waydrecent">
		<cfdiv id="waydrecentlist" bind="url:/ajax/user_whativedone.cfm?userid=#myuser.userid#&pagesize=6"></cfdiv>
	</div>
</cfoutput>	
