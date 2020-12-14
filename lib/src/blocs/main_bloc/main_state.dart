import 'package:flutter/material.dart';

@immutable
abstract class MainState {}

class InitialState extends MainState {
  @override
  String toString() => 'InitialState';
}

class FirstScreenState extends MainState {
  @override
  String toString() => 'FirstScreenState';
}
