import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


   void setupWorldTime() async {
     WorldTime instance = WorldTime(location: 'Yangon', flag: 'Myanmar.png', url: 'Asia/Yangon');
     await instance.getTime();

     Navigator.pushReplacementNamed(context,'/home',arguments:{
       'location' : instance.location,
       'time' : instance.time,
       'flag' : instance.flag,
       'isDayTime' : instance.isDayTime
     });

  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
          child: SpinKitRing(
            color: Colors.white,
            size: 50.0,
          ),
      ),
    );
  }
}
