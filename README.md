# Foody-Bee

An app for recipes.

## Getting Started

The project starts with a Welcome page which only opens when the app first installed. The following page is the Sign In page which is implemented using Firebase. It is a simple e-mail and password sign-in. The forgot password is fully functional. Directly after sign-in there is a loading page, which takes data from json formatted database using http. In the main page we are able to search for recipes with healt and diet labels. Furthermore provider is used to save last opened receipes and the favorites. 

In the recipe page I am using the data taken from the api (api.edamam.com). Under every recipe comments section is included and users can comment under it. Every comment includes user's profile picture, user name and the date the comment posted. The comment section is implemented by using Firestore. 

Back in the main page, there is a drawer which includes profile page. In the profile page the password can be resetted and profile picture can be changed.
