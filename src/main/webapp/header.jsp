<header>
	<span class="header-logo">
		<a href="./" class="no-background"><img src="./assets/icons8-island-100.png" alt="Moffat Bay Icon"></a>
		<span class="header-title">Moffat Bay Lodge</span>
	</span>
	
	<nav class="header-navbar">
		<a class="no-background" href="about.jsp">About</a>
		
		<a class="no-background" href="attractions.jsp">Attractions</a>
		
		<a class="no-background" href="reserve.jsp">Book Now</a>
		
		<a class="no-background" href="reserve_lookup.jsp">Your Bookings</a>
		
		<a class="no-background" href="contact.jsp">Contact Us</a>
		
		<%
		// Check if user is logged in
		Integer id = (Integer) session.getAttribute("id");
		String fullName = (String) session.getAttribute("fullName"); // Assuming fullName is stored in session
		
		if (id != null && fullName != null) {
		%>
			<a href="login.jsp" class="link"><%= fullName %> is Logged In</a>
		<%
		} else {
		%>
			<a href="login.jsp">Log In</a>
		<%
		}
		%>
	</nav>
</header>
