<cfsilent>
	<cfscript>
		if (not isdefined('url.myparam'))
			url.myparam = 1;
		mywayd = application.waydObj.get(waydid = url.myparam);
		stringTime = application.waydObj.getStringTime(mywayd.created);
	</cfscript>
</cfsilent>
<cfoutput>
	<h1>#mywayd.username# - <cfif listlen(stringTime) gt 1>#listgetat(stringTime,2)#</cfif> #getstring(listgetat(stringTime,1))#</h1>
	<div id="mywayd">#mywayd.wayd#</div>
</cfoutput>



