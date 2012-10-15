<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	String DRIVER = "org.gjt.mm.mysql.Driver";
	Class.forName(DRIVER).newInstance();

	Connection con = null;
	ResultSet rst = null;
	Statement stmt = null;

	String result;
	// Recipient's email ID needs to be mentioned.
	String to = "webtools@ucsc.edu";

	// Sender's email ID needs to be mentioned
	String from = request.getParameter("txtFrom");

	// Assuming you are sending email from localhost
	String host = "smtp.ucsc.edu";

	// Get system properties object
	Properties properties = System.getProperties();

	// Setup mail server
	properties.setProperty("mail.smtp.host", host);

	// Get the default Session object.
	Session mailSession = Session.getDefaultInstance(properties);

	try {
		// Create a default MimeMessage object.
		MimeMessage message = new MimeMessage(mailSession);
		// Set From: header field of the header.
		message.setFrom(new InternetAddress(from));

		String url = "jdbc:mysql://apm-dev-mysql.ucsc.edu/cascade_dev?user=wcms_user&password=cHoK1at3";

		int i = 1;
		con = DriverManager.getConnection(url);
		stmt = con.createStatement();
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				"yyyy-MM-dd");
		String dates = formatter.format(new java.util.Date());
		String TIER = "wcms-dev";
		//GET DATA
		String sql = "select cxml_user.email from cxml_group_membership";
		sql += " join cxml_user on cxml_user.userName = cxml_group_membership.userName";
		sql += " Where groupName = '"
				+ request.getParameter("lstGroupName")
				+ "' order by groupName;";
		rst = stmt.executeQuery(sql);
		while (rst.next()) {
			// add To: header field of the header.
			/* message.addRecipient(Message.RecipientType.TO,
					new InternetAddress(rst.getString(1))); */
		}
		message.addRecipient(Message.RecipientType.TO,
				new InternetAddress("andre777@ucsc.edu"));
		// Set Subject: header field
		// Now set the actual message
		message.setText(request.getParameter("txtMessage"));
		message.setSubject(request.getParameter("txtFrom"));

		// Send message
		Transport.send(message);
		result = "Sent message successfully....";

	}

	catch (MessagingException mex) {
		mex.printStackTrace();
		result = "Error: unable to send message....";
	} catch (Exception ex) {
		out.println(ex.getMessage());
		result = "Error: unable to send message....";
		}
%>
<html>
<head>
<title>Sending email to <% out.println(request.getParameter("lstGroupName"));%></title>
</head>
<body>
	<h1>
		Email sent to
		<%
		out.println(request.getParameter("lstGroupName"));
	%>
	</h1>
	<p align="center">
		<%
			out.println("Result: " + result + "\n");
		%>
	</p>
</body>
</html>
