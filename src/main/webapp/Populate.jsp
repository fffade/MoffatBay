<!-- 
	Group 5
	Populate Tables
	09/16/24
 -->
 <!--  Test application to ensure JDBC and database is functional -->
 <!--  Insert trial information into accounts and reservation tables -->
<%@page language="java" contentType="text/html"%>
<%@page import="java.sql.*"%>
<html>
<head>
    <title>Populate Tables</title>
</head>
<body>
<%
    // Load the MySQL JDBC driver
    Class.forName("com.mysql.cj.jdbc.Driver");

    // Use information from web.xml
    String dbName = application.getInitParameter("dbUser"),
            dbPass = application.getInitParameter("dbPass");

    out.println("<h2>Moffat Bay - Populate Tables</h2>");

    // Make connection
    Connection conn = null;
    PreparedStatement pstmtAccounts = null;
    PreparedStatement pstmtReservations = null;
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mblodgeG5", dbName, dbPass);

        // Insert into Accounts table
        try {
            String insertAccounts = "INSERT INTO accounts (customerId, firstName, lastName, email, telephone, password) VALUES (?, ?, ?, ?, ?, ?)";
            pstmtAccounts = conn.prepareStatement(insertAccounts);

            pstmtAccounts.setInt(1, 1);
            pstmtAccounts.setString(2, "John");
            pstmtAccounts.setString(3, "Doe");
            pstmtAccounts.setString(4, "johndoe21@gmail.com");
            pstmtAccounts.setString(5, "6147008910");
            pstmtAccounts.setString(6, "jd7000!!");
            pstmtAccounts.executeUpdate();

            pstmtAccounts.setInt(1, 2);
            pstmtAccounts.setString(2, "Marcus");
            pstmtAccounts.setString(3, "Walker");
            pstmtAccounts.setString(4, "mwalker2001@gmail.com");
            pstmtAccounts.setString(5, "6149826464");
            pstmtAccounts.setString(6, "ILuvWaffles4@");
            pstmtAccounts.executeUpdate();

            pstmtAccounts.setInt(1, 3);
            pstmtAccounts.setString(2, "Lucy");
            pstmtAccounts.setString(3, "Alexander");
            pstmtAccounts.setString(4, "lucymusic@outlook.com");
            pstmtAccounts.setString(5, "7408114300");
            pstmtAccounts.setString(6, "Musicals20$$");
            pstmtAccounts.executeUpdate();

            out.println("<b>Accounts</b> table populated successfully.<br>");
        } catch (SQLException e) {
            out.println("<b>Failed to populate Accounts</b> table.<br>");
            out.println(e);
        } finally {
            if (pstmtAccounts != null) pstmtAccounts.close();
        }

        // Insert into Reservations table
        try {
            String insertReservations = "INSERT INTO reservations (reservationId, customerId, roomSize, guests, total, checkInDate, checkOutDate) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmtReservations = conn.prepareStatement(insertReservations);

            pstmtReservations.setInt(1, 1);
            pstmtReservations.setInt(2, 1);
            pstmtReservations.setString(3, "KG");
            pstmtReservations.setInt(4, 1);
            pstmtReservations.setDouble(5, 115.0);
            pstmtReservations.setDate(6, java.sql.Date.valueOf("2024-06-05"));
            pstmtReservations.setDate(7, java.sql.Date.valueOf("2024-06-06"));
            pstmtReservations.executeUpdate();

            pstmtReservations.setInt(1, 2);
            pstmtReservations.setInt(2, 2);
            pstmtReservations.setString(3, "2FB");
            pstmtReservations.setInt(4, 3);
            pstmtReservations.setDouble(5, 300.0);
            pstmtReservations.setDate(6, java.sql.Date.valueOf("2024-07-15"));
            pstmtReservations.setDate(7, java.sql.Date.valueOf("2024-07-17"));
            pstmtReservations.executeUpdate();

            pstmtReservations.setInt(1, 3);
            pstmtReservations.setInt(2, 3);
            pstmtReservations.setString(3, "QU");
            pstmtReservations.setInt(4, 2);
            pstmtReservations.setDouble(5, 345.0);
            pstmtReservations.setDate(6, java.sql.Date.valueOf("2024-08-21"));
            pstmtReservations.setDate(7, java.sql.Date.valueOf("2024-08-24"));
            pstmtReservations.executeUpdate();

            out.println("<b>Reservations</b> table populated successfully.<br>");
        } catch (SQLException e) {
            out.println("<b>Failed to populate Reservations</b> table.<br>");
            out.println(e);
        } finally {
            if (pstmtReservations != null) pstmtReservations.close();
        }

    } catch (Exception e) {
        out.println("<p>Error connecting to the database.</p>");
        out.println(e);
    } finally {
        if (conn != null) conn.close();
    }
%>
</body>
</html>
