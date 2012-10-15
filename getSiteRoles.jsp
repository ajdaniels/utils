<%@ page language="java" import="java.sql.*"%>
<%
String DRIVER = "org.gjt.mm.mysql.Driver";
Class.forName(DRIVER).newInstance();


Connection con=null;
ResultSet rst=null;
Statement stmt=null;

/*
username="wcms_admin" 
                password="cHoK1at3"
                driverClassName="com.mysql.jdbc.Driver" 
                url="jdbc:mysql://apm-prod-mysql:3306/cascade_stg?use
*/
try{
String url="jdbc:mysql://apm-dev-mysql.ucsc.edu/cascade_dev?user=wcms_user&password=cHoK1at3";

int i=1;
con=DriverManager.getConnection(url);
stmt=con.createStatement();
%>

<siteRoles>
<users>
<%
rst=stmt.executeQuery("Select cr.roleName,crus.roleId, crus.userName from cxml_role_user_site_link crus join cxml_roles cr on cr.id = crus.roleId where crus.siteId='" + request.getParameter("siteId") +"'");
while(rst.next())
{
%>
        <%= "<user><roleName>" + rst.getString(1) +"</roleName><roleId>" + rst.getString(2) +"</roleId><userName>" + rst.getString(3) + "</userName></user>" %>
<%
}
%>
</users>
<groups>
<%
rst=stmt.executeQuery("Select cr.roleName,crus.roleId, crus.groupName from cxml_role_group_site_link crus join cxml_roles cr on cr.id = crus.roleId where crus.siteId='" + request.getParameter("siteId") +"'");
while(rst.next())
{
%>
        <%= "<group><roleName>" + rst.getString(1) +"</roleName><roleId>" + rst.getString(2) +"</roleId><groupName>" + rst.getString(3) + "</groupName></group>" %>
<%
}
%>
</groups>
<%

rst.close();
stmt.close();
con.close();
}
catch(Exception e)
{
%>
<%= e.getMessage() %>
<%
}
%>

</siteRoles>


