import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/repository/repository.dart';

import '../../../model/model.dart';

part 'social_cubit_state.dart';

class SocialCubitCubit extends Cubit<SocialCubitState> {
  SocialCubitCubit(this._repository) : super(SocialCubitState(socialmedia: []));
  final Repository _repository;
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription = _repository.getSocialMedia().listen(
      (socialmedia) {
        emit(SocialCubitState(
          socialmedia: socialmedia,
        ));
      },
    )..onError((error) {
        emit(SocialCubitState(socialmedia: []));
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
