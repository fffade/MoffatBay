<!-- 
    Group 5
    Attractions Page
    09/16/24
-->
<!-- This page provides information about activities available at Moffat Bay Lodge -->

<%@page language="java" contentType="text/html"%>
<%@page import="java.sql.*"%>
<html>
<head>
    <title>Attractions at Moffat Bay Lodge</title>
    <link rel="stylesheet" href="styles.css"/>
    <style>
        /* Set fixed dimensions for the image and use object-fit to maintain aspect ratio */
        #activityImage {
            width: 500px; /* Adjust width as needed */
            height: 250px; /* Adjust height as needed */
            object-fit: contain; /* Change to 'contain' if you want to see the full image */
        }
    </style>
    <script type="text/javascript">
        function changeImage(imageSrc) {
            document.getElementById('activityImage').src = imageSrc;
        }

        function resetImage() {
            document.getElementById('activityImage').src = 'assets/activities.jpg';
        }
    </script>
</head>
<body>

    <!-- Included header  -->
    <jsp:include page="header.jsp"/>
    
    <main>
        
        <h2>Attractions</h2>
        
        <p>
            &emsp;At Moffat Bay Lodge, we offer a variety of activities that showcase the natural beauty and adventure opportunities of Joviedsa Island. Whether you're an adventure seeker or someone looking to relax and enjoy nature, there's something for everyone.
        </p>

        <br>
        <img id="activityImage" src="assets/activities.jpg" alt="Activities at Moffat Bay">
        <br>
        
        <h3>Hiking</h3>
        <p onmouseover="changeImage('assets/hiking.jpg')" onmouseout="resetImage()">
            &emsp;Explore the breathtaking trails surrounding Moffat Bay. Our guided hiking tours take you through lush forests, along stunning cliffs, and to scenic viewpoints where you can witness the beauty of the bay and its surroundings. Suitable for all skill levels.
        </p>

        <h3>Kayaking</h3>
        <p onmouseover="changeImage('assets/kayaking.jpg')" onmouseout="resetImage()">
            &emsp;Experience the tranquility of Moffat Bay from the water. Rent a kayak and paddle through the calm waters, enjoying the peaceful environment and possibly spotting local wildlife. Guided tours are available for those who prefer to explore with a knowledgeable guide.
        </p>

        <h3>Whale Watching</h3>
        <p onmouseover="changeImage('assets/whale_watching.jpg')" onmouseout="resetImage()">
            &emsp;Join us on a thrilling whale-watching excursion. Joviedsa Island is known for its rich marine life, and our expert guides will take you to the best spots to observe majestic whales in their natural habitat. A must-do for nature enthusiasts and adventure seekers alike.
        </p>

        <h3>Scuba Diving</h3>
        <p onmouseover="changeImage('assets/scuba_diving.jpg')" onmouseout="resetImage()">
            &emsp;Dive into the crystal-clear waters of Moffat Bay and explore the vibrant underwater world. Our certified instructors offer courses for all levels, from beginners to advanced divers. Discover colorful coral reefs, fascinating marine life, and the hidden treasures of the bay.
        </p>
        
    </main>
    
</body>
</html>
