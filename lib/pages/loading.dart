import 'package:flutter/material.dart';
import 'package:world_time/services/WorldTime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  //PRACTICE
  // void getData() async{
  //   //place the endpoint in get() method
  //   Response response = await get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
  //   print(response.body);
  //   //To convert json data to Map use jsonDecode, by default json data is a string
  //   Map data = jsonDecode(response.body);
  //   print(data);
  //   print(data['title']);
  //
  // }
  void setupWorldTime() async{
  WorldTime instance = WorldTime(location: "London", flag: "germany.png", url: "Europe/Berlin");
  await instance.getTime();
  // setState(() {
  //   time = instance.time;
  // });

    //argument parameter is used to send info from one page to another
    //Replacement is used to replace current page
    Navigator.pushReplacementNamed(context, '/home',arguments: {
        'location':instance.location,
        'flag':instance.flag,
        'time':instance.time,
        'isDaytime':instance.isDaytime
    });
  }


  @override
  void initState(){
    super.initState();
    // getData();
    // getTime();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body:Center(
        child:const SpinKitPouringHourGlass(
          color: Colors.white,
          size: 80.0,
        ),
      )
    );
  }
}
