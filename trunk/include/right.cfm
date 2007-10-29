<div id="right">
	<cfif isdefined('url.username')>
		<cfinclude template="/#request.mapping#/include/right_user.cfm">
	<cfelse>
		<cfoutput>
			<h3>#getstring('createaccount')#</h3>
			<div align="center">
				<input type="button" onclick="ColdFusion.navigate('/ajax/register.cfm','content');" value="#getstring('register')#" />
			</div>
			<h3>#getstring('waydpromo')#</h3>
			Il sito &egrave; stato realizzato esclusivamente con <a href="http://www.adobe.it/coldfusion">ColdFusion 8</a> ed ha lo scopo di dimostrare alcune delle principali 
			peculiarit&agrave; della nuova versione dell'Application Server di Adobe:
			<ul>
				<li>gestione immagini</li>
				<li>tecnologia 'push' utilizzando Client Flash o IM (googleTalk)</li>
				<li>funzionalit&agrave; AJAX</li>
				<li>database Derby integrato</li>
				<li>... e molto altro</li>
			</ul>
			<h3>#getstring('findpeople')#</h3>
			<cfform action="/search/index.cfm">
				<div align="center">
					<cfinput type="text" name="search" required="yes" size="10" typeahead="no" showautosuggestloadingicon="true">
					<input name="searchbutton" type="submit" value="#getstring('search')#" />
				</div>
			</cfform>
		</cfoutput>
	</cfif>
</div>
