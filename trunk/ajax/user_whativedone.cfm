<cfsilent>
	<cfscript>
		if (not isdefined('url.pagesize'))
			url.pagesize = 5;
		if (not isdefined('url.userid'))
			url.userid = listgetat(getauthuser(),1,'|');
		if (not isdefined('url.page'))
			mypage = 1;
		else
			mypage = url.page;
		mywayds = application.waydObj.getFull(mypage,url.pagesize,url.userid);
		howmany = application.waydObj.getCount(userid=url.userid);
		nophoto = true;
		nouser	= true;
	</cfscript>
</cfsilent>
<cfoutput>
	<cfloop query="mywayds">
		<cfinclude template="/include/mywayd.cfm">
	</cfloop>
	<cfif howmany gt url.pagesize>
		<div class="more">
			<cfif mypage gt 1>
				<input type="button" value="previous" onclick="ColdFusion.navigate('/ajax/user_whativedone.cfm?page=#decrementvalue(mypage)#&userid=#url.userid#&pagesize=#url.pagesize#','waydrecentlist');" />
			</cfif>
			<cfif mypage * url.pagesize lt howmany>
				<input type="button" value="more" onclick="ColdFusion.navigate('/ajax/user_whativedone.cfm?page=#incrementvalue(mypage)#&userid=#url.userid#&pagesize=#url.pagesize#','waydrecentlist');" />
			</cfif>
		</div>
	</cfif>	
</cfoutput>