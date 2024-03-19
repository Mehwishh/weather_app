import 'package:flutter/material.dart';
class HourlyForecast extends StatelessWidget { 
   final String tempreture;
   final IconData forecasticon;
   final String time;
  const HourlyForecast({super.key,
       required  this.time,required  
       this.forecasticon ,required  
       this.tempreture ,});
  @override
  Widget build(BuildContext context) {
     Color iconColor;

    // Set color based on the forecast icon
    if (forecasticon == Icons.sunny) {
      // Yellow color for sunny
      iconColor = Colors.yellow;
    } else if (forecasticon == Icons.cloud) {
      // Gray color for cloud
      iconColor =const Color.fromARGB(255, 176, 211, 212);
    } else {
      // Blue color for rain
      iconColor = Colors.blue;
    }

    return SizedBox(
      width: 100,
      child: Card(
        elevation: 6,
        color:Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 16,),
            Text(maxLines: 1,
          overflow  :TextOverflow.fade,
              time,
              style:const TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),
            ),
            Icon(
              forecasticon,
              size: 36,
              color: iconColor, 
            ),           
                    Text(tempreture,style:const TextStyle(fontSize: 17,)
                    ,
                    ),const SizedBox(height: 16,),
                    ],
                    ),
        ),
      );
  }
}