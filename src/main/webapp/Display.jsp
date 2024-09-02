<!-- 
	Group 5
	Display Tables
	09/01/24
 -->
 <!-- Display the contents of acocunts and reservations -->

<%@page language="java" contentType="text/html"%>
<%@page import="java.sql.*"%>
<html><head><title>Display Tables</title></head><body>
<%
	Class.forName("com.mysql.cj.jdbc.Driver"); // Import driver
	
	// Use information from web.xml
	String dbName = application.getInitParameter("dbUser"),
			dbPass = application.getInitParameter("dbPass");
	
	out.println("<h2>Moffat Bay Accounts & Reservations</h2>");
	
	// Make connection
	Connection conn = null;
	Statement stmt = null;
	try
	{
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mblodgeg5", dbName, dbPass);
		stmt = conn.createStatement();
	} catch (Exception e)
	{
		out.println("<p>Error connecting to the database.</p>");
	}
	
	// Display the contents of both tables
	try
	{
		ResultSet rs = stmt.executeQuery("SELECT * FROM accounts"); // SQL query
		%><table border= "1" style="margin-bottom: 2rem;"><%
			ResultSetMetaData resMetaData = rs.getMetaData();
			int nCols = resMetaData.getColumnCount();
		%><tr><%
			for (int kCol = 1; kCol <= nCols; kCol++) {
				out.print("<td><b>" + resMetaData.getColumnName(kCol) + "</b></td>");
			}
		%></tr><%
			while (rs.next()) {
		%><tr><%
				for (int kCol = 1; kCol <= nCols; kCol++) {
					out.print("<td>" + rs.getString(kCol) + "</td>");
				}
		%></tr><%
			}
		%></table><%
	}
	catch (SQLException e)
	{
		out.println("Displaying <b>Accounts</b> failed.");
	}
	
	try
	{
		ResultSet rs = stmt.executeQuery("SELECT * FROM reservations"); // SQL query
		%><table border= "1"><%
			ResultSetMetaData resMetaData = rs.getMetaData();
			int nCols = resMetaData.getColumnCount();
		%><tr><%
			for (int kCol = 1; kCol <= nCols; kCol++) {
				out.print("<td><b>" + resMetaData.getColumnName(kCol) +
			"</b></td>");
			}
		%></tr><%
			while (rs.next()) {
		%><tr><%
				for (int kCol = 1; kCol <= nCols; kCol++) {
					out.print("<td>" + rs.getString(kCol) + "</td>");
				}
		%></tr><%
			}
		%></table><%
	}
	catch (SQLException e)
	{
		out.println("Displaying <b>Reservations</b> failed.");
		out.println(e);
	}
	
	stmt.close();
	conn.close();
	
	
%>
</body></html>