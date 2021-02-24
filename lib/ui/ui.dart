import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../util/util.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:weather_icons/weather_icons.dart';


class Climatic extends StatelessWidget {

  void showStuff() async {
    Map data = await getWeather(appId, defaultCity);
    print(data.toString());
  }

  

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      
      home: Scaffold(
      appBar: new AppBar(
        leading: VStack([
          VxBox().size(20, 2).white.make(),
          5.heightBox,
          VxBox().size(28, 2).white.make(),
          5.heightBox,
          VxBox().size(15, 2).white.make(),
        ]).pOnly(left: 16, top: 16),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search), onPressed: () => debugPrint("Hey"))
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'assets\images\photo.jpeg',
              width: 590.0,
            height: 4200.0,
            fit: BoxFit.fill,
            )
            
          ),
        
        new Container(
          alignment: Alignment.topRight,
          margin: const EdgeInsets.fromLTRB(0.0, 18.0, 10.0, 0.0),
          child: new Text('Jabalpur', style: cityStyle()),
        ),

new Container(
          
          child: new IconButton(
              icon: BoxedIcon(WeatherIcons.day_rain),
              padding: EdgeInsets.fromLTRB(60.0, 150.0, 0.0, 0.0),
              iconSize: 99.9,
              color: Colors.redAccent,
              onPressed: () {},
            ),
        ),


        new Container(
          
          margin: const EdgeInsets.fromLTRB(30.0, 260.9, 0.0, 0.0),
          child: new Text('67.8F', style: tempStyle()),
        ),
        
        new Container(
          
          margin: const EdgeInsets.fromLTRB(30.0, 330.9, 0.0, 0.0),
          child: new Text('Humidity : 73%', style: detailStyle()),
        ),
        new Container(
          
          margin: const EdgeInsets.fromLTRB(30.0, 310.9, 0.0, 0.0),
          child: new Text('Showers', style: detailStyle()),
        ),
        ],
      )
    ),
    debugShowCheckedModeBanner: false,);
  }

TextStyle detailStyle() {
    return new TextStyle(
      color: Colors.redAccent,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 19.9,
    );
  }
  TextStyle tempStyle() {
    return new TextStyle(
      color: Colors.redAccent,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 39.9,
    );
  }
TextStyle cityStyle() {
    return new TextStyle(
      color: Colors.redAccent,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w500,
      fontSize: 29.9,
    );
  }
  Future<Map> getWeather(String appId, String city) async {
    String apiUrl = 'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appId';
        
    http.Response response = await http.get(Uri.dataFromString(apiUrl));

    return json.decode(response.body);
  }

  Widget updateTempWidget(String city) {
    return new FutureBuilder(
      future: getWeather(appId, city),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {

        if (snapshot.hasData) {
          Map content = snapshot.data;
          return new Container(
            child: new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(content['main']['temp'].toString(),
                  style: new TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 49.9,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                  ),
                )
              ],
            ),
          );
        }
        else {
          return new Container();
        }
      }
      );
  }

}