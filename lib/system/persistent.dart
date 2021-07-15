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

  _setIds(List<String> ids) async {
    await this.prefs.setString(_Keys.ids.toString(), ids.join("\n"));
  }
  List<String> get ids => Set<String>.from(
    prefs.getString(_Keys.ids.toString())?.split("\n") ?? []
  ).where((element) => element.isNotEmpty).toList();

  Future<void> addID(String id) async {
    final ids = this.ids..add(id);
    this._setIds(ids.toList());
  }

  void removeID(String id) async {
    final ids = this.ids..remove(id);
    await this._setIds(ids.toList());
  }
}

_Persistent get persistent => _Persistent._instance;

