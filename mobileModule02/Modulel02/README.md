# ! README IN PROGRESS !

# Weather App Project Part 2 : API and data 

For this part of the flutter piscine, I had to add data to the weather app, and implement every functionality in order to handle it. <br/>

To do so, I had to use a weather API, a geolocation from the GPS of the device, and Geocoding API to get the city name from the coordinates. <br/>

## Geolocation

When you click on the geolocation button (top right), a pop-up window appears to ask you for permission to use the geolocation from the GPS of your device :

![geolocation](https://github.com/Claken/Piscine_Flutter/assets/51683861/66d10dcf-f189-488b-b917-ce095e7a289a)

If you refuse to use it, this message will appear on your screen :

![geolocation_refus](https://github.com/Claken/Piscine_Flutter/assets/51683861/79813cb3-b821-4e91-966c-61f6e5553c3b)

If you accept, you will have :

- In the “Current” tab : <br/>
  • The location (city name, region and country). <br/>
  • The current temperature (in Celsius). <br/>
  • The current weather description (cloudy, sunny, rainy, etc.). <br/>
  • the current wind speed (in km/h). <br/>

- In the “Today” tab :
  • The location (city name, region and country).
  • The list of the weather for the day with the following data:
  • The hours.
  • The temperatures by hours.

- In your third tab “Weekly” you will have to display:
  • The location (city name, region and country).
  • The list of the weather for each day of the week with the following data:
  • The date.
  • The min and max temperatures of the day
  • The weather description (cloudy, sunny, rainy, etc.).


![api data](https://github.com/Claken/Piscine_Flutter/assets/51683861/1c03466c-e170-443e-9042-18feef4fdad0)

## Search bar

![api data2](https://github.com/Claken/Piscine_Flutter/assets/51683861/0c3afb9e-b931-4db5-8819-ff95df592320)

