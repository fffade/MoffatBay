<!-- 
	Group 5
	Register Page
	09/02/24
 -->
 <!-- Here a user can insert a new account into the database using this form -->

<%@page language="java" contentType="text/html"%>
<%@page import="java.sql.*"%>
<html>
<head>
	<title>Register an account</title>
	<link rel="stylesheet" href="styles.css"/>
</head>
<body>

	<!-- Included header  -->
	<jsp:include page="header.jsp"/>
	
	<% 
	if(request.getMethod().equals("GET"))
	{
	%>
	<main class="tight">
		
		<h2>Create an account</h2>
		
		<form method="POST" action="register.jsp">
		
			<label for="first-name">First Name</label>
			<input id="first-name" type="text" name="firstName" maxlength="100" required>
			
			<label for="last-name">Last Name</label>
			<input id="last-name" type="text" name="lastName" maxlength="100" required>
			
			<label for="email">Email Address</label>
			<input id="email" type="email" name="email" maxlength="255" required>
			
			<label for="telephone">Phone #</label>
			<input id="telephone" type="text" name="phone" maxlength="10" required>
			
			<label for="password">Password</label>
			<input id="password" type="password" name="password" maxlength="255" required>
			
			<label for="confirm-password">Confirm Password</label>
			<input id="confirm-password" type="password" name="confirmPassword" maxlength="255" required>
			
			<span class="information small">
				Your email address will be used for logging in
			</span>
			
			<span class="information">
				<a class="link" href="login.jsp">Already have an account? Log in.</a>
			</span>
			
			<button class="login-button" type="submit">Sign Up</button>
		
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
		
		// Send the data by inserting an entry into the database
		try
		{
			// Create bean using parameters and add to database 
			%><jsp:useBean id="newAccount" class="AccountBean.AccountBean"><jsp:setProperty name="newAccount" property="*"/></jsp:useBean><%
			
			// Check for existing accounts with the same email or password
			ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS recordCount FROM accounts WHERE email = \"" + newAccount.getEmail() + "\" OR telephone = \"" + newAccount.getPhone() + "\"");
					
			// Fetch number
			rs.next();
			int count = rs.getInt("recordCount");
			rs.close();
			
			// Cancel creation of account and display error message
			if(count > 0)
			{
				out.println("<span class='message'>That email address or phone number is already in use.<br><a class='link' href='register.jsp'>Try again</a></span>");
				return;
			}
			
			// Check password requirements and that password matches
			String passRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^\\da-zA-Z])\\S{8,}$";
			
			if(!newAccount.getPassword().matches(passRegex))
			{
				out.println("<span class='message'>Password requirements are not met.<br><a class='link' href='register.jsp'>Try again</a></span>");
				return;
			}
			
			if(!newAccount.getPassword().equals(newAccount.getConfirmPassword()))
			{
				out.println("<span class='message'>Passwords do not match.<br><a class='link' href='register.jsp'>Try again</a></span>");
				return;
			}
			
			// Insert record into database
			stmt.executeUpdate("INSERT INTO accounts (firstName, lastName, email, telephone, password) VALUES (\"" + newAccount.getFirstName() + "\", \"" + newAccount.getLastName() + "\", \"" + newAccount.getEmail() + "\", \"" + newAccount.getPhone() + "\", \"" + newAccount.getPassword() + "\")");
			
			// Post success message
			out.println("<span class='message'>Account successfully created.<br><a class='link' href='login.jsp'>Go to log in</a></span>");
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