import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/repository/repository.dart';

import '../../../../model/model.dart';

part 'user_panel_state.dart';

class UserPanelCubit extends Cubit<UserPanelState> {
  UserPanelCubit(this._repository)
      : super(UserPanelState(addUser: false, users: []));
  final Repository _repository;
  StreamSubscription? _streamSubscription;
  Future<void> user(bool value) async {
    return emit(state.copyWith(addUser: value));
  }

  Future<void> start() async {
    _streamSubscription = _repository.getUser().listen((user) {
      emit(UserPanelState(addUser: false, users: user));
    })
      ..onError((error) {
        emit(UserPanelState(addUser: false, users: []));
      });
  }

  Future<void> addUser(
      {required String name,
      required String surname,
      required String email,
      required String pass}) async {
    await _repository.addUser(
        name: name, surname: surname, email: email, pass: pass);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
