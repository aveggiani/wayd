<cfsilent>
	<cfif isdefined('form.status')>
		<cfscript>
			application.waydObj.update(listgetat(getauthuser(),1,'|'),form.status);
		</cfscript>
	</cfif>
</cfsilent>
<cfoutput>
	<h1>#getstring('whatareyoudoing')#</h1>
	<cfform method="post">
		<div id="waydinput">
			<textarea cols="40" rows="3" id="status" name="status" onkeypress="return (event.which == 8) || (this.value.length &lt; 140);" onkeyup="javascript:updateStatusTextCharCounter('status-field-char-counter',this.value)" rows="2"></textarea>
			<strong id="status-field-char-counter">140</strong>
			<input id="submit" name="commit" type="submit" value="aggiorna" style="float:right;" />
		</div>
	</cfform>
	<div id="waydrecent">
		<h1>#getstring('whathaveyoudone')#</h1>
		<cfdiv id="waydrecentlist" bind="url:/ajax/user_whativedone.cfm"></cfdiv>
	</div>
</cfoutput>
