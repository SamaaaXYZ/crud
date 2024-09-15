import 'package:crud/MVC/controller/authh.dart';
import 'package:crud/MVC/view/homePage_view.dart';
import 'package:crud/MVC/view/mealPlan_view.dart';
import 'package:crud/MVC/view/meals_view.dart';
import 'package:crud/localization/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class Drawerr extends StatefulWidget {
  final int selectedIndex;

  const Drawerr({super.key, required this.selectedIndex});

  @override
  State<Drawerr> createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;
  late int _selectedIndex;
  String? _userId;

  @override
  void initState() {
    super.initState();
    getUserrId();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
    _selectedIndex = widget.selectedIndex;
  }

  Future<void> getUserrId() async {
    var id = await UserController().getUserId();
    setState(() {
      _userId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white, // Hintergrundfarbe auf Weiß setzen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.teal,
                      image: DecorationImage(
                        image: AssetImage('lib/assets/images/GOGO.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.2),
                                Colors.black.withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'LüneFood Menu',
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 4,
                                      color: Colors.black38,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    hoverColor: Colors.transparent,
                    title: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: _selectedIndex == 0
                          ? const EdgeInsets.only(left: 32.0)
                          : const EdgeInsets.only(left: 0.0),
                      decoration: BoxDecoration(
                        color: _selectedIndex == 0
                            ? Colors.teal[100]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.home,
                              color: Colors.black), // Farbe angepasst
                          const SizedBox(width: 16),
                          Text(
                            LocaleData.homePage.getString(context),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black), // Farbe angepasst
                          ),
                        ],
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    hoverColor: Colors.transparent,
                    title: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: _selectedIndex == 1
                          ? const EdgeInsets.only(left: 32.0)
                          : const EdgeInsets.only(left: 0.0),
                      decoration: BoxDecoration(
                        color: _selectedIndex == 1
                            ? Colors.teal[100]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month,
                              color: Colors.black), // Farbe angepasst
                          const SizedBox(width: 16),
                          Text(
                            LocaleData.mealPlan.getString(context),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black), // Farbe angepasst
                          ),
                        ],
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MealplanView(),
                        ),
                      );
                    },
                  ),
                  _userId == "66e0146c3a1b06783624"
                      ? ListTile(
                          hoverColor: Colors.transparent,
                          title: Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: _selectedIndex == 2
                                ? const EdgeInsets.only(left: 32.0)
                                : const EdgeInsets.only(left: 0.0),
                            decoration: BoxDecoration(
                              color: _selectedIndex == 2
                                  ? Colors.teal[100]
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.food_bank,
                                    color: Colors.black), // Farbe angepasst
                                const SizedBox(width: 16),
                                Text(
                                  LocaleData.mealList.getString(context),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black), // Farbe angepasst
                                ),
                              ],
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                          onTap: () {
                            setState(() {
                              _selectedIndex = 2;
                            });
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MealView(),
                              ),
                            );
                          },
                        )
                      : Container()
                ],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLanguageSwitch(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'icons/flags/png/us.png',
          package: 'country_icons',
          width: 40,
          height: 40,
        ),
        DropdownButton(
          value: _currentLocale,
          items: const [
            DropdownMenuItem(
              value: "en",
              child: Text("Englisch"),
            ),
            DropdownMenuItem(
              value: "de",
              child: Text("Deutsch"),
            ),
          ],
          onChanged: (value) {
            _setLocale(value);
          },
        ),
        Image.asset(
          'icons/flags/png/de.png',
          package: 'country_icons',
          width: 30,
          height: 30,
        ),
      ],
    );
  }

  void _setLocale(String? value) {
    if (value == null) return;
    if (value == "en") {
      _flutterLocalization.translate("en");
    } else if (value == "de") {
      _flutterLocalization.translate("de");
    } else {
      return;
    }

    isEnglishNotifier.value = value;

    setState(() {
      _currentLocale = value;
    });
  }
}
