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
	
	<main class="tight">
		
		<h2>Create an account</h2>
		
		<form method="POST" action="register.jsp">
		
			<label for="first-name">First Name</label>
			<input id="first-name" type="text" maxlength="100">
			
			<label for="last-name">Last Name</label>
			<input id="last-name" type="text" maxlength="100">
			
			<label for="email">Email Address</label>
			<input id="email" type="text" maxlength="255">
			
			<label for="telephone">Phone #</label>
			<input id="telephone" type="text" maxlength="10">
			
			<label for="password">Password</label>
			<input id="password" type="password" maxlength="255">
			
			<label for="confirm-password">Confirm Password</label>
			<input id="confirm-password" type="password" maxlength="255">
			
			<span class="information small">
				Your email address will be used for logging in
			</span>
			
			<span class="information">
				<a class="link" href="login.jsp">Already have an account? Log in.</a>
			</span>
			
			<button class="login-button" type="submit">Sign Up</button>
		
		</form>
		
	</main>
	
</body>
</html>