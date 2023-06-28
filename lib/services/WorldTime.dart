import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime {
  late String location;
  late String time;
  late String flag;
  late String url;
  late bool isDaytime;
  WorldTime( {required this.location,required this.flag,required this.url});
  Future<void> getTime() async {
    try{
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
  // print(data);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0,3);
  // print(datetime);
  //     print(offset);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //b/w 6am and 8pm then day time, else its night
      isDaytime = now.hour>6 && now.hour<20 ? true:false;
      //Time format
      time = DateFormat.jm().format(now);
  // print(now);
    }

    catch(e){
      // print('Error Caught:$e');
      time = 'Error loading:$e';
    }
  }
}