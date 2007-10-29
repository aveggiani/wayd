<cfcomponent output="false">
	<cffunction name="onIncomingMessage" access="public" output="false">
		<cfargument name="cfevent" type="struct">
		<cfset var i = 0>
		<cfset var msg = structnew()>
		<cfset msg.body = cfevent.data.body>
		<cfset msg.destination = cfevent.data.destination>
		<cfset msg.headers['gatewayid'] = cfevent.data.headers.gatewayid>
		<cfreturn msg>
	</cffunction>
</cfcomponent>