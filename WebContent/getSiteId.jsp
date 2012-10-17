<%@ page language="java" import="java.sql.*"%>
<%@page import="java.io.InputStream" %>
<%@page import="java.net.*" %>

<%
	String DRIVER = "org.gjt.mm.mysql.Driver";
	Class.forName(DRIVER).newInstance();

	Connection con = null;
	ResultSet rst = null;
	Statement stmt = null;
	String db_name = "cascade_dev";
	String url = (String)request.getRequestURL().toString();
	//out.println(url);	
 	if(url.indexOf("wcms-test")>0){
		db_name="casacde_tst";
	}

	try {
		
	        String db_url = "jdbc:mysql://apm-dev-mysql.ucsc.edu/" + db_name + "?user=wcms_admin&password=cHoK1at3";

		int i = 1;
		con = DriverManager.getConnection(db_url);
		stmt = con.createStatement();
		rst = stmt.executeQuery("select id from cxml_site where name ='"
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


