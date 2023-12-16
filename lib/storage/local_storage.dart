import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{

  Future<SharedPreferences> initSharedPref()async{
      var _shared= await SharedPreferences.getInstance();
      return _shared;
  }

  Future<void> createLocalData(Map<String, dynamic> data)async{
    var pref= await initSharedPref();
    pref.setString("name", data['name']);
    pref.setInt("id", data['id']);
    pref.setString("password", data['pass']);
  }
  Future<int?> getId()async{
    var pref= await initSharedPref();
    return pref.get("id") as int;
  }

  Future<String?> getPassword()async{
    var pref= await initSharedPref();
    return pref.get("password").toString() ;
  }

  Future<void> updateNameKey(String value)async{
    var pref= await initSharedPref();
    pref.setString("name", value);
  }
  Future<void> updateIdKey(int value)async{
    var pref= await initSharedPref();
    pref.setInt("id", value);
  }
  Future<void> updatePassKey(String value)async{
    var pref= await initSharedPref();
    pref.setString("password", value);
  }

  Future<String?> getCurrentUser()async{
    var pref= await initSharedPref();
    return pref.get("name").toString();
  }
  Future<void> clearLocalData()async{
    var pref= await initSharedPref();
    pref.clear();
  }
}