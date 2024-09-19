<!-- 
	Group 5
	Reservation Lookup
	09/18/24
 -->
 <!-- Display all reservations for the logged-in user -->

<%@page language="java" contentType="text/html"%>
<%@page import="java.sql.*"%>
<html>
<head>
	<title>Reservation Lookup</title>
	<link rel="stylesheet" href="styles.css"/>
	
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
	<link rel="manifest" href="site.webmanifest">
</head>
<body>

	<!-- Included header  -->
	<jsp:include page="header.jsp"/>
	
	<% 
	/* Immediately verify the user session */
	Integer id = (Integer)session.getAttribute("id");
	
	// This user is not currently logged in
	if(id == null)
	{
		// Log In button included
		out.println("<span class='message'>You must be logged in to do that.<br><a class='link' href='login.jsp'>Log in</a></span>");
		return;
	}
	%>
	
	<main>
		<h2>Your Reservations</h2>
		
		<%
		Class.forName("com.mysql.cj.jdbc.Driver"); // Import driver
		
		// Use information from web.xml
		String dbName = application.getInitParameter("dbUser"),
				dbPass = application.getInitParameter("dbPass");
		
		// Make connection
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try
		{
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mblodgeg5", dbName, dbPass);
			stmt = conn.createStatement();
			
			// Query to get all reservations for the logged-in user
			String query = "SELECT * FROM reservations WHERE customerId = " + id;
			rs = stmt.executeQuery(query);
			
			if(rs.next()) {
				%>
				<table class="reservation-table">
					<tr>
						<th>Reservation ID</th>
						<th>Full Name</th>
						<th>Room Size</th>
						<th>Number of Guests</th>
						<th>Check-in Date</th>
						<th>Check-out Date</th>
						<th>Total Cost</th>
					</tr>
				<%
				do {
					%>
					<tr>
						<td><%= rs.getInt("reservationId") %></td>
						<td><%= rs.getString("fullName") %></td>
						<td><%= rs.getString("roomSize") %></td>
						<td><%= rs.getInt("guests") %></td>
						<td><%= rs.getString("checkInDate") %></td>
						<td><%= rs.getString("checkOutDate") %></td>
						<td>$<%= String.format("%.2f", rs.getDouble("total")) %></td>
					</tr>
					<%
				} while (rs.next());
				%>
				</table>
				<%
			} else {
				out.println("<span class='message'>No reservations found.</span>");
			}
			
		} catch (Exception e) {
			out.println("<h1>Error retrieving reservation details.</h1>");
		} finally {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		}
		%>
	</main>
	
</body>
</html>
