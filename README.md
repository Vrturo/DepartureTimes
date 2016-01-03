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

I kept the app pretty simple. It's a one page WebApp, so I rendered everything on the index page in the view directory. I kept all the API calls in the Caltrain model, along with some help from the helper methods I built in the transit.rb file in the helpers directory, and I used the transit controller to help render the Caltrain data on the Google Map and table in the view.


### Frontend<br/>
For the front end I kept it really light. I used HTML/CSS, Javascript(to render the map), and I didn't use any frameworks.

## Challenges
This is definitely my favorite thing to talk about, the major challenges I faced :D <br>

1) Dealing with the 511 API
It was my first time dealing with the 511 transit API and something that stood out to me right away was it only rendered data in XML. Meaning I couldn't just ajax some API calls and easily parse the data to display on the DOM. So instead I just did the API calls on the client side with a HTTParty gem and passed them as instance variables in a script on the view, and the data was recieved on the Javascript side.
<br>
Also another problem I had since the API data was only availabe in XML I had to set up a lot of conditional methods because the data I was receiving a huge nested hash of data and had many different possibilities within the hash if the next item on the hash was an Object, an array, a strign, or just nil. So I set up a wide variety of conditional helper methods that would help me loop through the hash by checking what the next object would be and according to what it is, it would use the appropriate methods to move on to the next item and return the appropriate object.

2) Bad API documentation
In the 511 API documentation it shows the service URL you need, tells you what query parameters have to be passed, an example usage that can be used, and what it returns. <br>
But on page 11 in the 511 API documentation it show the "GetNextDeparturesByStopName" API call they displayed the wrong API call in the example. I was following the documentation and kept getting 404 errors and nil classes. I thought I was doing something wrong so I backtracked for any errors and tried going other ways until I realized in the documentation it says "GetNextDeparturesForStopName" but it really is meant to be BYstopname, not FORstopname. I sent the developers an email hoping they'll change it so other developers don't get stuck, and second guess themselves, but now I learned even documentation can be wrong.

3) Dealing with dynamic data that can be unavailable at certain times
Dealing with the 511 API data meant dealing with live data that was only available at certain times. Since Caltrain doesn't run 24/7, working at certain hours seemed like "bad times" to work like when is working when caltrain isnt running because sometimes requests could come back nil or empty and it could seem like a bad request, but that's why writing tests help because even if data is unavailable at the moment and cant be displayed you can still see if your requests are still being made.

4) Google Maps Query limit
I chose to display the Caltrain stops on Google Maps so users can see how far they are from an actual stop. Originally I wanted to show all the information they needed on the marker on the Google Map but Google Maps had a query limit of about 10 hits per second so it really slowed down what I wanted to do as far as user features. So instead I just let it display the closest stops nearest to the user and displayed the Stop Name on the marker but made sure all the real time data was able to display on a table below so the user wasn't limited to he data available.



### Resources
The major resources I feel that helped me out for this specific challenge.

https://developers.google.com/maps/<br>
http://511.org/developer-resources_transit-api.asp\<br>
https://www.quora.com/How-do-I-pass-a-Ruby-variable-to-JavaScript<br>
