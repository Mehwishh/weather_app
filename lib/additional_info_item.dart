import 'package:flutter/material.dart' show BuildContext, Column, Image, SizedBox, StatelessWidget, Text, TextStyle, Widget;
class AdditionalInfoItem extends StatelessWidget {
  final Stream icony;
  final String label;
  final String value;
  const AdditionalInfoItem({
    super.key,
   required  this.icony,
   required  this.label ,
   required  this.value ,
  });
  @override
  Widget build(BuildContext context) {
    return  Column(children: [const SizedBox(height: 16,),
   
           Image.asset(
              "icony",
              width: 36,
              height: 36,
            ), 
    const SizedBox(height: 13,),    Text(label,
             style: const TextStyle(fontSize: 16,
             ),
             ),
             Text(value,
             style: const TextStyle(fontSize: 17,
             ),),
             const SizedBox(height: 13,),
             ],
             );
  }}