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

	/*
	 username="wcms_admin"
	 password="cHoK1at3"
	 driverClassName="com.mysql.jdbc.Driver"
	 url="jdbc:mysql://apm-prod-mysql:3306/cascade_stg?use
	 */
	try {
		String url = "jdbc:mysql://apm-dev-mysql.ucsc.edu/cascade_dev?user=wcms_user&password=cHoK1at3";

		int i = 1;
		con = DriverManager.getConnection(url);
		stmt = con.createStatement();
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				"yyyy-MM-dd");
		String dates = formatter.format(new java.util.Date());
		String TIER = "wcms-dev";
		String filename = "/opt/app/HannonHill/cascade/tomcat/webapps/utils/"
				+ TIER + "-users-" + dates + ".csv";
		FileWriter writer = new FileWriter(filename);
		writer.append("GroupName,UserName,Email,FullName,Default Group,Enabled\n");
		//GET DATA
		String sql = "select cxml_group_membership.groupName,cxml_group_membership.userName,cxml_user.email,cxml_user.fullName,";
		sql += "cxml_user.defaultGroup,cxml_user.isEnabled from cxml_group_membership join cxml_user on cxml_user.userName = cxml_group_membership.userName order by groupName;";
		rst = stmt.executeQuery(sql);
		while (rst.next()) {
			writer.append(rst.getString(1));
			writer.append(',');
			writer.append(rst.getString(2));
			writer.append(',');
			writer.append(rst.getString(3));
			writer.append(',');
			writer.append(rst.getString(4));
			writer.append(',');
			writer.append(rst.getString(5));
			writer.append(',');
			String enabled = rst.getString(6);
			writer.append(enabled.equals("1") ? "Yes" : "No");
			writer.append('\n');
			writer.flush();
		}
		writer.close();

		String result;
		// Recipient's email ID needs to be mentioned.
		String to = "andre777@ucsc.edu";

		// Sender's email ID needs to be mentioned
		String from = "webtools@ucsc.edu";

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
			// Set To: header field of the header.
			message.addRecipient(Message.RecipientType.TO,
					new InternetAddress(to));
			// Set Subject: header field
			// Now set the actual message
			message.setText("This is actual message");
			message.setSubject("Users - wcms-dev");

			// create the message part
			MimeBodyPart messageBodyPart = new MimeBodyPart();

			//messageBodyPart.setFileName (TIER + "-users-" + dates + ".csv");

			//fill message
			//// messageBodyPart.setText("Groups from " + TIER);

			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBodyPart);

			// Part two is attachment
			messageBodyPart = new MimeBodyPart();
			DataSource source = new FileDataSource(filename);
			messageBodyPart.setFileName(TIER + "-users-" + dates
					+ ".csv");
			messageBodyPart.setDataHandler(new DataHandler(source));
			//messageBodyPart.setFileName();
			multipart.addBodyPart(messageBodyPart);

			// Put parts in message
			message.setContent(multipart);

			// Send message
			Transport.send(message);
			result = "Sent message successfully....";
		} catch (MessagingException mex) {
			mex.printStackTrace();
			//result = "Error: unable to send message....";
		}
	} catch (Exception ex) {
		out.println(ex.getMessage());
	}
%>
<html>
<head>
<title>Send Email using JSP</title>
</head>
<body>
	<center>
		<h1>Send Email using JSP</h1>
	</center>
	<p align="center">
		<%
			//out.println("Result: " + result + "\n");
		%>
	</p>
</body>
</html>
