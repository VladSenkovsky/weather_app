import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/blocs/main_bloc/main_cubit.dart';
import 'package:weather_app/globals.dart';
import 'package:geolocator/geolocator.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

int stateIndex = 0;
GVars gVars = new GVars();

class _FirstScreenState extends State<FirstScreen> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;

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
        _currentAddress = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  String weatherStateImgPath = 'images/weather_states/';

  Row generateRow(String weatherState, String time, String temperature) {
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
                  Text(weatherState),
                ]),
            Container(child: Text(temperature, textAlign: TextAlign.right)),
          ]))),
    ]);
  }

  List<Widget> generateWeatherRows() {
    List<Widget> rows = List();
    //today
    rows.add(generateRow('rain', '00:00', 'Temp1'));
    rows.add(generateRow('snow', '03:00', 'Temp2'));
    rows.add(generateRow('cloudy', '06:00', 'Temp3'));
    rows.add(generateRow('day_clear', '09:00', 'Temp4'));
    rows.add(generateRow('day_cloudy', '12:00', 'Temp5'));
    rows.add(generateRow('lightning', '15:00', 'Temp6'));
    rows.add(generateRow('night_clear', '18:00', 'Temp7'));
    rows.add(generateRow('night_cloudy', '21:00', 'Temp8'));
    //1 day ahead
    rows.add(generateRow('rain', '00:00', 'Temp1'));
    rows.add(generateRow('snow', '03:00', 'Temp2'));
    rows.add(generateRow('cloudy', '06:00', 'Temp3'));
    rows.add(generateRow('day_clear', '09:00', 'Temp4'));
    rows.add(generateRow('day_cloudy', '12:00', 'Temp5'));
    rows.add(generateRow('lightning', '15:00', 'Temp6'));
    rows.add(generateRow('night_clear', '18:00', 'Temp7'));
    rows.add(generateRow('night_cloudy', '21:00', 'Temp8'));
    //2 days ahead
    rows.add(generateRow('rain', '00:00', 'Temp1'));
    rows.add(generateRow('snow', '03:00', 'Temp2'));
    rows.add(generateRow('cloudy', '06:00', 'Temp3'));
    rows.add(generateRow('day_clear', '09:00', 'Temp4'));
    rows.add(generateRow('day_cloudy', '12:00', 'Temp5'));
    rows.add(generateRow('lightning', '15:00', 'Temp6'));
    rows.add(generateRow('night_clear', '18:00', 'Temp7'));
    rows.add(generateRow('night_cloudy', '21:00', 'Temp8'));
    //3 days ahead
    rows.add(generateRow('rain', '00:00', 'Temp1'));
    rows.add(generateRow('snow', '03:00', 'Temp2'));
    rows.add(generateRow('cloudy', '06:00', 'Temp3'));
    rows.add(generateRow('day_clear', '09:00', 'Temp4'));
    rows.add(generateRow('day_cloudy', '12:00', 'Temp5'));
    rows.add(generateRow('lightning', '15:00', 'Temp6'));
    rows.add(generateRow('night_clear', '18:00', 'Temp7'));
    rows.add(generateRow('night_cloudy', '21:00', 'Temp8'));
    // 4 days ahead
    rows.add(generateRow('rain', '00:00', 'Temp1'));
    rows.add(generateRow('snow', '03:00', 'Temp2'));
    rows.add(generateRow('cloudy', '06:00', 'Temp3'));
    rows.add(generateRow('day_clear', '09:00', 'Temp4'));
    rows.add(generateRow('day_cloudy', '12:00', 'Temp5'));
    rows.add(generateRow('lightning', '15:00', 'Temp6'));
    rows.add(generateRow('night_clear', '18:00', 'Temp7'));
    rows.add(generateRow('night_cloudy', '21:00', 'Temp8'));
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
    //today
    inkWells.add(generateInkWell(0));
    inkWells.add(generateInkWell(1));
    inkWells.add(generateInkWell(2));
    inkWells.add(generateInkWell(3));
    inkWells.add(generateInkWell(4));
    inkWells.add(generateInkWell(5));
    inkWells.add(generateInkWell(6));
    inkWells.add(generateInkWell(7));
    //1 day ahead
    inkWells.add(generateInkWell(8));
    inkWells.add(generateInkWell(9));
    inkWells.add(generateInkWell(10));
    inkWells.add(generateInkWell(11));
    inkWells.add(generateInkWell(12));
    inkWells.add(generateInkWell(13));
    inkWells.add(generateInkWell(14));
    inkWells.add(generateInkWell(15));
    //2 days ahead
    inkWells.add(generateInkWell(16));
    inkWells.add(generateInkWell(17));
    inkWells.add(generateInkWell(18));
    inkWells.add(generateInkWell(19));
    inkWells.add(generateInkWell(20));
    inkWells.add(generateInkWell(21));
    inkWells.add(generateInkWell(22));
    inkWells.add(generateInkWell(23));
    //3 days ahead
    inkWells.add(generateInkWell(24));
    inkWells.add(generateInkWell(25));
    inkWells.add(generateInkWell(26));
    inkWells.add(generateInkWell(27));
    inkWells.add(generateInkWell(28));
    inkWells.add(generateInkWell(29));
    inkWells.add(generateInkWell(30));
    inkWells.add(generateInkWell(31));
    //4 days ahead
    inkWells.add(generateInkWell(32));
    inkWells.add(generateInkWell(33));
    inkWells.add(generateInkWell(34));
    inkWells.add(generateInkWell(35));
    inkWells.add(generateInkWell(36));
    inkWells.add(generateInkWell(37));
    inkWells.add(generateInkWell(38));
    inkWells.add(generateInkWell(39));
    return inkWells;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                                ? (Container(
                                    child: Text('Current location',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
                                  ))
                                : Container(
                                    child: Text('Chosen day',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
                                  )
                          ])),
                  stateIndex == 0
                      ? (Container(
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
                                    generateInkWells()[1],
                                    generateInkWells()[2],
                                    generateInkWells()[3],
                                    generateInkWells()[4],
                                    generateInkWells()[5],
                                    generateInkWells()[6],
                                    generateInkWells()[7],
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text('1 day ahead',
                                    textAlign: TextAlign.left),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    generateInkWells()[8],
                                    generateInkWells()[9],
                                    generateInkWells()[10],
                                    generateInkWells()[11],
                                    generateInkWells()[12],
                                    generateInkWells()[13],
                                    generateInkWells()[14],
                                    generateInkWells()[15],
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text('2 days ahead',
                                    textAlign: TextAlign.left),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    generateInkWells()[16],
                                    generateInkWells()[17],
                                    generateInkWells()[18],
                                    generateInkWells()[19],
                                    generateInkWells()[20],
                                    generateInkWells()[21],
                                    generateInkWells()[22],
                                    generateInkWells()[23],
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text('3 days ahead',
                                    textAlign: TextAlign.left),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    generateInkWells()[24],
                                    generateInkWells()[25],
                                    generateInkWells()[26],
                                    generateInkWells()[27],
                                    generateInkWells()[28],
                                    generateInkWells()[29],
                                    generateInkWells()[30],
                                    generateInkWells()[31],
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text('4 days ahead',
                                    textAlign: TextAlign.left),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    generateInkWells()[32],
                                    generateInkWells()[33],
                                    generateInkWells()[34],
                                    generateInkWells()[35],
                                    generateInkWells()[36],
                                    generateInkWells()[37],
                                    generateInkWells()[38],
                                    generateInkWells()[39],
                                  ],
                                ),
                              ),
                            ],
                          ))))
                      : Container(
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
                                        _currentAddress != null)
                                      Text(_currentAddress),
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
                                              Text('50' + ' %')
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
                ])));
  }
}
