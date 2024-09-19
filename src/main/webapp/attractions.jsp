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
    
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
	<link rel="manifest" href="site.webmanifest">
	
    <style>
    	.imageContainer {
    		display: inline;
    		margin: 1rem auto;
    		width: 100%;
    		height: 150px;
    		position: relative;
    	}
    
        /* Set fixed dimensions for the image and use object-fit to maintain aspect ratio */
        .imageContainer img {
       		display: block;
            width: auto; /* Adjust width as needed */
            height: 150px; /* Adjust height as needed */
            position: absolute;
            left: 0;
            right: 0;
            bottom: 0;
            margin: auto;
        }
        
        .imageContainer img.activityHide {
        	opacity: 0%;
        	transition: opacity 0.5s 0.05s;
        }
        
        .imageContainer img.activityShow {
        	opacity: 100%;
        	transition: opacity 0.5s 0s;
        }
        
    </style>
    <script type="text/javascript" defer>
        
    	let images = document.getElementsByTagName("img");
    	
    	// Hides all the activity images to show only just one
    	function hideImages() {
    		for(let i of images) {
    			i.className = "activityHide";
    		}
    	}
    	
    	// Shows only the given image
    	function showOneImage(imageId) {
    		hideImages();
    		document.getElementById(imageId).className = "activityShow";
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
        	<div class="imageContainer">
        		<img id="activityImage" class="activityShow" src="assets/activities.jpg" alt="Activities at Moffat Bay">
	        	<img id="hiking" class="activityHide" src="assets/hiking.jpg" alt="Hiking">
	        	<img id="kayaking" class="activityHide" src="assets/kayaking.jpg" alt="Kayaking">
	        	<img id="whaleWatching" class="activityHide" src="assets/whale_watching.jpg" alt="Whale Watching">
	        	<img id="scubaDiving" class="activityHide" src="assets/scuba_diving.jpg" alt="Scuba Diving">
        	</div>
        <br>
        
        <h3>Hiking</h3>
        <p onmouseover="showOneImage('hiking')" onmouseout="showOneImage('activityImage')">
            &emsp;Explore the breathtaking trails surrounding Moffat Bay. Our guided hiking tours take you through lush forests, along stunning cliffs, and to scenic viewpoints where you can witness the beauty of the bay and its surroundings. Suitable for all skill levels.
        </p>

        <h3>Kayaking</h3>
        <p onmouseover="showOneImage('kayaking')" onmouseout="showOneImage('activityImage')">
            &emsp;Experience the tranquility of Moffat Bay from the water. Rent a kayak and paddle through the calm waters, enjoying the peaceful environment and possibly spotting local wildlife. Guided tours are available for those who prefer to explore with a knowledgeable guide.
        </p>

        <h3>Whale Watching</h3>
        <p onmouseover="showOneImage('whaleWatching')" onmouseout="showOneImage('activityImage')">
            &emsp;Join us on a thrilling whale-watching excursion. Joviedsa Island is known for its rich marine life, and our expert guides will take you to the best spots to observe majestic whales in their natural habitat. A must-do for nature enthusiasts and adventure seekers alike.
        </p>

        <h3>Scuba Diving</h3>
        <p onmouseover="showOneImage('scubaDiving')" onmouseout="showOneImage('activityImage')">
            &emsp;Dive into the crystal-clear waters of Moffat Bay and explore the vibrant underwater world. Our certified instructors offer courses for all levels, from beginners to advanced divers. Discover colorful coral reefs, fascinating marine life, and the hidden treasures of the bay.
        </p>
        
    </main>
    
</body>
</html>
