# MoffatBay
The Moffat Bay Lodge project for our Group #5 - CSD460 - Capstone in Software Development.

# Moffat Bay Project
Group Members:
Alondra J.C.
Omar J.
Jeremiah K.

Professor:
Joseph I.

## Project Overview

### Joviedsa Island, Washington State Project Overview
Six months ago, the San Juan Islands First Nations Development Committee approved the construction of a resort and marina at Moffat Bay on Joviedsa Island. The construction of both the lodge and marina is almost complete. They have hired you to work on one of the two projects that need to be completed before the facilities open.

## Project 1: Moffat Bay Lodge

### Project Scope
Building a website for the Moffat Bay Lodge that manages the following:

- **Customer Access**: Customers can view all aspects of the Lodge website without being logged in. However, to book a vacation (lodge reservation), they must be logged in or registered.
- **Reservation Submission**: To submit a reservation, users must log in or register for a free account. There are no payment requirements, but users must click a button to confirm their reservation.
- **Database Integration**: Once a reservation is confirmed, it must be saved to the database. The reservations saved in the database will be used to populate the Reservation Lookup page.
- **User Management**: All registered users should be saved to a database table. This table will be used during the login process to validate their access.

## Project Requirements

### Pages, Models, Operations, and/or Functionality

- **Landing Page**
  - Simple marketing landing page (use the Internet for inspiration on landing pages).

- **About Us Page**
  - Static HTML/CSS content related to Moffat Bay Lodge.

- **Contact Us Page**
  - Static HTML/CSS content related to Moffat Bay Lodge.

- **Attractions Page**
  - Static HTML/CSS content related to activities available on the island. This includes:
    - Hiking
    - Kayaking
    - Whale watching
    - Scuba diving

- **Registration Page**
  - The registration page should include, at minimum, the following fields:
    - Email address
    - First name
    - Last name
    - Telephone
    - Password
  - Additional comments:
    - All customers should be assigned a unique `customerId`.
    - The email address should be used as the “username” field.
    - The password should be at least 8 characters in length and include one uppercase and one lowercase letter.
    - Passwords should be hashed and/or encrypted using standard security practices.

- **Login Page**
  - Provide customers with a login form including fields for:
    - Username (use email address)
    - Password
  - Logged-in customers should be added to the application’s session.

- **Lodge Reservation (Book Your Vacation) Page**
  - Build a lodge reservation page that allows customers to book their vacation.
  - Form selection options should include:
    - Room size (Double full beds, Queen, Double queen beds, King)
    - Number of guests
    - Check-in/check-out dates
  - Additional comments:
    - Pricing:
      - 1-2 guests: $115.00 per night
      - 3-5 guests: $150.00 per night
  - MySQL must be used to save the reservation data.

- **Reservation Summary Page**
  - Provide customers with a reservation confirmation summary and a button to either cancel or submit the reservation.
  - Submitted reservations must be saved to MySQL.
  - Canceling the reservation should take users back to the hotel reservation page.

- **Reservation Lookup Page**
  - Provide customers with a page to look up previous reservations.
  - The page should include a field to search by reservation ID or email address and display a summary of the reservation, listing:
    - Room size
    - Number of guests
    - Check-in/check-out dates
