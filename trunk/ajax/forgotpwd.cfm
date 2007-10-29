<cfsilent>
	if (isdefined('form.email'))
		{
			application.userObj.forgotpwd(form.email);
		}
</cfsilent>
<cfoutput>
	<h1>#getstring('forgotpassword')#</h1>
	<cfform method="post" name="register" preservedata="true" preloader="no">
		<div align="center">
			<table cellspacing="0" class="text">
				<tr>
					<th valign="top">#getstring('email')#:</th>
					<td>
						<cfinput type="text" name="email" validate="email" required="yes" size="30" typeahead="no" onFocus="javascript:checkPw();" showautosuggestloadingicon="true" />
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="#getstring('forgotpwdsubmit')#" />
					</td>
				</tr>
			</table>
			<cfif isdefined('form.email')>
				<br />
				<strong class="error">#getstring('forgotpasswordmailsent')#</strong>
			</cfif>
		</div>
	</cfform>
</cfoutput>

