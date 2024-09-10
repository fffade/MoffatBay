<!-- 
	Group 5
	Login Page
	09/02/24
 -->
 <!-- Here a user can log into their active account stored in the database -->

<%@page language="java" contentType="text/html"%>
<%@page import="java.sql.*"%>
<html>
<head>
	<title>Login to your account</title>
	<link rel="stylesheet" href="styles.css"/>
</head>
<body>

	<!-- Included header  -->
	<jsp:include page="header.jsp"/>
	
	
	<%
	if(request.getMethod().equals("GET"))
	{
		// Check for logouts
		if(request.getParameter("logout") != null)
		{
			session.invalidate(); // Cancel session data and refresh
			response.sendRedirect("login.jsp");
			return;
		}
		
		// Determine if this is a new session or if the user is already logged in
		if(!session.isNew())
		{
			Integer id = (Integer)session.getAttribute("id");
			String email = (String)session.getAttribute("email");
			
			if(id != null)
			{
				// Post success message
				// Log Out button included
				out.println("<span class='message'>You are logged in as " + email + ".<br><a class='link' href='login.jsp?logout=true'>Log out</a></span>");
				
				return;
			}
		}
		// Otherwise, continue showing log in form
	%>
	<main class="tight">
		
		<h2>Log In</h2>
		
		<form method="POST" action="login.jsp">
		
			<label for="email">Email</label>
			<input id="email" name="email" type="text" maxlength="255" required>
			
			<label for="password">Password</label>
			<input id="password" name="password" type="password" maxlength="255" required>
			
			<button class="login-button" type="submit">Log In</button>
			
			<span class="information"><a class="link" href="register.jsp">Don't have an account? Click here.</a></span>
		
		</form>
		
	</main>
	<%
	} else if(request.getMethod().equals("POST")) {
		
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
		
		// Send the data by inserting an entry into the database
		try
		{
			
			// Check for existing accounts with the same email and password
			ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as recordCount, email FROM accounts WHERE email = \"" + request.getParameter("email") + "\" AND password = \"" + request.getParameter("password") + "\"");
					
			// Fetch the matching account
			rs.next();
			int count = rs.getInt("recordCount");
			String email = rs.getString("email");
			rs.close();
			
			// No matching account, throw error
			if(count <= 0)
			{
				out.println("<span class='message'>Email or password is incorrect.<br><a class='link' href='login.jsp'>Try again</a></span>");
				return;
			}
			
			// Fetch the account email
			rs = stmt.executeQuery("SELECT customerId FROM accounts WHERE email = \"" + email + "\"");
			rs.next();
			int id = rs.getInt("customerId");
			rs.close();
			
			// Create a new session now by assigning the account email
			session.setAttribute("id", id);
			session.setAttribute("email", email);
			
			// Refresh this page
			response.sendRedirect("login.jsp");
		}
		catch (SQLException e)
		{
			out.println("<p>Error accessing database.</p>");
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