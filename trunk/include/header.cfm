<cfsilent>
	<cfif cgi.script_name contains 'index.cfm'>
		<cfajaxproxy cfc="cfc.keepalive" jsclassname="jskeepalive">
		<cfscript>
			AjaxOnLoad('chefai.keepAlive.start');
		</cfscript>
	</cfif>
	<cfajaxproxy cfc="cfc.user" jsclassname="user">
</cfsilent>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>CheFai.it</title>
		<script language="javascript" src="/js/chefai.js"></script>
		<script language="javascript">
			var verifyUserName = function(name)
				{
					var myuser = new user();
					
					myuser.setCallbackHandler(verifyUsernameCallback);
					myuser.setErrorHandler(myErrorHandler);
					myuser.checkavailability(name);
				}
			var verifyUsernameCallback = function(result)
				{
					document.getElementById('verifyUserNameDiv').innerHTML=result;
					document.getElementById('verifyUserNameDiv').style.display = 'inline';
				}
			myErrorHandler = function(statusCode, statusMsg)
				{
					alert('Status: ' + statusCode + ', ' + statusMsg);
				}
			var checkPw=function () 
				{
					var result = true;
					if (document.getElementById("password_confirmation").value != document.getElementById("password").value)
						{
							document.getElementById("nomatch").style.display = "inline";
							result = false;
						}
					else
						{
							document.getElementById("nomatch").style.display = "none";
						}
					return result;
				}

			var updateStatusTextCharCounter = function(myid,myvalue) 
				{
					var myArea = document.getElementById(myid);
					if (140 - myvalue.length >= 0)
						{
							myArea.innerHTML = 140 - myvalue.length;
							if (myvalue.length >= 135)
								{
									myArea.style.color = "#d40d12";
								} 
							else if (myvalue.length > 120) 
								{
									myArea.style.color = "#5c0002";
								}
							else
								{
									myArea.style.color = "#cccccc";
								}
						}
					else
						{
							myArea.innerHTML = 0;
						}
				};

		</script>
	</head>
	<body>