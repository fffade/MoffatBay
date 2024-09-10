<!-- 
	Group 5
	About Page
	09/10/24
 -->
 <!-- Here a user can read about the lodge and its upbringing -->

<%@page language="java" contentType="text/html"%>
<%@page import="java.sql.*"%>
<html>
<head>
	<title>About Moffat Bay Lodge</title>
	<link rel="stylesheet" href="styles.css"/>
</head>
<body>

	<!-- Included header  -->
	<jsp:include page="header.jsp"/>
	
	<main>
		
		<h2>About</h2>
		
		<p>
			&emsp;In March of 2024, the San Juan Islands First Nations Development Committee approved project Moffat Bay Lodge, the construction of a five-star luxury resort. 
			<br><br>
			&emsp;Fast forward six months later, Joviedsa Island boasts <i>Moffat Bay Lodge</i>, the elegant and high-class inn overseeing the beautiful and luscious Moffat Bay. Open and welcome to tourists and local visitors alike,
			our resort features rooms for families of any size. Included in every room is a sleek bathroom with a standing shower and complimentary toiletries, alongside a guaranteed window view of the bay. Located near various
			popular sites and attractions, the activities of Moffat Bay will ensure an fun, exhilarating trip for anyone!
		</p>
		
		<img src="assets/bay_lodge.jpg" alt="Moffat Bay">
		
	</main>
	
</body>
</html>