import 'package:crud/MVC/controller/authh.dart';
import 'package:crud/MVC/controller/mealPlan_controller.dart';
import 'package:crud/MVC/controller/meal_controller.dart';
import 'package:crud/MVC/model/mealplan.dart';
import 'package:crud/MVC/view/NavigationBar/appbar.dart';
import 'package:crud/MVC/view/NavigationBar/drawer.dart';
import 'package:crud/localization/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';

class AddMealToWeekView extends StatefulWidget {
  final VoidCallback onMealAdded;

  const AddMealToWeekView({super.key, required this.onMealAdded});

  @override
  State<AddMealToWeekView> createState() => _AddMealToWeekViewState();
}

class _AddMealToWeekViewState extends State<AddMealToWeekView> {
  int selectedWeek = 1;
  int selectedDay = 0;
  final mealController = MealController();
  final _mealPlanController = MealplanController();
  List<Map<String, dynamic>> mealsList = [];

  Future<void> getMealData() async {
    try {
      var de_mealNames = await mealController.showDeMealNames();
      var en_mealNames = await mealController.showEnMealNames();
      var mealPrices = await mealController.showMealPrices();
      var de_mealTypes = await mealController.showDeMealTypes();
      var en_mealTypes = await mealController.showEnMealTypes();
      var mealIds = await mealController.showMealIds();

      if (de_mealNames != null &&
          en_mealNames != null &&
          mealPrices != null &&
          de_mealTypes != null &&
          en_mealTypes != null) {
        List<Map<String, dynamic>> tempMealsList = [];
        for (int i = 0; i < en_mealNames.length; i++) {
          tempMealsList.add({
            "en_name": en_mealNames[i] ?? "Unknown",
            "de_name": de_mealNames[i] ?? "Unknown",
            "price": mealPrices[i] ?? 0.0,
            "en_type": en_mealTypes[i] ?? "Unknown",
            "de_type": de_mealTypes[i] ?? "Unknown",
            "id": mealIds![i],
          });
        }
        setState(() {
          mealsList = tempMealsList;
        });
      }
    } catch (e) {
      print("Error fetching meal data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getMealData();
  }

  void addMealToPlan(String mealId) async {
    try {
      List<String> currentMeals =
          (await _mealPlanController.showMealPlan(selectedWeek.toString()))
                  ?.cast<String>() ??
              [];

      if (currentMeals.isEmpty) {
        currentMeals = List<String>.filled(5, "");
      }

      currentMeals[selectedDay] = mealId;

      if (await _mealPlanController.showMealPlan(selectedWeek.toString()) !=
          null) {
        await _mealPlanController.updateMealPlan(
            selectedWeek.toString(), currentMeals);
      } else {
        await _mealPlanController.createMealPlan(MealPlan(
          weekNumber: selectedWeek,
          weekDay: selectedDay,
          meals: currentMeals,
        ));
      }

      widget.onMealAdded();
      Navigator.of(context).pop();
    } catch (e) {
      print("Error adding meal to plan: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Provider.of<UserController>(context).currentUser != null;

    return Scaffold(
      appBar: AppBarr(isLoggedIn: isLoggedIn),
      drawer: Drawerr(
        selectedIndex: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<int>(
              value: selectedWeek,
              items: List.generate(8, (index) => index + 1)
                  .map((week) => DropdownMenuItem(
                        value: week,
                        child: Text(
                          '${LocaleData.weekText.getString(context)} $week',
                        ),
                      ))
                  .toList(),
              onChanged: (week) {
                setState(() {
                  selectedWeek = week!;
                });
              },
            ),
            DropdownButton<int>(
              value: selectedDay,
              items: List.generate(5, (index) => index)
                  .map((day) => DropdownMenuItem(
                        value: day,
                        child: Text(
                          [
                            LocaleData.dayOfWeek1.getString(context),
                            LocaleData.dayOfWeek2.getString(context),
                            LocaleData.dayOfWeek3.getString(context),
                            LocaleData.dayOfWeek4.getString(context),
                            LocaleData.dayOfWeek5.getString(context),
                          ][day],
                        ),
                      ))
                  .toList(),
              onChanged: (day) {
                setState(() {
                  selectedDay = day!;
                });
              },
            ),
            Expanded(
              child: mealsList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: mealsList.length,
                      itemBuilder: (context, index) {
                        final meal = mealsList[index];
                        return Card(
                          child: ValueListenableBuilder<String>(
                              valueListenable: isEnglishNotifier,
                              builder: (context, value, child) {
                                String _name;
                                String _type;
                                if (value == "en") {
                                  _name = meal["en_name"];
                                  _type = meal["en_type"];
                                } else {
                                  _name = meal["de_name"];
                                  _type = meal["de_type"];
                                }
                                return ListTile(
                                  title: Text(_name),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${LocaleData.price.getString(context)}: ${meal["price"]}€'),
                                      Text(
                                          '${LocaleData.type.getString(context)}: $_type'),
                                    ],
                                  ),
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                      addMealToPlan(meal['id']);
                                    },
                                    child:
                                        Text(LocaleData.add.getString(context)),
                                  ),
                                );
                              }),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
