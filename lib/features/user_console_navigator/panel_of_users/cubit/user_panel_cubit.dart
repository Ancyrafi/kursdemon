import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/repository/repository.dart';

part 'user_panel_state.dart';

class UserPanelCubit extends Cubit<UserPanelState> {
  UserPanelCubit(this._repository) : super(UserPanelState(addUser: false));
  final Repository _repository;
  Future<void> user(bool value) async {
    return emit(state.copyWith(addUser: value));
  }

  Future<void> addUser(
      {required String name,
      required String surname,
      required String email,
      required String pass}) async {
    await _repository.addUser(
        name: name, surname: surname, email: email, pass: pass);
  }
}
