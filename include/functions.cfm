<cffunction name="getString" returntype="string" output="no">
	<cfargument name="label" type="string" required="yes">
	<cfscript>
		var myResult = '';
		if (structkeyexists(application.lnStrings,arguments.label))
			myResult = evaluate('application.lnStrings.#arguments.label#');
		else
			myResult = '#arguments.label# not present';
	</cfscript>		
	<cfreturn myResult>
</cffunction>
