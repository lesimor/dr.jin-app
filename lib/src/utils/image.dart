import 'dart:math';

String randomGroupImageAssetGenerator() {
  var random = Random();
  var randomNumber = random.nextInt(10);
  return 'assets/images/groups/$randomNumber.jpg';
}

String randomProfileImageAssetGenerator() {
  var random = Random();
  var randomNumber = random.nextInt(10);
  return 'assets/images/persons/$randomNumber.png';
}
