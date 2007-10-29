<cfscript>
	if (isdefined('form.saveuser'))
		application.userObj.update(listgetat(getauthuser(),1,'|'),form);
	myprofile = application.userObj.get(listgetat(getauthuser(),1,'|'));
	countries = application.dbObj.countries;
	if (myprofile.country is not '')
		countryselected = myprofile.country;
	else
		countryselected = 'it';
</cfscript>

<cfinclude template="/#request.mapping#/include/header.cfm">
	<cfoutput>
		<cfform enctype="multipart/form-data"  method="post" onsubmit="return checkPw();">
			<cflayout type="tab" align="center" tabposition="top" tabheight="400">
				<cflayoutarea title="#getstring('account')#">
					<table cellspacing="4" class="text">
						<tr>
							<th valign="top">#getstring('email')#:</th>
							<td>
								<cfinput type="text" name="email" value="#myprofile.email#" validate="email" required="yes" size="30" typeahead="no" />
							</td>
						</tr>
						<tr>
							<th valign="top">#getstring('siteurl')#:</th>
							<td>
								<cfinput type="text" name="siteurl" value="#myprofile.siteurl#" validate="url" size="30" typeahead="no" />
							</td>
						</tr>
						<tr>
							<th valign="top">#getstring('country')#:</th>
							<td>
								<cfselect enabled="No" name="country" multiple="no" query="countries" value="code" display="country" selected="#countryselected#">
								</cfselect>
							</td>
						</tr>
						<tr>
							<th valign="top">#getstring('bio')#:</th>
							<td>
								<cftextarea name="bio" enabled="no" bindonload="no" value="#htmleditformat(myprofile.bio)#" height="250" width="300" toolbaronfocus="no" richtext="yes" toolbar="Basic" fontnames="sans-serif" fontsizes="0.75em" skin="office2003" visable="no" />
							</td>
						</tr>
					</table>
				</cflayoutarea>
				<cflayoutarea title="#getstring('password')#">
					<table cellspacing="4" class="text">
						<tr>
							<th valign="top">#getstring('new')# #getstring('password')#:</th>
							<td><cfinput type="password" name="password" size="30" /></td>
						</tr>
						<tr>
							<th valign="top">#getstring('retype')# #getstring('new')# #getstring('password')#:</th>
							<td>
								<cfinput type="password" name="password_confirmation" id="password_confirmation" size="30" />
								<br /><small class="error" id="nomatch" style="display:none;">Passwords don't match</small>
							</td>
						</tr>
					</table>
				</cflayoutarea>
				<cflayoutarea title="#getstring('im')#">
					<table cellspacing="4" class="text">
						<tr>
							<th valign="top">#getstring('googletalk')# #getstring('account')#:</th>
							<td>
								<cfinput type="text" name="im" value="#myprofile.im#" size="15" maxlength="30" typeahead="no" />
							</td>
						</tr>
					</table>
				</cflayoutarea>
				<cflayoutarea title="#getstring('picture')#">
					<table cellspacing="4" class="text">
						<tr>
							<th><cfif fileexists('#request.pathmapping#/photos/#myprofile.photo#')><img alt="" src="/photos/#myprofile.photo#" border="1" /></cfif>
							</th>
							<td>
								<input name="photo" size="30" type="file" />
								<p><small>#getstring('resize48message')#</small></p>
							</td>
						</tr>
						<tr>
							<th></th>
							<td>
								<input type="checkbox" name="deletephoto" />#getstring('delete')# #getstring('current')#
							</td>
						</tr>
					</table>
				</cflayoutarea>
			</cflayout>
			<cfoutput><input type="submit" name="saveuser" value="#getstring('save')#" /></cfoutput>
		</cfform>
	</cfoutput>
<cfinclude template="/#request.mapping#/include/footer.cfm">