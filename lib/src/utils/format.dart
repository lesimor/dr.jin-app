String addCommas(int number) {
  return number.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
}

String formatPrice(int number) {
  if (number > 0) {
    return "${addCommas(number)}원";
  } else {
    return "무료";
  }
}
