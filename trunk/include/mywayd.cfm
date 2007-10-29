<cfoutput>
	<cfset stringTime = application.waydObj.getStringTime(mywayds.created)>
	<div class="wayd">
		<cfif not isdefined('nophoto')>
			<cfif fileexists('#request.pathmapping#/photos/#mywayds.photo#')>
				<img src="/photos/#mywayds.photo#" width="48" height="48" class="userico" border="1" />
			<cfelse>
				<img src="/images/ico_chefai.png" width="48" height="48" class="userico" border="1" />
			</cfif>
		</cfif>
		<cfif not isdefined('nouser')><a href="/#mywayds.username#/index.cfm">#mywayds.username#</a> </cfif>#htmleditformat(mywayds.wayd)#
		<a href="/wayd/#mywayds.waydid#/index.cfm"><cfif listlen(stringTime) gt 1>#listgetat(stringTime,2)#</cfif> #getstring(listgetat(stringTime,1))#</a>
	</div>
</cfoutput>