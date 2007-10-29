<cfcomponent>
	<cffunction name="init" access="public" returntype="struct">
		<cfargument name="configurationIniFile" type="string" required="yes">

		<cfscript>
			var	mySectionValues	= structnew();
			var myResult	= structnew();
			var mySections	= getProfileSections(arguments.configurationIniFile);
		</cfscript>
		<cfif isstruct(mySections) and not structIsEmpty(mySections)>
			<cfloop collection="#mySections#" item="mySection">
				<cfscript>
					myListSection 	= evaluate('mysections.#mySection#');
				</cfscript>
				<cfloop index="i" from="1" to="#listlen(myListSection)#">
					<cfscript>
						myKey	= listgetat(myListSection,i);
						myValue	= getProfileString(arguments.configurationIniFile,mySection,listgetat(myListSection,i));
						structinsert(mySectionValues,myKey,myValue);
					</cfscript>
				</cfloop>
				<cfscript>
					structinsert(myResult,mySection,mySectionValues);
					mySectionValues	= structnew();
				</cfscript>
			</cfloop>
		</cfif>
		<cfreturn myResult>
	</cffunction>
</cfcomponent>