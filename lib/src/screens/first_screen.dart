import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/blocs/main_bloc/main_cubit.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

int stateIndex = 0;

class _FirstScreenState extends State<FirstScreen> {
  String weatherStateImgPath = 'images/weather_states/';

  Row generateRow(String weatherState, String time, String temperature) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
      Image.asset(weatherStateImgPath + weatherState + '.jpg'),
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
            Container(
            child: Text(temperature, textAlign: TextAlign.right)
            ),
          ]))),
    ]);
  }

  List<Widget> generateWeatherRows() {
    List<Widget> rows = List();
    rows.add(generateRow('temp', '00:00', 'Temp1'));
    rows.add(generateRow('temp', '03:00', 'Temp2'));
    rows.add(generateRow('temp', '06:00', 'Temp3'));
    rows.add(generateRow('temp', '09:00', 'Temp4'));
    rows.add(generateRow('temp', '12:00', 'Temp5'));
    rows.add(generateRow('temp', '15:00', 'Temp6'));
    rows.add(generateRow('temp', '18:00', 'Temp7'));
    rows.add(generateRow('temp', '21:00', 'Temp8'));
    return rows;
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
                            stateIndex == 0 ?(
                            Container(
                              child: Text('Current location',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            )) :
                                Container (
                                  child: Text('Chosen day',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                )
                          ])),
                  stateIndex == 0 ? (
                  Container(
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
                                generateWeatherRows()[0],
                                generateWeatherRows()[1],
                                generateWeatherRows()[2],
                                generateWeatherRows()[3],
                                generateWeatherRows()[4],
                                generateWeatherRows()[5],
                                generateWeatherRows()[6],
                                generateWeatherRows()[7],
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text('Next day * 1', textAlign: TextAlign.left),
                          ),
                          Container(
                            child: Column(
                              children: [
                                generateWeatherRows()[0],
                                generateWeatherRows()[1],
                                generateWeatherRows()[2],
                                generateWeatherRows()[3],
                                generateWeatherRows()[4],
                                generateWeatherRows()[5],
                                generateWeatherRows()[6],
                                generateWeatherRows()[7],
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text('Next day * 2', textAlign: TextAlign.left),
                          ),
                          Container(
                            child: Column(
                              children: [
                                generateWeatherRows()[0],
                                generateWeatherRows()[1],
                                generateWeatherRows()[2],
                                generateWeatherRows()[3],
                                generateWeatherRows()[4],
                                generateWeatherRows()[5],
                                generateWeatherRows()[6],
                                generateWeatherRows()[7],
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text('Next day * 3', textAlign: TextAlign.left),
                          ),
                          Container(
                            child: Column(
                              children: [
                                generateWeatherRows()[0],
                                generateWeatherRows()[1],
                                generateWeatherRows()[2],
                                generateWeatherRows()[3],
                                generateWeatherRows()[4],
                                generateWeatherRows()[5],
                                generateWeatherRows()[6],
                                generateWeatherRows()[7],
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text('Next day * 4', textAlign: TextAlign.left),
                          ),
                          Container(
                            child: Column(
                              children: [
                                generateWeatherRows()[0],
                                generateWeatherRows()[1],
                                generateWeatherRows()[2],
                                generateWeatherRows()[3],
                                generateWeatherRows()[4],
                                generateWeatherRows()[5],
                                generateWeatherRows()[6],
                                generateWeatherRows()[7],
                              ],
                            ),
                          ),
                        ],
                      )))) : Container(
                    child: Text ('some 1st state info on chosen day and time')
                  ),
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
                                        print ('you are already on that screen');
                                      }
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    child: Text('1st button')))),
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
                                        print ('you are already on that screen');
                                      }
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    child: Text('2nd button')))),
                      ],
                    ),
                  ),
                ])));
  }
}
