<cfsilent>
	<cfscript>
		if (isdefined('form.delete'))
			application.userObj.delete(listgetat(getauthuser(),1,'|'));
	</cfscript>
</cfsilent>
<cfoutput>
	<h1>#getstring('deleteaccounttitle')#</h1>
	<form method="post" action="/index.cfm?logout=1">
		<div align="center">
			<cfif isdefined('form.delete')>
				<br />
				#getstring('userdeleted')#
				<br />
			<cfelse>
				<br />
				<input name="delete" type="submit" value="#getstring('submit')#" />
				<br />
			</cfif>
		</div>
	</form>
</cfoutput>