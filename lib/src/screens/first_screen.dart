import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/blocs/main_bloc/main_cubit.dart';
import 'package:weather_app/globals.dart';
import 'package:weather_app/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

int stateIndex = 0;
GVars gVars = new GVars();

class _FirstScreenState extends State<FirstScreen> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String currentCountry;
  String currentCity;
  List<ListElement> listElement = new List<ListElement>(40);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      setState(() {
        currentCountry = "${place.country}";
        currentCity = "${place.locality}";
      });
    } catch (e) {
      print(e);
    }
  }

  String weatherStateImgPath = 'images/weather_states/';

  Row generateRow(int i) {
    String weatherStateIcon = listElement[i].weather[0].icon.toString();
    String time = listElement[i].dtTxt.toString().split(" ")[1].split(".")[0];
    String temperature = (listElement[i].main.temp - 273.15).toStringAsPrecision(2) + '\u00B0C';
    String description = listElement[i].weather[0].description.toString();
    String weatherState = '';
    if (weatherStateIcon == '11d' || weatherStateIcon == '11n') {
      weatherState = 'lightning';
    } else if (weatherStateIcon == '09d' || weatherStateIcon == '10d' || weatherStateIcon == '09n' || weatherStateIcon == '10n') {
      weatherState = 'rain';
    } else if (weatherStateIcon == '13d'  || weatherStateIcon == '13n') {
      weatherState = 'snow';
    } else if (weatherStateIcon == '50d' || weatherStateIcon == '50n') {
      weatherState == 'mist';
    } else if (weatherStateIcon == '04d' || weatherStateIcon == '04n' || weatherStateIcon == '03d' || weatherStateIcon == '03n') {
      weatherState = 'cloudy';
    } else if (weatherStateIcon == '01d') {
      weatherState = 'day_clear';
    } else if (weatherStateIcon == '01n') {
      weatherState ='night_clear';
    } else if (weatherStateIcon == '02d') {
      weatherState = 'day_cloudy';
    } else if (weatherStateIcon == '02n') {
      weatherState = 'night_cloudy';
    }
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Image.asset(weatherStateImgPath + weatherState + '.png'),
      Container(
          child: Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(time),
                  Text(description),
                ]),
            Container(child: Text(temperature, textAlign: TextAlign.right)),
          ]))),
    ]);
  }

  List<Widget> generateWeatherRows() {
    List<Widget> rows = List();
    for(int i = 0; i < 40; i++) {
      rows.add(generateRow(i));
    }
    return rows;
  }

  InkWell generateInkWell(int index) {
    return InkWell(
      child: Container(
          decoration: BoxDecoration(
              border: gVars.tappedIndex != index
                  ? Border.all(color: Colors.black12)
                  : Border.all(color: Colors.pink)),
          child: generateWeatherRows()[index]),
      onTap: () {
        gVars.tappedIndex = index;
        BlocProvider.of<MainCubit>(context).toFirstScreen();
      },
    );
  }

  List<Widget> generateInkWells() {
    List<Widget> inkWells = List();
    for (int i = 0; i < 40; i++) {
      inkWells.add(generateInkWell(i));
    }
    return inkWells;
  }

  List<Widget> generateInkWellsForToday() {
    List<Widget> inkWells = List();
    for (int i = 0; i < 8 - gVars.todayK; i++) {
      inkWells.add(generateInkWell(i));
    }
    return inkWells;
  }
  Future<List<ListElement>> getListElement () async {
    Response response;
    Dio dio = new Dio();
    String apiStr = 'https://api.openweathermap.org/data/2.5/forecast?q=' + currentCity.toString() + '&cnt=40&appid=78cdfa458cf0d880d857d4b558dd9286';
    print(apiStr);
    response = await dio.get('https://api.openweathermap.org/data/2.5/forecast?q=Minsk&cnt=40&appid=78cdfa458cf0d880d857d4b558dd9286');
        if(response.statusCode == 200) {
          for (int i = 0; i < 40; i++) {
            listElement[i] = ListElement.fromJson(response.data['list'][i]);
            print(response.data['list'][i]);
          }
          String tempDate = listElement[0].dtTxt.toString();
          var splitted = tempDate.split(" ");
          print(splitted[1]);
          if (splitted[1] == '00:00:00.000') {
            gVars.todayK = 7;
          } else if (splitted[1] == '03:00:00.000') {
            gVars.todayK = 6;
          } else if (splitted[1] == '06:00:00.000') {
            gVars.todayK = 5;
          } else if (splitted[1] == '09:00:00.000') {
            gVars.todayK = 4;
          } else if (splitted[1] == '12:00:00.000') {
            gVars.todayK = 3;
          } else if (splitted[1] == '15:00:00.000') {
            gVars.todayK = 2;
          } else if (splitted[1] == '18:00:00.000') {
            gVars.todayK = 1;
          } else if (splitted[1] == '21:00:00.000') {
            gVars.todayK = 0;
          }
       return listElement;
    } else {
    print("Invalid data");
    }
        return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder <List<ListElement>>(
          future: getListElement(),
          builder: (context, listE) {
            return  Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  color: Colors.white70,
                ),
                padding: EdgeInsets.all(0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 0.1 * MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border:
                              Border(bottom: BorderSide(color: Colors.black))),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                stateIndex == 0
                                    ? (
                                    _currentPosition != null &&
                                        currentCity != null ? (Container(
                                      child: Text(currentCity + currentCountry,
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 20)),
                                    ))
                                        : Container(
                                      child: Text('Could not get your address',
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 20)),
                                    ))
                                    : Container(
                                  child: Text(listElement[gVars.tappedIndex].dtTxt.toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                )
                              ])),
                      if (stateIndex == 0) Container(
                          height: 0.8 * MediaQuery.of(context).size.height,
                          child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text('Today', textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        generateInkWells()[0],
                                        if (gVars.todayK > 0)
                                          generateInkWells()[1],
                                            if (gVars.todayK > 1)
                                              generateInkWells()[2],
                                                if (gVars.todayK > 2)
                                                  generateInkWells()[3],
                                                  if(gVars.todayK > 3)
                                                  generateInkWells()[4],
                                                    if(gVars.todayK > 4)
                                                  generateInkWells()[5],
                                                      if(gVars.todayK > 5)
                                                  generateInkWells()[6],
                                                        if(gVars.todayK > 6)
                                                          generateInkWells()[7],
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(listElement[gVars.todayK + 1].dtTxt.toString().split(" ")[0],
                                        textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        generateInkWells()[gVars.todayK + 1],
                                        generateInkWells()[gVars.todayK + 2],
                                        generateInkWells()[gVars.todayK + 3],
                                        generateInkWells()[gVars.todayK + 4],
                                        generateInkWells()[gVars.todayK + 5],
                                        generateInkWells()[gVars.todayK + 6],
                                        generateInkWells()[gVars.todayK + 7],
                                        generateInkWells()[gVars.todayK + 8],
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(listElement[gVars.todayK + 9].dtTxt.toString().split(" ")[0],
                                        textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        generateInkWells()[gVars.todayK + 9],
                                        generateInkWells()[gVars.todayK + 10],
                                        generateInkWells()[gVars.todayK + 11],
                                        generateInkWells()[gVars.todayK + 12],
                                        generateInkWells()[gVars.todayK + 13],
                                        generateInkWells()[gVars.todayK + 14],
                                        generateInkWells()[gVars.todayK + 15],
                                        generateInkWells()[gVars.todayK + 16],
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(listElement[gVars.todayK + 17].dtTxt.toString().split(" ")[0],
                                        textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        generateInkWells()[gVars.todayK + 17],
                                        generateInkWells()[gVars.todayK + 18],
                                        generateInkWells()[gVars.todayK + 19],
                                        generateInkWells()[gVars.todayK + 20],
                                        generateInkWells()[gVars.todayK + 21],
                                        generateInkWells()[gVars.todayK + 22],
                                        generateInkWells()[gVars.todayK + 23],
                                        generateInkWells()[gVars.todayK + 24],
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(listElement[gVars.todayK + 25].dtTxt.toString().split(" ")[0],
                                        textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        generateInkWells()[gVars.todayK + 25],
                                        generateInkWells()[gVars.todayK + 26],
                                        generateInkWells()[gVars.todayK + 27],
                                        generateInkWells()[gVars.todayK + 28],
                                        generateInkWells()[gVars.todayK + 29],
                                        generateInkWells()[gVars.todayK + 30],
                                        generateInkWells()[gVars.todayK + 31],
                                        generateInkWells()[gVars.todayK + 32],
                                      ],
                                    ),
                                  ),
                                ],
                              ))) else Container(
                          height: 0.8 * MediaQuery.of(context).size.height,
                          child: Column(children: [
                            Container(
                                height:
                                0.3 * MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        'images/weather_states/day_clear.png'),
                                    if (_currentPosition != null &&
                                        currentCity != null)
                                      Text(currentCity + currentCountry),
                                    Text('Temperature  ||  Weather state')
                                  ],
                                )),
                            Container(
                                height:
                                0.3 * MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                    child: Column(children: [
                                                      Text('Humidity'),
                                                      Text('50' + '%')
                                                    ])),
                                            Container(
                                                child: Column(children: [
                                                  Text('Rainfall'),
                                                  Text('2' + ' mm'),
                                                ])),
                                            Container(
                                                child: Column(children: [
                                                  Text('Pressure'),
                                                  Text('1000' + ' hPa'),
                                                ])),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                child: Column(children: [
                                                  Text('Wind'),
                                                  Text('10' + ' km/h')
                                                ])),
                                            Container(
                                                child: Column(children: [
                                                  Text('Direction'),
                                                  Text('N'),
                                                ]))
                                          ])
                                    ])),
                            Container(
                                width: 66.0 * 1.5,
                                height: 32.0 * 1.5,
                                child: ConstrainedBox(
                                    constraints: BoxConstraints.expand(),
                                    child: RaisedButton(
                                        onPressed: () {
                                          print('shared');
                                          BlocProvider.of<MainCubit>(context)
                                              .toFirstScreen();
                                        },
                                        padding: EdgeInsets.all(0.0),
                                        child: Text('share')))),
                          ])),
                      Container(
                        height: 0.1 * MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.black))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 66.0 * 1.5,
                                height: 32.0 * 1.5,
                                child: ConstrainedBox(
                                    constraints: BoxConstraints.expand(),
                                    child: RaisedButton(
                                        onPressed: () {
                                          print('1st button pressed');
                                          if (stateIndex == 0) {
                                            stateIndex = 1;
                                            BlocProvider.of<MainCubit>(context)
                                                .toFirstScreen();
                                          } else {
                                            print('you are already on that screen');
                                          }
                                        },
                                        padding: EdgeInsets.all(0.0),
                                        child: Text('details')))),
                            Container(
                                width: 66.0 * 1.5,
                                height: 32.0 * 1.5,
                                child: ConstrainedBox(
                                    constraints: BoxConstraints.expand(),
                                    child: RaisedButton(
                                        onPressed: () {
                                          print('2nd button pressed');
                                          if (stateIndex == 1) {
                                            stateIndex = 0;
                                            BlocProvider.of<MainCubit>(context)
                                                .toFirstScreen();
                                          } else {
                                            print('you are already on that screen');
                                          }
                                        },
                                        padding: EdgeInsets.all(0.0),
                                        child: Text('forecast')))),
                          ],
                        ),
                      ),
                    ]));
          },
        )
      );
  }
}
