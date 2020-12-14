import 'package:flutter/material.dart';
import 'package:weather_app/src/blocs/main_bloc/main_state.dart';
import 'package:weather_app/src/screens/first_screen.dart';

class MainCubitHelper {
  Widget mainWidget(MainState state) {
    Widget widget;
    switch (state.toString()) {
      case ('InitialState'):
        {
          widget = FirstScreen();
          return widget;
        }
        break;
      case ('FirstScreenState'):
        {
          widget = FirstScreen();
          return widget;
        }
        break;
      default:
        {
          return Container();
        }
        break;
    }
  }
}
