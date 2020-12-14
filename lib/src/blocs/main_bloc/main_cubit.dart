import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(InitialState());

  Future<void> toFirstScreen() async {
    emit(FirstScreenState());
  }
}
