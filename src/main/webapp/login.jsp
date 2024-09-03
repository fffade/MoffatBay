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
	
	<main class="tight">
		
		<h2>Log In</h2>
		
		<form method="POST" action="login.jsp">
		
			<label for="email">Email</label>
			<input id="email" type="text" maxlength="255">
			
			<label for="password">Password</label>
			<input id="password" type="password" maxlength="255">
			
			<button class="login-button" type="submit">Log In</button>
			
			<span class="information"><a class="link" href="register.jsp">Don't have an account? Click here.</a></span>
		
		</form>
		
	</main>
	
</body>
</html>