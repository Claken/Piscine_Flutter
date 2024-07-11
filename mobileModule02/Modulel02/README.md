# !!! README IN PROGRESS  !!!

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
  • Your location (city name, region and country). <br/>
  • The current temperature (in Celsius). <br/>
  • The current weather description (cloudy, sunny, rainy, etc.). <br/>
  • the current wind speed (in km/h). <br/>

- In the “Today” tab : <br/>
  • Your location. <br/>
  • A list of the weather for the day with the following data: <br/>
    • The hours. <br/>
    • The temperatures by hours. <br/>

- In the “Weekly” tab : <br/>
  • Your location. <br/>
  • A list of the weather for each day of the week with the following data: <br/>
    • The date. <br/>
    • The min and max temperatures of the day <br/>
    • The weather description (cloudy, sunny, rainy, etc.). <br/>

![api data](https://github.com/Claken/Piscine_Flutter/assets/51683861/1c03466c-e170-443e-9042-18feef4fdad0)

## Search bar

When you tab the search bar button (or the search bar itself), you can type any city you want in the world. <br/>
When the city you want appears on the list below the search bar, tap on it. <br/>
You will then see the informations about the city like this :

![api data2](https://github.com/Claken/Piscine_Flutter/assets/51683861/0c3afb9e-b931-4db5-8819-ff95df592320)

## Launch the project

You need to have either a smartphone or an emulator of smartphone in order to launch this project.
(as well as for the reste of the piscine)

When you have set your smartphone or your emulator, please use this command :
```
flutter run
```
