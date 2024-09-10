<!-- 
	Group 5
	Make a Reservation
	09/09/24
 -->
 <!-- Here a logged in user account can place a reservation for the lodge -->

<%@page language="java" contentType="text/html"%>
<%@page import="java.sql.*"%>
<html>
<head>
	<title>Place a reservation</title>
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
	<main class="tight">
		
		<h2>Place a reservation</h2>
		
		<form method="POST" action="reserve.jsp">
		
			<label for="full-name">Full Name</label>
			<input id="full-name" type="text" name="name" maxlength="255" required>
			
			<label for="room-size">Room</label>
			<select id="room-size" name="roomSize">
				<option value="2FB">Two Full Beds</option>
				<option value="QU">Queen</option>
				<option value="2QU">Two Queen Beds</option>
				<option value="KG">King</option>
			</select>
			
			<label for="guests"># of Guests</label>
			<input id="guests" type="number" name="guests" min="1" max="5" required>
			
			<label for="check-in-date">Check In Date</label>
			<input id="check-in-date" type="date" name="inDate" required>
			
			<label for="check-out-date">Check Out Date</label>
			<input id="check-out-date" type="date" name="outDate" required>
			
			<label><span id="nights">#</span> nights</label>
			
			<label>Estimate: <span id="estimate">~</span></label>
			
			<input id="nightsPost" type="hidden" name="nights">
			<input id="totalPost" type="hidden" name="total">
			
			<span class="information small">
				Room recommendations
			</span>
			
			<button id="continue" class="login-button" type="submit">Continue</button>
		
		</form>
		
		<!--  Update the dates, the # of nights, and the total estimate in real time -->
		<script type="text/javascript" defer>
			
			const guests = document.getElementById("guests");
			const checkIn = document.getElementById("check-in-date");
			const checkOut = document.getElementById("check-out-date");
			
			const nightsDisplay = document.getElementById("nights");
			const estimateDisplay = document.getElementById("estimate");
		
			const continueBtn = document.getElementById("continue");
			
			const minPrice = 115, maxPrice = 150;
			const guestUpchargeThreshold = 2;
			
			// On every change of the form, compare the dates and update the estimate
			const update = () =>
			{
				// Compare the two dates to find out the time between
				const checkInDate = new Date(checkIn.value);
				const checkOutDate = new Date(checkOut.value);
				
				const diff = new Date(checkOutDate - checkInDate);
				
				// Convert the difference in date to a number of nights
				const nights = diff.valueOf() / (1000 * 60 * 60 * 24);
				const isValidNights = nights && !Number.isNaN(nights) && nights > 0;
				
				// Update the display for the number of nights if available
				nightsDisplay.innerText = isValidNights ? nights : "#";
				
				document.getElementById("nightsPost").value = nights;
				
				const isValidGuests = guests.value && guests.value > 0;
				
				// Check if the number of guests has been inserted
				if(isValidNights && isValidGuests)
				{
					const guestsNum = guests.value;
					
					const rate = guestsNum <= guestUpchargeThreshold ? minPrice : maxPrice;
					
					const price = nights * rate;
					
					estimateDisplay.innerText = "$" + price;
					
					document.getElementById("totalPost").value = price;
				}
			 	else
			 	{
					estimateDisplay.innerText = "";
				}
				
				
				// Determine whether continue reservation button is ready
				// Number of guests must be valid and nights
				continueBtn.disabled = !isValidGuests || !isValidNights;
			};
			
			guests.onchange = update;
			checkIn.onchange = update;
			checkOut.onchange = update;
			
			window.onload = update;
		
		</script>
		
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
		
		String inDate = request.getParameter("inDate");
		String outDate = request.getParameter("outDate");
		
		// Retrieve duplicate reservations from the same customer using their id
		// By comparing dates that overlap
		// Dates that overlap IS WHEN a check in date occurs during an existing reservation OR a check OUT date occurs during a new reservation
		ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as recordCount FROM reservations WHERE customerId = " + id + " AND (\"" + inDate + "\" >= checkInDate AND checkOutDate >= \"" + inDate + "\") OR (\"" + inDate + "\" <= checkInDate AND \"" + outDate + "\" >= checkOutDate)");
		
		// Fetch count
		rs.next();
		int count = rs.getInt("recordCount");
		rs.close();
		
		// If count is > than 0 then a duplicate reservation exists 
		// Send the user an error message
		if(count >= 1)
		{
			out.println("<span class='message'>The reservation you are trying to place conflicts with an existing reservation.<br>Check-in on " + inDate + ".<br>Check-out on " + outDate + ".<br><a class='link' href='reserve.jsp'>Return</a></span>");
			return;
		}
		
		try
		{
			// No duplicates, send the user to the summary page
			if(count <= 0)
			{
				// In order to transfer the reservation data, interpolate the reservation details into the GET URL
				// i.e. request parameters
				
				//stmt.executeUpdate("INSERT INTO reservations (customerId, roomSize, guests, total, checkInDate, checkOutDate) VALUES (" + id + ", \"" + request.getParameter("roomSize") + "\", " + request.getParameter("guests") + ", " + request.getParameter("total") + ", \"" + inDate + "\", \"" + outDate + "\")");
				
				//out.println("Reservation placed");
			}
		}
		catch (Exception e)
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