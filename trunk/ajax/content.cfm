<cfsilent>
	<cfscript>
		if (not isdefined('url.page'))
			mypage = 1;
		else
			mypage = url.page;
		mywayds = application.waydObj.getFull(mypage);
		howmany = application.waydObj.getCount();
	</cfscript>
</cfsilent>
<cfoutput>
	<cfloop query="mywayds">
		<cfinclude template="/include/mywayd.cfm">
	</cfloop>
	<cfif howmany gt 8>
		<div class="more">
			<cfif mypage gt 1>
				<input type="button" value="previous" onclick="ColdFusion.navigate('ajax/content.cfm?page=#decrementvalue(mypage)#','content');" />
			</cfif>
			<cfif mypage * 8 lt howmany>
				<input type="button" value="more" onclick="ColdFusion.navigate('ajax/content.cfm?page=#incrementvalue(mypage)#','content');" />
			</cfif>
		</div>
	</cfif>	
</cfoutput>