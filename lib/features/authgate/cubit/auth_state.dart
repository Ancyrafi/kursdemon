part of 'auth_cubit.dart';

class AuthState {
  final User? user;
  final bool load;
  final String erroMessage;

  AuthState({required this.user, required this.load, required this.erroMessage});
}
