<cfif isdefined('form.username') and form.user_hashval is Hash(form.user_captcha) and application.userObj.checkavailability(form.username) is 'username disponibile'>
	<cfscript>
		session.userObj.preregister(form);	
	</cfscript>
	<cfoutput>
		<h1>#getstring('confirmtitle')#</h1>
		<br />
		<br />
		<div align="center">
			#getstring('confirmmessage')#
		</div>
	</cfoutput>
<cfelse>
	<cfoutput>
		<cfif isdefined('form.username')>
			<div class="error">
				<cfif form.user_hashval is Hash(form.user_captcha)>
					<h1>#getstring('errorusernamealreadyexists')#</h1>
				<cfelse>
					<h1>#getstring('errorcaptcha')#</h1>
				</cfif>
			</div>
		</cfif>
		<h1>#getstring('registertitle')#</h1>
		<cfform method="post" name="register" preservedata="true" preloader="no">
			<table cellspacing="0" class="text">
				<tr>
					<th valign="top">username:</th>
					<td>
						<cfinput type="text" name="username" required="yes" size="15" maxlength="15" typeahead="no" showautosuggestloadingicon="true" /> <small>Il tuo URL: <cfinput size="30" name="myscreen" type="text" disabled="disabled" bind="http://#cgi.server_name#/{username.value}/index.cfm"></small><br />
						<br />
						<input type="button" value="Verify availability" onclick="javascript:verifyUserName(register.username.value);" /><div id="verifyUserNameDiv" class="error" style="display:none;"></div>
					</td>
				</tr>
				<tr>
					<th valign="top">password:</th>
					<td><cfinput type="password" name="password" required="yes" size="30" /></td>
				</tr>
				<tr>
					<th valign="top">#getstring('confirmpassword')#:</th>
					<td>
						<cfinput type="password" name="password_confirmation" required="yes" id="password_confirmation" size="30" />
						<br /><small class="error" id="nomatch" style="display:none;">#getstring('passworddontmatch')#</small>
					</td>
				</tr>
				<tr>
					<th valign="top">#getstring('email')#:</th>
					<td>
						<cfinput type="text" name="email" validate="email" required="yes" size="30" typeahead="no" onFocus="javascript:checkPw();" showautosuggestloadingicon="true" />
					</td>
				</tr>
					<tr>
						<th></th>
						<td>
							<cfset stringLength=6>
							<cfset stringList="2,3,4,5,6,7,8,9,a,b,d,e,f,g,h,j,n,q,r,t,y,A,B,C,D,E,F,G,H,K,L,M,N,P,Q,R,S,T,U,V,W,X,Y,Z">
							<cfset rndString="">
							<!--- Create a loop that builds the string from the random characters. --->
							<cfloop from="1" to="#stringLength#" index="i">
							<cfset rndNum=RandRange(1,listLen(stringList))>
							<cfset rndString=rndString & listGetAt(stringList,rndNum)>
							</cfloop>
							<!--- Hash the random string. --->
							<cfset rndHash=Hash(rndString)>
							<!--- Create the user entry form. --->
							<cfimage action="captcha" fontsize="24" width="200" height="50" text="#rndString#">
							<p>#getstring('readcaptcha')#</p>
							<p><cfinput type="text" name="user_captcha" required="yes" maxlength=6>
							<input type="hidden" name="user_hashVal" value="#rndHash#">
						</td>
					</tr>
					<tr>
						<th></th>
						<td><input name="commit" type="submit" value="#getstring('createaccount')#" /></td>
				</tr>
			</table>
		</cfform>
	</cfoutput>
</cfif>