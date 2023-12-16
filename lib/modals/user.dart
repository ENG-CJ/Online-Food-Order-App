class User {
  int? user_id;
  int mobile;
  String username, email, password, address;
  String? account_status;

  User(
      {required this.username,
      required this.email,
      required this.password,
      required this.mobile,
      required this.address,
      this.account_status,
      this.user_id});

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
        username: user['username'],
        email: user['email'],
        password: user['password'],
        mobile: user['mobile'],
        address: user['address'],
        account_status: user['account_status'],
        user_id: user['cust_id']);
  }


  Map<String,dynamic> toJson(){
    return {
      "id":user_id,
      "name": username,
      "email": email,
      "password": password,
      "mobile": mobile,
      "address": address,
      "status": account_status

    };
  }
}
