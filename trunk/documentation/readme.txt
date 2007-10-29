To install this application simply:

- 	create a 'wayd' datasource in the Coldfusion Administrator using the Embedded Derby database and point the datasource
	to the database/derby folder in the root folder of this application
- 	in order to got Google Talk integration create a XMPP gateway instance in the administrator, call it 'chefai' (you can change
	this value trough the config/config.ini file) and then put in the gateway/googletalk.cfg file the username and password of your
	googletalk contact.
-	in the pdf folder you can find a registerPdf.pdf file, it's a demo PDF Form for Wayd registration, it can be edited with Acrobat;
	in the submitted folder will be uploaded the PDF Form submitted by users wich will register using the PDF Form. This feature its'
	only suitable for demo purpose as, at the moment, no client site validation for email and username is provided.
-	in the flex folder you can find a Data Service example using gateway, at this time the code is provided 'as is'.	