/// CapitalizeFirstLetter method
String capitalizeFirstLetter(String input) {
  if (input.isEmpty) return input; // Handle empty string
  return input[0].toUpperCase() + input.substring(1);
}
