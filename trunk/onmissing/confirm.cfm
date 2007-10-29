<cfsilent>
	<cfscript>
		if (isdefined('url.uuid'))
			isok = session.userObj.confirm(url.uuid);
		else
			isok = false;			
	</cfscript>
</cfsilent>
<cfif isok>
<h1>Registrazione confermata!</h1>
<cfelse>
<h1>Si è verificato un errore; il parametro passato non è valido!</h1>
</cfif>