import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' show FaIcon;
class AdditionalInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInfoItem({
    super.key,
   required  this.icon ,
   required  this.label ,
   required  this.value ,
  });
  @override
  Widget build(BuildContext context) {
    return  Column(children: [const SizedBox(height: 16,),
    
    FaIcon(icon,size: 35,),
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