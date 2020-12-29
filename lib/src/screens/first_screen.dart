import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String defineWeatherState (int index) {
    String weatherStateIcon = listElement[index].weather[0].icon.toString();
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
    return weatherState;
  }

  Row generateRow(int i) {
    String time = listElement[i].dtTxt.toString().split(" ")[1].split(".")[0];
    String temperature = (listElement[i].main.temp - 273.15).toStringAsPrecision(2) + '\u00B0C';
    String description = listElement[i].weather[0].description.toString();
    String weatherState = defineWeatherState(i);
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
                  Text(time.split(':')[0] + ':' + time.split(':')[1], style:
                    TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                  Text(description, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 17)),
                ]),
            Container(child: Text(temperature, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.pink, fontSize: 30), textAlign: TextAlign.right)),
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
        width: MediaQuery.of(context).size.width,
          height: 0.125 * MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              border: gVars.tappedIndex != index
                  ? Border.all(color: Colors.black12)
                  : Border.all(color: Colors.pink)),
          child: generateWeatherRows()[index]),
      onTap: () {
        gVars.tappedIndex = index;
        if (stateIndex == 0) {
          stateIndex = 1;
          BlocProvider.of<MainCubit>(
              context)
              .toFirstScreen();
        } else {
          print(
              'you are already on that screen');
        }
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
    //    normally i'd make request using this apiStr below, but something is wrong with getting locality, it is just an empty string in 99% of project runs. so i simply put Minsk in the city parameter of my request
    //          String apiStr = 'https://api.openweathermap.org/data/2.5/forecast?q=' + currentCity.toString() + '&cnt=40&appid=78cdfa458cf0d880d857d4b558dd9286';
    //          response = await dio.get(apiStr);
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

  String getDiraction() {
    if (listElement[gVars.tappedIndex].wind.deg <= 22.5 || listElement[gVars.tappedIndex].wind.deg > 337.5) {
      return 'N';
    } else if (listElement[gVars.tappedIndex].wind.deg > 22.5 && listElement[gVars.tappedIndex].wind.deg <= 67.5) {
      return 'NW';
    } else if(listElement[gVars.tappedIndex].wind.deg > 67.5 && listElement[gVars.tappedIndex].wind.deg <= 112.5) {
      return 'W';
    } else if (listElement[gVars.tappedIndex].wind.deg > 112.5 && listElement[gVars.tappedIndex].wind.deg <= 157.5) {
      return 'SW';
    } else if (listElement[gVars.tappedIndex].wind.deg > 157.5 && listElement[gVars.tappedIndex].wind.deg <= 202.5) {
      return 'S';
    } else if (listElement[gVars.tappedIndex].wind.deg > 202.5 && listElement[gVars.tappedIndex].wind.deg <= 247.5) {
      return 'SE';
    } else if (listElement[gVars.tappedIndex].wind.deg > 247.5 && listElement[gVars.tappedIndex].wind.deg <= 292.5) {
      return 'E';
    } else if (listElement[gVars.tappedIndex].wind.deg > 292.5 && listElement[gVars.tappedIndex].wind.deg <= 337.5) {
      return 'NE';
    }
    return ' ';
    }

  _showThatCopied() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(milliseconds: 250), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Text('Copied to clipboard', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.pink)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder <List<ListElement>>(
          future: getListElement(),
          builder: (context, listE) {
            if (listE.connectionState == ConnectionState.none ||
                listE.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.pink))));
            } else {
              return Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
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
                            height: 0.1 * MediaQuery
                                .of(context)
                                .size
                                .height,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: BoxDecoration(
                                border:
                                Border(bottom: BorderSide(color: Colors
                                    .black))),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  stateIndex == 0
                                      ? (
                                      _currentPosition != null &&
                                          currentCity != null ? (Container(
                                        child: Text(
                                            currentCity + currentCountry,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20)),
                                      ))
                                          : Container(
                                        child: Text(
                                            'Could not get your address',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20)),
                                      ))
                                      : Container(
                                    child: Text(
                                        listElement[gVars.tappedIndex].dtTxt
                                            .toString().split(':')[0] + ':' +
                                            listElement[gVars.tappedIndex].dtTxt
                                                .toString().split(':')[1],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 23, fontStyle: FontStyle.italic)),
                                  )
                                ])),
                        if (stateIndex == 0) Container(
                            height: 0.8 * MediaQuery
                                .of(context)
                                .size
                                .height,
                            child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Colors.pink[100],
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      child: Text('Today', style: TextStyle(
                                          fontSize: 17,
                                          fontStyle: FontStyle.italic),
                                          textAlign: TextAlign.left),
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
                                      color: Colors.pink[100],
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      child: Text(
                                          listElement[gVars.todayK + 1].dtTxt
                                              .toString().split(" ")[0],
                                          style: TextStyle(fontSize: 17,
                                              fontStyle: FontStyle.italic),
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
                                      color: Colors.pink[100],
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      child: Text(
                                          listElement[gVars.todayK + 9].dtTxt
                                              .toString().split(" ")[0],
                                          style: TextStyle(fontSize: 17,
                                              fontStyle: FontStyle.italic),
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
                                      color: Colors.pink[100],
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      child: Text(
                                          listElement[gVars.todayK + 17].dtTxt
                                              .toString().split(" ")[0],
                                          style: TextStyle(fontSize: 17,
                                              fontStyle: FontStyle.italic),
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
                                      color: Colors.pink[100],
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      child: Text(
                                          listElement[gVars.todayK + 25].dtTxt
                                              .toString().split(" ")[0],
                                          style: TextStyle(fontSize: 17,
                                              fontStyle: FontStyle.italic),
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
                                ))) else
                          Container(
                              height: 0.8 * MediaQuery
                                  .of(context)
                                  .size
                                  .height,
                              child: Column(children: [
                                Container(
                                    height:
                                    0.3 * MediaQuery
                                        .of(context)
                                        .size
                                        .height,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        Image.asset(
                                            weatherStateImgPath +
                                                defineWeatherState(
                                                    gVars.tappedIndex) +
                                                '.png'),
                                        if (_currentPosition != null &&
                                            currentCity != null)
                                          Text(currentCity + currentCountry,
                                              style: TextStyle(fontSize: 17,
                                                  fontStyle: FontStyle.italic)),
                                        Text(
                                            (listElement[gVars.tappedIndex].main
                                                .temp - 273.15)
                                                .toStringAsPrecision(2) +
                                                '\u00B0C  |  ' +
                                                listElement[gVars.tappedIndex].weather[0].description,
                                            style: TextStyle(fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.pink))
                                      ],
                                    )),
                                Container(
                                    height:
                                    0.3 * MediaQuery
                                        .of(context)
                                        .size
                                        .height,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
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
                                                      Text('Humidity',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              color: Colors
                                                                  .pink)),
                                                      Text(listElement[gVars
                                                          .tappedIndex].main
                                                          .humidity.toString() +
                                                          '%', style: TextStyle(
                                                          fontSize: 20,
                                                          fontStyle: FontStyle
                                                              .italic))
                                                    ])),
                                                Container(
                                                    child: Column(children: [
                                                      Text('Rainfall',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              color: Colors
                                                                  .pink)),

                                                      Text(listElement[gVars
                                                          .tappedIndex].rain !=
                                                          null
                                                          ? (listElement[gVars
                                                          .tappedIndex].rain
                                                          .the3H.toString() +
                                                          ' mm')
                                                          :
                                                      '0 mm', style: TextStyle(
                                                          fontSize: 20,
                                                          fontStyle: FontStyle
                                                              .italic))
                                                    ])),
                                                Container(
                                                    child: Column(children: [
                                                      Text('Pressure',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              color: Colors
                                                                  .pink)),
                                                      Text(listElement[gVars
                                                          .tappedIndex].main
                                                          .pressure.toString() +
                                                          ' hPa',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontStyle: FontStyle
                                                                  .italic)),
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
                                                      Text('Wind',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              color: Colors
                                                                  .pink)),
                                                      Text(listElement[gVars
                                                          .tappedIndex].wind
                                                          .speed.toString() +
                                                          ' km/h',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontStyle: FontStyle
                                                                  .italic))
                                                    ])),
                                                Container(
                                                    child: Column(children: [
                                                      Text('Direction',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              color: Colors
                                                                  .pink)),
                                                      Text(getDiraction(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontStyle: FontStyle
                                                                  .italic)),
                                                    ]))
                                              ])
                                        ])),
                                Container(
                                    width: 66.0 * 1.5,
                                    height: 32.0 * 1.5,
                                    child: ConstrainedBox(
                                        constraints: BoxConstraints.expand(),
                                        child: RaisedButton(
                                            shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
                                            onPressed: () {
                                              print('shared');
                                              Clipboard.setData(ClipboardData(text: 'Weather forecast on ' + listElement[gVars.tappedIndex].dtTxt.toString().split(':')[0] + ':' + listElement[gVars.tappedIndex].dtTxt.toString().split(':')[1] + '\n' +
                                                  'temperature is ' + (listElement[gVars.tappedIndex].main.temp - 273.15).toStringAsPrecision(2) + 'degrees celsius;\n' +
                                                  'pressure is ' + listElement[gVars.tappedIndex].main.pressure.toString() + ' hPa;\n' +
                                                  'humidity is ' + listElement[gVars.tappedIndex].main.humidity.toString() + ' %;\n' +
                                                  'rainfall is ' + (listElement[gVars.tappedIndex].rain != null ? (listElement[gVars.tappedIndex].rain.the3H.toString() + ' mm') : '0 mm') + ';\n' +
                                                  'wind is ' + listElement[gVars.tappedIndex].wind.speed.toString() + 'km/h with ' + getDiraction() + ' direction.'));
                                              _showThatCopied();
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: Text('share', style: TextStyle(fontStyle: FontStyle.italic))))),
                              ])),
                        Container(
                          height: 0.1 * MediaQuery
                              .of(context)
                              .size
                              .height,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                              border: Border(top: BorderSide(color: Colors
                                  .black))),
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
                                          shape: RoundedRectangleBorder(side: BorderSide(color: stateIndex == 1 ? (Colors.pink) : (Colors.black))),
                                          onPressed: () {
                                            print('1st button pressed');
                                            if (stateIndex == 0) {
                                              stateIndex = 1;
                                              BlocProvider.of<MainCubit>(
                                                  context)
                                                  .toFirstScreen();
                                            } else {
                                              print(
                                                  'you are already on that screen');
                                            }
                                          },
                                          padding: EdgeInsets.all(0.0),
                                          child: (Text('details', style: TextStyle(fontStyle: FontStyle.italic, color: stateIndex == 1 ? (Colors.pink): (Colors.black))))))),
                              Container(
                                  width: 66.0 * 1.5,
                                  height: 32.0 * 1.5,
                                  child: ConstrainedBox(
                                      constraints: BoxConstraints.expand(),
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(side: BorderSide(color: stateIndex == 0 ? (Colors.pink) : (Colors.black))),
                                          onPressed: () {
                                            print('2nd button pressed');
                                            if (stateIndex == 1) {
                                              stateIndex = 0;
                                              BlocProvider.of<MainCubit>(
                                                  context)
                                                  .toFirstScreen();
                                            } else {
                                              print(
                                                  'you are already on that screen');
                                            }
                                          },
                                          padding: EdgeInsets.all(0.0),
                                          child: (Text('forecast', style: TextStyle(fontStyle: FontStyle.italic, color: stateIndex == 0 ? (Colors.pink) : (Colors.black))))))),
                            ],
                          ),
                        ),
                      ]));
            }
          },
        )
      );
  }
}
