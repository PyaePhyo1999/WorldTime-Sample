import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();

}
class _HomeState extends State<Home>{
  Map data ={};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty? data : ModalRoute.of(context)?.settings.arguments as Map;
    print(data);

    String bgImage = data['isDayTime'] ?'day.jpg' : 'night.jpg';
    Color? bgColor = data['isDayTime'] ? Colors.lightBlueAccent[200] : Colors.blue[900];
    Color? editLocationColor = data['isDayTime'] ? Colors.grey[600] : Colors.grey[300];
       return Scaffold(
         backgroundColor: bgColor,
         body: SafeArea(
           child: Container(
             decoration: BoxDecoration(
               image:  DecorationImage(
                 image: AssetImage('assets/$bgImage'),
                 fit: BoxFit.cover,
                 colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
               )
             ),
             child: Padding(
                 padding: const EdgeInsets.fromLTRB(0, 200.0, 0, 0),
                 child:Column(

                   children: <Widget>[
                     FlatButton.icon(
                         onPressed: () async{
                           dynamic result = await Navigator.pushNamed(context, '/location');
                            setState(() {
                              data = {
                                'time' : result['time'],
                                 'location' : result['location'],
                                 'isDayTime' : result['isDayTime'],
                                 'flag' : result['flag']
                              };
                            });
                         },
                         icon:   Icon(Icons.edit_location,
                         color: editLocationColor,),
                         label: Text('Edit Location',
                         style: TextStyle(
                           color: editLocationColor
                         ),)),
                     const SizedBox(height: 20.0),
                     Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children:<Widget>[
                           Text(data['location'],
                             style: const TextStyle(
                               fontSize: 28.0,
                               letterSpacing: 2.0,
                               color: Colors.white
                             ),),

                         ]),
                     const SizedBox(height: 20.0,),
                     Text(data['time'],
                     style: const TextStyle(
                       fontSize: 60.0,
                         color: Colors.white
                     ),)
                   ],
                 )
             ),
           )

         ),
       );
  }

}