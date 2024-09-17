<!-- 
	Group 5
	Reservation Summary
	09/11/24
 -->
 <!-- Display a reservation confirmation to the logged in user -->

<%@page language="java" contentType="text/html"%>
<%@page import="java.sql.*"%>
<html>
<head>
	<title>Confirm your reservation</title>
	<link rel="stylesheet" href="styles.css"/>
</head>
<body>

	<!-- Included header  -->
	<jsp:include page="header.jsp"/>
	
	<% 
	
	/* Immediately verify the user session */
	Integer id = (Integer)session.getAttribute("id");
	
	// This user is not currently logged in
	// Show error message
	if(id == null)
	{
		// Log In button included
		out.println("<span class='message'>You must be logged in to do that.<br><a class='link' href='login.jsp'>Log in</a></span>");
		
		return;
	}
	
	if(request.getMethod().equals("GET"))
	{
	%>
	<main>
		
		<h2>Review your reservation</h2>
		
		<form method="POST" action="reserve_confirm.jsp">
		
			<input type="hidden" name="customerId" value="<%= id %>">
		
			<label>Full Name: <span id="full-name"><%= request.getParameter("fullName") %></span></label>
			<input type="hidden" name="fullName" value="<%= request.getParameter("fullName") %>">
			
			<label>Room Size: <span id="room-size"><%= request.getParameter("roomSize") %></span></label>
			<input type="hidden" name="roomSize" value="<%= request.getParameter("roomSize") %>">
			
			<label># of Guests: <span id="guests"><%= request.getParameter("guests") %></span></label>
			<input type="hidden" name="guests" value="<%= request.getParameter("guests") %>">
			
			<label>Check-in/Check-out: <span id="dates"><%= request.getParameter("checkInDate") + " => " + request.getParameter("checkOutDate") %></span></label>
			<input type="hidden" name="checkInDate" value="<%= request.getParameter("checkInDate") %>">
			<input type="hidden" name="checkOutDate" value="<%= request.getParameter("checkOutDate") %>">
			
			<label>Estimated Total: <span id="estimate">$<%= request.getParameter("total") %></span></label>
			<input type="hidden" name="total" value="<%= request.getParameter("total") %>">
			
			<span class="information small">
				Please ensure the above details are correct before placing your reservation
			</span>
			
			<button id="reserve" class="login-button" type="submit">RESERVE</button>
		
		</form>
		
	</main>
	
	<%
	}
	else if(request.getMethod().equals("POST"))
	{
		// Form was submitted, send the data to the database
		Class.forName("com.mysql.cj.jdbc.Driver"); // Import driver
		
		// Use information from web.xml
		String dbName = application.getInitParameter("dbUser"),
				dbPass = application.getInitParameter("dbPass");
		
		// Make connection
		Connection conn = null;
		Statement stmt = null;
		try
		{
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mblodgeg5", dbName, dbPass);
			stmt = conn.createStatement();
		} catch (Exception e)
		{
			out.println("<h1>Error connecting to the database.</h1>");
		}
		
		// TODO: Validate all information again
		// - Room size is valid
		// - Number of guests is valid
		// - No overlapping reservations
		// - Check in date is valid
		// - Reservation length is valid
		
		try
		{
			// Create bean using parameters and add to database 
			%><jsp:useBean id="newReservation" class="ReservationBean.ReservationBean"><jsp:setProperty name="newReservation" property="*"/></jsp:useBean><%
			
			// Insert record into database
			stmt.executeUpdate("INSERT INTO reservations (customerId, roomSize, guests, checkInDate, checkOutDate, total) VALUES (" + newReservation.getCustomerId() + ", \"" + newReservation.getRoomSize() + "\", " + newReservation.getGuests() + ", \"" + newReservation.getCheckInDate() + "\", \"" + newReservation.getCheckOutDate() + "\", " + newReservation.getTotal() + ")");
			
			// Post success message
			out.println("<span class='message'>Reservation successfully placed.<br><a class='link' href='reservation_lookup.jsp'>Look up your reservation</a></span>");
		}
		catch (SQLException e)
		{
			out.println("<p>Error inserting entry into the database.</p>");
			out.println("<p>" + e + "</p>");
		}
		finally {
			stmt.close();
			conn.close();
		}
		
	}
	%>
	
</body>
</html>