import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime{

  late String location; // location name for UI
  late String time; // time in that location
  late String flag; // url to flag icon
  late String url; // location url for api end point
   bool isDayTime = true;// is Day time or Night time

  WorldTime({
       required this.location,
       required this.flag,
       required this.url,

  });

    Future<void> getTime() async {
      try{
        //Make the request
        var api = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
        http.Response response = await http.get(api);

        Map data = jsonDecode(response.body);
        String dateTime = data['datetime'];
         String offset = data['utc_offset'].substring(2,3);
        DateTime now = DateTime.parse(dateTime);

         var realTime = now.add(Duration(hours: int.parse(offset)));

        // set to time property
        time = DateFormat.jm().format(realTime);

        isDayTime =realTime.hour>6 && realTime.hour < 18 ? true:false;
      }
      catch(e)
      {
         print('caught error : $e');
         time='could not get time data';
      }


  }
}


