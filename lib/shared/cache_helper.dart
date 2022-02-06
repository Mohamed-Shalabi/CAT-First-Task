
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  //
  CacheHelper._();

  static late final SharedPreferences instance;

  static Future init() async {
    instance = await SharedPreferences.getInstance();
  }
}