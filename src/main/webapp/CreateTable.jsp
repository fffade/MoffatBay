<%@page language="java" contentType="text/html"%>
<%@page import="java.sql.*"%>
<html>
<head><title>Create Table</title></head>
<body>
<%
	Class.forName("com.mysql.cj.jdbc.Driver"); // Import driver

	// Use information from web.xml
	String dbName = application.getInitParameter("dbUser"),
			dbPass = application.getInitParameter("dbPass");
	
	out.println("<h2>Moffat Bay - Create Tables</h2>");
	
	// Make connection
	Connection conn = null;
	Statement stmt = null;
	try
	{
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mblodgeG5", dbName, dbPass);
		stmt = conn.createStatement();
	} catch (Exception e)
	{
		out.println("<p>Error connecting to the database: " + e.getMessage() + "</p>");
	}

	// Proceed only if connection is successful
	if (stmt != null) {
		// Drop the reservations table first because of the foreign key connection
		try
		{
			stmt.executeUpdate("DROP TABLE reservations");
			out.println("<b>Reservations</b> table dropped.");
		}
		catch (SQLException e)
		{
			out.println("<b>Reservations</b> table does not already exist.");
		}
		
		// Drop the existing table
		try
		{
			stmt.executeUpdate("DROP TABLE accounts");
			out.println("<b>Accounts</b> table dropped.");
		}
		catch (SQLException e)
		{
			out.println("<b>Accounts</b> table does not already exist.");
		}
		
		// Create the new tables
		try
		{
			stmt.executeUpdate("CREATE TABLE accounts (customerId INT NOT NULL PRIMARY KEY AUTO_INCREMENT, firstName VARCHAR(100) NOT NULL, lastName VARCHAR(100) NOT NULL, email VARCHAR(255) NOT NULL, telephone CHAR(10) NOT NULL, password VARCHAR(255) NOT NULL)");
			out.println("<b>Accounts</b> table successfully created.");
			
		}
		catch (SQLException e)
		{
			out.println("<b>Accounts</b> table creation failed.");
			out.println(e);
		}
		
		try
		{
			stmt.executeUpdate("CREATE TABLE reservations (reservationId INT NOT NULL PRIMARY KEY AUTO_INCREMENT, customerId INTEGER NOT NULL, roomSize VARCHAR(3) NOT NULL, guests INTEGER NOT NULL, total REAL NOT NULL, checkInDate DATE NOT NULL, checkOutDate DATE NOT NULL, FOREIGN KEY (customerId) REFERENCES accounts(customerId))");
			out.println("<b>Reservations</b> table successfully created.");
			
		}
		catch (SQLException e)
		{
			out.println("<b>Reservations</b> table creation failed.");
			out.println(e);
		}
		
		
		stmt.close();
		conn.close();
	} else {
		out.println("<p>Unable to create statement as connection was not successful.</p>");
	}
%>
</body>
</html>
