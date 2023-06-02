import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/repository/repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository)
      : super(
          AuthState(
            user: null,
            load: false,
            erroMessage: '',
          ),
        );
  final Repository _repository;
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(
      AuthState(
        user: null,
        load: true,
        erroMessage: '',
      ),
    );
    _streamSubscription = FirebaseAuth.instance
        .authStateChanges()
        .listen((user) {
      emit(AuthState(user: user, load: false, erroMessage: ''));
    })
      ..onError((error) {
        emit(AuthState(user: null, load: true, erroMessage: error.toString()));
      });
  }

  Future<void> logIn({required String email, required String pass}) async {
    await _repository.logIn(email: email, pass: pass);
  }

  Future<void> logOut() async {
    await _repository.logOut();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
