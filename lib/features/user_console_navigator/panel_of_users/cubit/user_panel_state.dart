part of 'user_panel_cubit.dart';

class UserPanelState {
  UserPanelState({required this.addUser, required this.users});
  bool addUser = false;
  final List<UserList> users;

  UserPanelState copyWith({bool? addUser, List<UserList>? users}) {
    return UserPanelState(
      addUser: addUser ?? this.addUser,
      users: users ?? this.users
    );
  }
}
