<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<title>Send email to users</title>
</head>
<body bgcolor=white>
	<h2>Send email to user groups</h2>
	<form method="POST" action="email_users.jsp">
		<select id="lstGroupName" name="slctGroup">
			<option value="all">All</option>
			<%
				String DRIVER = "org.gjt.mm.mysql.Driver";
				Class.forName(DRIVER).newInstance();

				Connection con = null;
				ResultSet rst = null;
				Statement stmt = null;

				try {
					String url = "jdbc:mysql://apm-dev-mysql.ucsc.edu/cascade_dev?user=wcms_user&password=cHoK1at3";

					int i = 1;
					con = DriverManager.getConnection(url);
					stmt = con.createStatement();
					java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
							"yyyy-MM-dd");
					String dates = formatter.format(new java.util.Date());
					String TIER = "wcms-dev";
					//GET DATA
					String sql = "select cxml_group.name from cxml_group";
					rst = stmt.executeQuery(sql);
					while (rst.next()) {
			%><option value="<%out.print(rst.getString(1));%>">
				<%
					out.print(rst.getString(1));
				%>
			</option>
			<%
				} 
				} catch (Exception ex) {
					out.println(ex.getMessage());
				}
			%>
		</select> <br /> <label>Subject:</label><br /> <input type="text" size="120"
			id="txtSubject" name="txtSubject"><br /> <label>Message:</label><br />
		<textarea rows="35" cols="100" id="txtMessage" name="txtMessage"></textarea>
		<br /> <input type="submit" value="Send" />
	</form>
</body>
</html>
