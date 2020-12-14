import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/blocs/main_bloc/main_cubit.dart';
import 'package:weather_app/src/blocs/main_bloc/main_cubit_helper.dart';
import 'package:weather_app/src/blocs/main_bloc/main_state.dart';

class MainForm extends StatefulWidget {
  MainForm({Key key}) : super(key: key);

  @override
  _MainFormState createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  MainCubit _mainCubit;
  MainCubitHelper _helper;

  @override
  void initState() {
    super.initState();
    _mainCubit = BlocProvider.of<MainCubit>(context);
    _helper = MainCubitHelper();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: _mainCubit,
      listener: (BuildContext context, MainState state) {},
      child: BlocBuilder(
        cubit: _mainCubit,
        builder: (BuildContext context, MainState state) {
          return _helper.mainWidget(state);
        },
      ),
    );
  }
}
