<!-- 
	Group 5
	Populate Tables
	09/01/24
 -->
 <!-- Populate the two tables with test entries if possible -->

<%@page language="java" contentType="text/html"%>
<%@page import="java.sql.*"%>
<html><head><title>Populate Tables</title></head><body>
<%
	Class.forName("com.mysql.cj.jdbc.Driver"); // Import driver
	
	// Use information from web.xml
	String dbName = application.getInitParameter("dbUser"),
			dbPass = application.getInitParameter("dbPass");
	
	out.println("<h2>Moffat Bay - Populate Tables</h2>");
	
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
	
	// Clear the tables first to allow for sample entries
	try
	{
		stmt.executeUpdate("TRUNCATE TABLE reservations");
		out.println("<b>Reservations<b> table cleared.");
	}
	catch (SQLException e)
	{
		out.println("<b>Reservations<b> truncation failed.");
	}
	
	try
	{
		stmt.executeUpdate("SET FOREIGN_KEY_CHECKS = 0");
		stmt.executeUpdate("TRUNCATE TABLE accounts");
		stmt.executeUpdate("SET FOREIGN_KEY_CHECKS = 1");
		out.println("<b>Accounts<b> table cleared.");
	}
	catch (SQLException e)
	{
		out.println("<b>Accounts<b> truncation failed.");
		out.println(e);
	}
	
	// Fill the tables
	try
	{
		stmt.executeUpdate("INSERT INTO accounts (firstName, lastName, email, telephone, password) VALUES (\"John\", \"Doe\", \"johndoe21@gmail.com\", \"6147008910\", \"jd7000!!\")");
		stmt.executeUpdate("INSERT INTO accounts (firstName, lastName, email, telephone, password) VALUES (\"Marcus\", \"Walker\", \"mwalker2001@gmail.com\", \"6149826464\", \"ILuvWaffles4@\")");
		stmt.executeUpdate("INSERT INTO accounts (firstName, lastName, email, telephone, password) VALUES (\"Lucy\", \"Alexander\", \"lucymusic@outlook.com\", \"7408114300\", \"Musicals20$$\")");
		out.println("<b>Accounts<b> table successfully populated.");
		
	}
	catch (SQLException e)
	{
		out.println("<b>Accounts<b> table population failed.");
		out.println(e);
	}
	
	try
	{
		// stmt.executeUpdate("CREATE TABLE reservations (reservationId INT NOT NULL PRIMARY KEY AUTO_INCREMENT, customerId INTEGER NOT NULL, roomSize VARCHAR(3) NOT NULL, guests INTEGER NOT NULL, total REAL NOT NULL, checkInDate DATE NOT NULL, checkOutDate DATE NOT NULL, FOREIGN KEY (customerId) REFERENCES accounts(customerId))");
		stmt.executeUpdate("INSERT INTO reservations (customerId, roomSize, guests, total, checkInDate, checkOutDate) VALUES (1, \"KG\", 1, 115.0, \"2024-06-05\", \"2024-06-06\")");
		stmt.executeUpdate("INSERT INTO reservations (customerId, roomSize, guests, total, checkInDate, checkOutDate) VALUES (2, \"2FB\", 3, 300.0, \"2024-07-15\", \"2024-07-17\")");
		stmt.executeUpdate("INSERT INTO reservations (customerId, roomSize, guests, total, checkInDate, checkOutDate) VALUES (3, \"QU\", 2, 345.0, \"2024-08-21\", \"2024-08-24\")");
		out.println("<b>Reservations<b> table successfully populated.");
		
	}
	catch (Exception e)
	{
		out.println("<b>Reservations<b> table population failed.");
		out.println(e);
	}
	
	
	stmt.close();
	conn.close();
	
	
%>
</body></html>