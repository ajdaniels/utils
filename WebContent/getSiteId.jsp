<%@ page language="java" import="java.sql.*"%>
<%
	String DRIVER = "org.gjt.mm.mysql.Driver";
	Class.forName(DRIVER).newInstance();

	Connection con = null;
	ResultSet rst = null;
	Statement stmt = null;

	/*

	 test
	 username="wcms_admin" 
	 password="cHoK1at3"
	 driverClassName="com.mysql.jdbc.Driver" 
	 url="jdbc:mysql://apm-dev-mysql.ucsc.edu:3306/cascade_dev
	 username="wcms_admin"
	 password="cHoK1at3"
	 driverClassName="com.mysql.jdbc.Driver"
	 url="jdbc:mysql://apm-dev-mysql.ucsc.edu/cascade_dev?useUnicode=true&amp;characterEncoding=UTF-8"
	
	 */
	try {
		String url = "jdbc:mysql://apm-dev-mysql.ucsc.edu/cascade_tst?user=wcms_admin&password=cHoK1at3";

		int i = 1;
		con = DriverManager.getConnection(url);
		stmt = con.createStatement();
		rst = stmt
				.executeQuery("select id from cxml_site where name ='"
						+ request.getParameter("siteName") + "'");
		while (rst.next()) {
%>
<%=rst.getString(1)%>
<%
	}

		rst.close();
		stmt.close();
		con.close();
	} catch (Exception e) {
%>
<%=e.getMessage()%>
<%
	System.out.println(e.getMessage());
	}
%>


