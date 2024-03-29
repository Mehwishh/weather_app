import 'package:flutter/material.dart';
class HourlyForecast extends StatelessWidget { 
   final String tempreture;
   final String forecastImage;
   final String time;
   final String sky;
  const HourlyForecast({super.key,
       required  this.time,required  
       this.forecastImage ,
       required  
       this.tempreture ,   required  
       this.sky,});
  @override
  Widget build(BuildContext context) {

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
            ),const SizedBox(height: 10,),
             Image.asset(
              forecastImage,
              width: 36,
              height: 36,
            ),      
                    Text("$sky",style:const TextStyle(fontSize: 14,)
                    ,
                    ),const SizedBox(height: 10,),
                     Text("$tempreture\u00B0C",style:const TextStyle(fontSize: 17,)
                    ,
                    ),const SizedBox(height: 16,),
                    ],
                    ),
        ),
      );
  }
}