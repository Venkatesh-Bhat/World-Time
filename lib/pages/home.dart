import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    //Receiving info from loading page    is instantiated every time project builds
    //if we are getting info from choose_location then it gets overwritten hence we use ternary operator
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    // print(data);
    String bgImage = data['isDaytime'] ? 'day1.jpg':'night.jpg';
    Color? bgColor = data['isDaytime'] ? Colors.blueGrey[900]:Colors.indigo[900];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image:DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.fill
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0,120.0,0.0,0.0),
            child: Column(
              children: [
                TextButton.icon(
                    onPressed: () async{
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'location':result['location'],
                          'flag':result['flag'],
                          'time':result['time'],
                          'isDaytime':result['isDaytime']
                        };
                      });
                    },
                    icon: Icon(
                        Icons.add_location,
                        color: Colors.grey[200],
                    ),
                    label: Text(
                        "Location",
                        style: TextStyle(
                          color: Colors.grey[200]
                        ),
                    )
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style:const TextStyle(
                        fontSize: 30.0,
                        letterSpacing: 2.0,
                        color: Colors.white
                      )
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: const TextStyle(
                    fontSize: 60.0,
                    color: Colors.white
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
