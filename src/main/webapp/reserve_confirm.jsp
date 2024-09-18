<%@page language="java" contentType="text/html"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.time.*" %>
<%@page import="java.time.format.DateTimeFormatter" %>
<%@page import="java.time.temporal.ChronoUnit" %>
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
    if (id == null) {
        // Log In button included
        out.println("<span class='message'>You must be logged in to do that.<br><a class='link' href='login.jsp'>Log in</a></span>");
        return;
    }

    if (request.getMethod().equals("GET")) {
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
        
        <!-- Cancel button to redirect back to reserve.jsp -->
        <form method="GET" action="reserve.jsp">
            <button class="link" type="submit">CANCEL</button>
        </form>
    </main>
    
    <%
    } else if (request.getMethod().equals("POST")) {
        // Form was submitted, send the data to the database
        Class.forName("com.mysql.cj.jdbc.Driver"); // Import driver
        
        // Use information from web.xml
        String dbName = application.getInitParameter("dbUser");
        String dbPass = application.getInitParameter("dbPass");
        
        // Initialize connection and statement
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mblodgeg5", dbName, dbPass)) {
            // Create bean using parameters and add to database 
            %><jsp:useBean id="newReservation" class="ReservationBean.ReservationBean"><jsp:setProperty name="newReservation" property="*"/></jsp:useBean><%
            
            final List<String> VALID_ROOM_SIZES = Arrays.asList("KG", "QU", "2QU", "2FB");
            final int MIN_GUESTS = 1, MAX_GUESTS = 5;
            final int MAX_NIGHTS = 365;
            
            // Store any validation errors and list them to the user
            List<String> errors = new ArrayList<String>();
            
            if (!VALID_ROOM_SIZES.contains(newReservation.getRoomSize())) {
                errors.add(String.format("Room size '%s' is invalid", newReservation.getRoomSize()));
            }
            
            if (newReservation.getGuests() < MIN_GUESTS || newReservation.getGuests() > MAX_GUESTS) {
                errors.add("Guest count must be between 1 and 5");
            }
            
            // Parse the input dates
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate checkIn = LocalDate.parse(newReservation.getCheckInDate(), formatter);
            LocalDate checkOut = LocalDate.parse(newReservation.getCheckOutDate(), formatter);
            
            // Calculate the number of nights
            long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
            
            // Get today's date
            LocalDate today = LocalDate.now();
            
            // Check if the check-in date is after today
            long diffFromToday = ChronoUnit.DAYS.between(today, checkIn);
            
            if (diffFromToday <= 0) {
                errors.add("Reservation check-in date must be after today's date");
            }
            
            // Determine if reservation exceeds max nights
            if (nights > MAX_NIGHTS) {
                errors.add(String.format("Reservation length cannot be longer than %d nights", MAX_NIGHTS));
            }

            // Retrieve duplicate reservations from the same customer using their id
            String checkOverlapSql = "SELECT COUNT(*) as recordCount FROM reservations WHERE customerId = ? AND ((? >= checkInDate AND checkOutDate >= ?) OR (? <= checkInDate AND ? >= checkOutDate))";
            try (PreparedStatement pstmt = conn.prepareStatement(checkOverlapSql)) {
                pstmt.setInt(1, id);
                pstmt.setString(2, checkIn.toString());
                pstmt.setString(3, checkIn.toString());
                pstmt.setString(4, checkIn.toString());
                pstmt.setString(5, checkOut.toString());
                ResultSet rs = pstmt.executeQuery();
                
                // Fetch count
                rs.next();
                int count = rs.getInt("recordCount");
                rs.close();
                
                // If count is > than 0 then a duplicate reservation exists 
                // Send the user an error message
                if (count >= 1) {
                    errors.add("Conflicting reservations found");
                }
            }

            // If any validation errors have popped up, display an error message to the user instead of placing the reservation
            if (errors.size() > 0) {
                String errorList = "<ul><li>" + String.join("</li><li>", errors) + "</li></ul>";
                
                out.println("<span class='message'>There was an error placing your reservation:<br>" + errorList + "<a class='link' href='reserve.jsp'>Try again</a></span>");
                return;
            }

            // Insert record into database using PreparedStatement
            String insertSql = "INSERT INTO reservations (customerId, fullName, roomSize, guests, checkInDate, checkOutDate, total) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
                pstmt.setInt(1, newReservation.getCustomerId());
                pstmt.setString(2, newReservation.getFullName());
                pstmt.setString(3, newReservation.getRoomSize());
                pstmt.setInt(4, newReservation.getGuests());
                pstmt.setString(5, newReservation.getCheckInDate());
                pstmt.setString(6, newReservation.getCheckOutDate());
                pstmt.setDouble(7, newReservation.getTotal());
                pstmt.executeUpdate();
                
                // Post success message
                out.println("<span class='message'>Reservation successfully placed.<br><a class='link' href='reserve_lookup.jsp'>Look up your reservation(s)</a></span>");
            }
        } catch (SQLException e) {
            out.println("<p>Error inserting entry into the database.</p>");
            // Log the error
            e.printStackTrace();
        }
    }
    %>
    
</body>
</html>
