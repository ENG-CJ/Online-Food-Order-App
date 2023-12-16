class Validator{

  bool isEmailValid(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
  bool containsOnlyNumbers(String input) {
    final numeric = RegExp(r'^[0-9]+$');
    return numeric.hasMatch(input);
  }
  bool passLength(String password) {
    return password.length>=4;
  }
  bool mobileLen(String mobile) {
    return mobile.length==9 || mobile.length==10;
  }
  bool containsOnlyLettersAndSpaces(String name) {
    final RegExp nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    return nameRegex.hasMatch(name);
  }

  bool isFullNameValid(String fullName) {
    final RegExp nameRegex = RegExp(r'^[a-zA-Z]+( [a-zA-Z]+){2,}$');
    return nameRegex.hasMatch(fullName);
  }




}