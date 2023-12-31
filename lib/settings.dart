import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextStyle textStyle = TextStyle(fontSize: 24);

  TextEditingController? txtWork;
  TextEditingController? txtShort;
  TextEditingController? txtLong;

  static const String WORKTIME = "workTime";
  static const String SHROTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int workTime = 0;
  int shortBreak = 0;
  int longBreak = 0;

  SharedPreferences? prefs;

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int? workTime = prefs?.getInt(WORKTIME);
    if(workTime == null){
      await prefs?.setInt(WORKTIME, int.parse('30'));
    }

    int? shortBreak = prefs?.getInt(SHROTBREAK);
    if(shortBreak == null){
      await prefs?.setInt(SHROTBREAK, int.parse('5'));
    }

    int? longBreak = prefs?.getInt(LONGBREAK);
    if(longBreak == null){
      await prefs?.setInt(LONGBREAK, int.parse('20'));
    }

    setState(() {
      txtWork?.text = workTime.toString();
      txtShort?.text = shortBreak.toString();
      txtLong?.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int workTime = prefs?.getInt(WORKTIME) as int;
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs?.setInt(WORKTIME, workTime);
            setState(() {
              txtWork?.text = workTime.toString();
            });
          }
        }
        break;
      case SHROTBREAK:
        {
          int short = prefs?.getInt(SHROTBREAK) as int;
          short += value;
          if (short >= 1 && short <= 120) {
            prefs?.setInt(SHROTBREAK, short);
            setState(() {
              txtShort?.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int long = prefs?.getInt(LONGBREAK) as int;
          long += value;
          if (long >= 1 && long <= 180) {
            prefs?.setInt(LONGBREAK, long);
            setState(() {
              txtLong?.text = long.toString();
            });
          }
        }
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
  }

  @override
  Widget build(BuildContext context) {
    double buttonSize = 10.0;
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          Text("Work", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(
              Color(0xff455A64), "-", buttonSize, -1, WORKTIME, updateSetting),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            controller: txtWork,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(
              Color(0xff009688), "+", buttonSize, 1, WORKTIME, updateSetting),
          Text("Short", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(Color(0xff455A64), "-", buttonSize, -1, SHROTBREAK,
              updateSetting),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            controller: txtShort,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(
              Color(0xff009688), "+", buttonSize, 1, SHROTBREAK, updateSetting),
          Text("Long", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(
              Color(0xff455A64), "-", buttonSize, -1, LONGBREAK, updateSetting),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            controller: txtLong,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(
              Color(0xff009688), "+", buttonSize, 1, LONGBREAK, updateSetting),
        ],
        padding: EdgeInsets.all(20),
      ),
    );
  }
}
