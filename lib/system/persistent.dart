/* This file handles persistent storage - things that are stored between sessions */
import 'package:shared_preferences/shared_preferences.dart';


enum _Keys { ids }

class _Persistent {

  _Persistent._();
  static _Persistent _instance = _Persistent._();

  late SharedPreferences prefs;

  Future<void> init() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  List<String> get ids => this.prefs.getString(_Keys.ids.toString())?.split("\n") ?? [];
  Future<void> setIds(List<String> ids) async {
    await this.prefs.setString(_Keys.ids.toString(), ids.join("\n"));
  }
}

_Persistent get persistent => _Persistent._instance;

