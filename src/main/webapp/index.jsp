<!-- 
	Group 5
	Landing Page
	09/02/24
 -->
 <!-- Here is the base landing page (index page) that all users go to when going to this site -->

<%@page language="java" contentType="text/html"%>
<%@page import="java.sql.*"%>
<html>
<head>
	<title>Moffat Bay Lodge</title>
	<link rel="stylesheet" href="styles.css"/>
	
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
	<link rel="manifest" href="site.webmanifest">
</head>
<body>

	<!-- Included header  -->
	<jsp:include page="header.jsp"/>
	
	<main class="landing">
		
		<h1>Place your reservation today!</h1>
		
		<div class="button-column">
		
			<a href="attractions.jsp" class="background-secondary">View More</a>
			
			<a href="login.jsp">Log In</a>
			
			<span class="information">Or <a href="register.jsp" class="link">make an account</a></span>
			
		</div>
		
	</main>
	
	<span class="floating-message">
		Experience the vacation of a lifetime.
	</span>
		
	
</body>
</html>