# Uber Project Challenge
https://github.com/Vrturo/coding-challenge-tools/blob/master/coding_challenge.md

# DepartureTimes
A service that gives real-time departure time for public transportation (use freely available public API). The app should geolocalize the user.

# Description

## Technical Stack

### Back End

The Backend was written in rails. <br />

### Frontend<br />

## Challenges
- hiding env keys, specifically on controller
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
