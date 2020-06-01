Group Project - README Template
===

# GoChallenges

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
An iOS app where users can create and participate in challenges over the world

### App Evaluation

- **Category:** Lifestyle
- **Mobile:** iOS
- **Story:** Create a way to keep people aware of their well-being in many aspects
- **Market:** App Store
- **Habit:** Daily
- **Scope:** Young adults

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Register
* Sign in/ Sign out
* Add challenges
* Join a new challenge
* Show progress
* See current challanges
* Make friends
 
**Optional Nice-to-have Stories**

* Leadership board
* Receive in-app medals
* Have a medal collection
* Animation
* Post video/image as proof
* Wishlist
* Reminder
* Popular challages

### 2. Screen Archetypes

* Sign in screen
    * Sign in
* Register screen
    * Register
* Sign out screen
    * Ask if the user wants to sign out or not
* Challenge feed screen
    * A list of challenges
* Profile
    * A list of challenges joined
    * A list of challenges created
    * A list of challenges completed
    * Wishlist
* Challenge detail
    * Detail of a challenge
    * Progress if joined
    * Track progress
* My challenge detail
    * A list of challenges joined 
* New challenge screen 
    * Create a new challenge
* Friend list screen
    * See friend

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Challenges screen
* New challenge screen 
* My Challenges screen
* Profile screen

**Flow Navigation** (Screen to Screen)

* Sign in screen
    * Challenges screen
* Register screen
    * Challenges screen
* Challenges screen
    * Challenge details
* Challenge detail
* New challenge screen 
    * Challenge details
* Profile
    * Friend list screen
    * Challenge details
* My challenge detail
    * Challenge details
* Friend list screen
    * Profile screen 
* Sign out screen
    * Sign in/Register screen

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### Digital Wireframes & Mockups

### Interactive Prototype

## Schema 

### Models

Profile

| Property      | Type     | Description |
| ------------- | -------- | ------------|
| username | String | Username |
| password | String | User's password |
| name | String | Name of the user |
| image | File | Profile Image |
| friends | Array | List of friends |
| completedChallenges | Array | List of challenges completed |
| currentChallenges | Array | List of challenges not completed |
| createdChallenges | Array | List of challenges created by the user |


Challenge 
| Property      | Type     | Description |
| ------------- | -------- | ------------|
| challengeName | String | Name of challenge |
| createdDate | Date | Date challenge created |
| endDate | Date | Date challenge ended |
| goalUnit | String | Unit of goal |
| goal | Integer | The end of the challenge |
| progress | Float | The current progress of the challenge |
| isAttended | Boolean | If the user already joined |
| isCompleted | Boolean | If the challanged is completed |


### Networking
* Sign in screen
    * (Read/GET) Query account with matched username and password in the textfield
* Register screen
    * (Create/POST) Create a new profile
* Challenge feed screen
    * (Read/GET) Query all ongoing challenges
* Challenge detail
    * (Read/GET) Query selected challenge
* New challenge screen 
    * (Create/POST) Create a new challenge
* Profile
    * (Read/GET) Query the current account's profile
    * (Read/GET) Query all current account's joined, created, and completed challenges
* My challenge details
    * (Read/GET) Query the current account's joined challenges
* Friend list screen
    * (Read/GET) Query friends' profiles
* Sign out screen
    * Go back to the sign in screen
