// JavaScript Document

if(typeof(chefai) == 'undefined') {var chefai = {}};

// keepalive

chefai.heartbeat = function() {
	// in order to work a cfajaxproxy has to be defined before calling this js
	var mykeepalive = new jskeepalive();
	mykeepalive.setCallbackHandler(chefai.heartbeatResponse);
	mykeepalive.setErrorHandler(chefai.myErrorHandler);
	mykeepalive.gettick();
};
		
chefai.keepAlive = {
	aliveID : false,
	refresh : 300000,

	start : function() {
		chefai.keepAlive.aliveID = setInterval(chefai.heartbeat, chefai.keepAlive.refresh);		
	},
	
	stop : function() {
		clearInterval(chefai.keepAlive.aliveID);
		chefai.keepAlive.aliveID = false;	
	}	
}

chefai.myErrorHandler = function(statusCode, statusMsg)
	{
		alert('Status: ' + statusCode + ', ' + statusMsg);
	}
	
chefai.heartbeatResponse = function(){};


