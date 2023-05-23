part of 'user_panel_cubit.dart';

class UserPanelState {
  UserPanelState({required this.addUser});
  bool addUser = false;

  UserPanelState copyWith({bool? addUser}) {
    return UserPanelState(addUser: addUser ?? this.addUser);
  }
}
