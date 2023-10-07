import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  late SharedPreferences pref;

  Future<bool> getIntroStatus() async {
    pref = await SharedPreferences.getInstance();

    final bool status = pref.getBool('intro') ?? false;

    return status;
  }

  Future<void> setIntroStatus() async {
    pref = await SharedPreferences.getInstance();

    await pref.setBool('intro', true);
  }
}
