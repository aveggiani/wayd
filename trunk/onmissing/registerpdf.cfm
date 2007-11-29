<cfif not isdefined('form.username')>
	<cfpdfform source="#PDF.content#" action="read" result="fields"/>
	<cfpdfform action="populate" source="#PDF.content#" destination="#request.pathmapping#/pdf/submitted/#fields.chefai.registrazione.username#.pdf" overwrite="yes"/>
	<cfscript>
		form.username	= fields.chefai.registrazione.username;
		form.password	= fields.chefai.registrazione.password;
		form.email		= fields.chefai.registrazione.email;
	</cfscript>
</cfif>

<cfif isdefined('form.username')>
	<cfscript>
		session.userObj.preregister(form);	
	</cfscript>
	<h1>Account creato</h1>
	<br />
	<br />
	<div align="center">
		A breve riceverai una mail; per favore clicca sul link che troverai all'interno della comunicazione per attivare il tuo account.
	</div>
</cfif>

