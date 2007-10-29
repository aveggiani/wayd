<cfif isuserloggedin() or isdefined('request.loginSuccessful') and request.loginSuccessful is true>
	<cfoutput>
		<input type="button" value="#getstring('whatimdoing')#" 	onclick="ColdFusion.navigate('/ajax/user_whatimdoing.cfm','content');" />
		<input type="button" value="#getstring('findinvite')#" 		onclick="ColdFusion.navigate('/ajax/user_findinvite.cfm','content');" />
		<input type="button" value="#getstring('settings')#" 		onclick="ColdFusion.navigate('/ajax/user_account_frame.cfm','content');" />
		<input type="button" value="#getstring('logout')#"			onclick="javascript:window.location.href='/index.cfm?logout=1';" />
		<input type="button" value="#getstring('deleteaccount')#"	onclick="javascript:if (confirm('#getstring('areyousuredeleteaccount')#')) ColdFusion.navigate('/ajax/user_delete.cfm','content');" />
		<cfif isdefined('request.loginSuccessful') and request.loginSuccessful is true>
			<script language="javascript">
				ColdFusion.navigate('/ajax/user_whatimdoing.cfm','content');
			</script>
		</cfif>
		<strong>#listgetat(getauthuser(),3,'|')#</strong>
	</cfoutput>
<cfelse>
	<cfoutput>
		<cfif isdefined('request.loginSuccessful') and request.loginSuccessful is false>
			<strong class="error">#getstring('userpwdwrong')#</strong>
		</cfif>
		<cfform method="post"><input type="text" name="j_username" size="15" /><input name="j_password" type="password" size="15" /><input type="submit" value="login" /></cfform>
		<a href="##" onclick="javascript:ColdFusion.navigate('/ajax/forgotpwd.cfm','content');">#getstring('forgotpassword')#</a> <a href="##" onclick="ColdFusion.navigate('/ajax/register.cfm','content');">#getstring('register')#</a>
	</cfoutput>
</cfif>