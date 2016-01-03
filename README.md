# Uber Project Challenge
This is an uber coding challenge that i got from Uber's repo shown on here: <br>
https://github.com/uber/coding-challenge-tools/blob/master/coding_challenge.md

I launched app live on heroku and here is the link:<br>


# DepartureTimes
I was given this specific task from the coding challenge on Uber's repo.

> Create a service that gives real-time departure time for public transportation (use freely available public API). The app should geolocalize the user.

This app display's the user location and for public transortation I chose Caltrain in San Francsico using the 511 (San Francisco) API and a bit more.

# Description
I created a WebApp that geolocalizes the user and display's his location on a map using the google maps API. Once his location is shown via Google Maps, the user has the option to click a button where it will display markers, on the map, where all the caltrain stops in San Francisco are located. If the user scrolls down he can also see a table that displays all the San Francisco Caltrain stops, where they're headed, and see if there is a departure within the next 90 minutes in real time.

## Technical Stack

### Back End

At first for the Back End I was going to use Rails. But since the challenge wasn't asking for too much, just an API call to get public transportation data and to geolocalize the user, and knowing I wasn't going to use any Front End frameworks I went with Sinatra, a really light framework, instead.

I kept the app pretty simple. It's a one page WebApp, so I rendered everything on the index page in the view directory. I kept all the API calls in the Caltrain model, and I used the transit controller to help render the Caltrain data on the Google Map and table in the view.


### Frontend<br/>
For the front end I kept it really light. I used HTML/CSS, Javascript(to render the map), and I didn't use any frameworks.

## Challenges

- not being able to render api 511 api data server side
- passing client side data to JS script
- google api query limit of about 10 per second
- display each departure time for each stop dynamically
- make API requests from server and client side
- show departure times if all departure times are nil
- APi shows a bad uri of forstopname when its by stopname
- hard to see if api is working when caltrain isnt running
- loop through nested hash finding the appropriate keys for stopcode
- loop through arrays of nested hashes and arrays
- Can only work during certain times because departure times are limited
- So many conditionals
### Resources

https://developers.google.com/maps/<br>
http://511.org/developer-resources_transit-api.asp\<br>
https://www.quora.com/How-do-I-pass-a-Ruby-variable-to-JavaScript<br>
