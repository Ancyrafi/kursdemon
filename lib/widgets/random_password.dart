import 'dart:math';

String generatePassword() {
  const allowedChars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  Random rnd = Random();
  return List.generate(
      6, (index) => allowedChars[rnd.nextInt(allowedChars.length)]).join();
}
