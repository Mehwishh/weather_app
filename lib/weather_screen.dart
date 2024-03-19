import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key,
});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future <Map<String ,dynamic>>weather;
  @override
  void initState(){
    super.initState();
   weather = getWeatherData();
  }
  
  double kelvinToCelsius(var temperatureKelvin) {
  return (temperatureKelvin - 273).roundToDouble();
}
   Future <Map<String ,dynamic>>getWeatherData()async{ 
    var cityName ="karachi"; 
    try {
      final result =await http.get(
      Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=f93b554e4624c86b04fcfb2e2dbcdc09"),);
                final data =jsonDecode(result.body); 
     if (data["cod"]!= "200"){
      throw "Unexpected Erroe occur";
        }
    return data; 
    } 
    catch (e) {
       throw e.toString();

    }
   } 
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      appBar: AppBar(title:const Text('weather App',
      style: TextStyle(fontWeight: FontWeight.bold,),
      ),
       
     centerTitle: true,
     actions:[IconButton(
      onPressed: (){
        setState(() {
          weather =getWeatherData();
        });
      }, icon:const Icon(Icons.refresh),)
]     ),
body: FutureBuilder(
  future:weather,
  // allow to handle states of te app if its is loading or lost connection
  builder:(context,snapshot){
    if (snapshot.connectionState ==ConnectionState.waiting){
      return const CircularProgressIndicator.adaptive(); }
    if (snapshot.hasError){
      return Center(child: (Text(snapshot.error.toString())));
    }
   final data = snapshot.data!;
   final currentdata=data['list'][0];
   final currentTempreture = kelvinToCelsius( currentdata['main']['temp']);
   final currentTempretureFeelsLike =kelvinToCelsius(currentdata['main']['feels_like']) ;
   final currentHumidity =currentdata['main']['humidity'];
   final currentPressure =currentdata['main']["pressure"];
   final windSpeed =currentdata['wind']['speed'];
   final currentSky =currentdata["weather"][0]["description"];
   final date =DateTime.parse(currentdata['dt_txt']); 
String getWeatherImage(String currentSky) {
  switch (currentSky.toLowerCase()) {
    case 'clear':
      return 'assets/clear.png';
    case 'clouds':
      return 'assets/overcast.png';
    case 'rain':
      return 'assets/rain.png';
    case 'snow':
      return 'assets/snow.png';
    case 'mist':
      return 'assets/mist.png';
    // Add more cases for other weather conditions as needed
    default:
      return 'assets/sunny.png'; // Default image if the weather condition is unknown
  }
}
  return Padding( 
      padding:const EdgeInsets.all(16),
      //main card
    child: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           SizedBox(
            width:double.maxFinite,
             child: Card(elevation: 6,color: const Color.fromARGB(0, 185, 24, 24),
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ClipRRect(
                 borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 0,sigmaY: 0),
                  child:   Padding(
                   padding: const EdgeInsets.all(16),
                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                       Column(children: [
                           Text(" ${DateFormat('E, MMM d, hh:mm a').format(date)}",
                         style:const TextStyle(fontSize: 14,
                        ),
                        ),
                        Text("$currentTempreture\u00B0C",
                        style: const TextStyle(fontSize: 50,fontWeight: FontWeight.bold ,color: Colors.white
                        ),),
                        const SizedBox(height: 16,),
  
                        Text("Feels like $currentTempretureFeelsLike\u00B0K",
                        style: const TextStyle(fontSize: 14,
                        ),
                        ),
                        ],
                        ), Column(children: [
                 Image.asset(
              getWeatherImage(currentSky),
              width: 86,
              height: 86,
            ),
                        // Icon(currentSky == "Clouds" || currentSky == "Sunny" ? Icons.cloud: Icons.sunny,size: 96,color: const Color.fromARGB(232, 119, 164, 199),),
                        const SizedBox(height: 16,),
                   
                        ],
                        ),
                     ],
                   ),
                         ),
                ),
              ),),
           ),  
       // weather forecast items
        const  SizedBox(height: 16,),
       const Text('weather Forecast',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),
            ), const  SizedBox(height: 10,),
    //    SingleChildScrollView(
    //     scrollDirection: Axis.horizontal,
    //     child:  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [for(int i=0 ; i<7;i++)
    //        HourlyForecast(
    //         tempreture: kelvinToCelsius(data["list"][i+1]['main']['temp']).toString(),
    //         time: data["list"][i+1]['dt'].toString(),
    //         forecasticon:  data["list"][i+1]["weather"][0] == "clouds" || data["list"][i+1]["weather"][0] == "sunny" ? Icons.cloud: Icons.sunny,)
          
    // ],),
    //   ),
         SizedBox(height: 140,
           child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context,index){
              final hourlyForecast=data["list"][index+1];
              final time =DateTime.parse(hourlyForecast['dt_txt']);
              // final hoursky =hourlyForecast["weather"][0]["main"].toString();
              final hourtemp =kelvinToCelsius( hourlyForecast["main"]["temp"]).toString();
              return HourlyForecast(time:DateFormat.j().format(time), forecastImage:getWeatherImage(currentSky),tempreture: hourtemp); },),
         ),
         // weather forecast items
       const Text('Additional Information',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),
            ), const  SizedBox(height: 8,),
       Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          
           AdditionalInfoItem(icon: Icons.water_drop,label: "Humidity",value: "$currentHumidity%" ,),
           AdditionalInfoItem(icon: Icons.air,label: "Wind Speed",value: "$windSpeed km/h" ,),
           AdditionalInfoItem(icon: Icons.beach_access,label: "Pressure",value: "$currentPressure mb" ,),
         
         ],
         ),Image(image: AssetImage("assets/clear.png"))]
        ,),
    ),
    ); } ,
)
); }
}