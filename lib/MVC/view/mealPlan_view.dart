import 'package:crud/MVC/controller/authh.dart';
import 'package:crud/MVC/controller/mealPlan_controller.dart';
import 'package:crud/MVC/controller/meal_controller.dart';
import 'package:crud/MVC/model/meal.dart';
import 'package:crud/MVC/view/NavigationBar/appbar.dart';
import 'package:crud/MVC/view/NavigationBar/drawer.dart';
import 'package:crud/MVC/view/addMealToPlan_view.dart';
import 'package:crud/MVC/view/food_detail_page.dart';
import 'package:crud/localization/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';

class MealplanView extends StatefulWidget {
  const MealplanView({super.key});

  @override
  State<MealplanView> createState() => _MealplanViewState();
}

class _MealplanViewState extends State<MealplanView> {
  int selectedWeek = 1;
  late List<String> daysOfWeek;

  final _mealController = MealController();
  final _mealplanController = MealplanController();
  Map<int, List<dynamic>>? listo = {};
  List<Meal?> mealDetails = List<Meal?>.filled(5, null);
  String? _userId;

  @override
  void initState() {
    super.initState();
    getUserrId();
    getMealPlans();
  }

  Future<void> getUserrId() async {
    var id = await UserController().getUserId();
    setState(() {
      _userId = id;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      daysOfWeek = [
        LocaleData.dayOfWeek1.getString(context),
        LocaleData.dayOfWeek2.getString(context),
        LocaleData.dayOfWeek3.getString(context),
        LocaleData.dayOfWeek4.getString(context),
        LocaleData.dayOfWeek5.getString(context),
      ];
    });
  }

  Future<void> getMealPlans() async {
    try {
      Map<int, List<dynamic>>? list =
          await _mealplanController.showAllMealPlan();
      setState(() {
        listo = list ?? {};
        loadMealDetails();
      });
    } catch (e) {
      print("Error retrieving meal plans: $e");
    }
  }

  Future<void> loadMealDetails() async {
    if (listo != null && listo![selectedWeek] != null) {
      for (int i = 0; i < daysOfWeek.length; i++) {
        try {
          List<dynamic>? mealData =
              await _mealController.showMealss(listo![selectedWeek]![i]);

          if (mealData != null && mealData.length >= 7) {
            setState(() {
              mealDetails[i] = Meal(
                id: mealData[0] ?? '',
                name: mealData[1],
                de_name: mealData[2],
                price: double.tryParse(mealData[3]?.toString() ?? '0') ?? 0.0,
                type: mealData[4],
                de_type: mealData[5],
                imageUrl: mealData[6],
              );
            });
          } else {
            setState(() {
              mealDetails[i] = null;
            });
          }
        } catch (e) {
          print("Error loading meal details for day $i: $e");
          setState(() {
            mealDetails[i] = null;
          });
        }
      }
    } else {
      setState(() {
        mealDetails = List<Meal?>.filled(5, null);
      });
    }
  }

  Future<void> removeMealFromPlan(int dayIndex) async {
    try {
      List<String> currentMeals =
          (await _mealplanController.showMealPlan(selectedWeek.toString()))
                  ?.cast<String>() ??
              [];

      if (currentMeals.isNotEmpty) {
        currentMeals[dayIndex] = "";
        await _mealplanController.updateMealPlan(
            selectedWeek.toString(), currentMeals);

        setState(() {
          mealDetails[dayIndex] = null;
        });
      }
    } catch (e) {
      print("Error removing meal from plan: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Provider.of<UserController>(context).currentUser != null;

    return Scaffold(
      appBar: AppBarr(isLoggedIn: isLoggedIn),
      drawer: const Drawerr(
        selectedIndex: 1,
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                DropdownButton<int>(
                  value: selectedWeek,
                  items: List.generate(8, (index) => index + 1)
                      .map((week) => DropdownMenuItem(
                            value: week,
                            child: Text(
                              '${LocaleData.weekText.getString(context)} $week',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ))
                      .toList(),
                  onChanged: (week) {
                    setState(() {
                      selectedWeek = week!;
                      loadMealDetails();
                    });
                  },
                ),
                const SizedBox(height: 10),
                ...List.generate(daysOfWeek.length, (index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    elevation: 5,
                    child: ValueListenableBuilder<String>(
                      valueListenable: isEnglishNotifier,
                      builder: (context, value, child) {
                        String _name;
                        if (value == "en") {
                          _name = mealDetails[index]?.name ?? 'No name';
                        } else {
                          _name = mealDetails[index]?.de_name ?? 'Kein Name';
                        }
                        return ListTile(
                          title: Text(
                            daysOfWeek[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          leading: mealDetails[index] != null &&
                                  mealDetails[index]!.imageUrl.isNotEmpty
                              ? Image.network(mealDetails[index]!.imageUrl,
                                  width: 50, height: 50)
                              : const Icon(Icons.fastfood),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  '${LocaleData.price.getString(context)}: ${mealDetails[index]?.price.toStringAsFixed(2)}€'),
                            ],
                          ),
                          onTap: () {
                            if (mealDetails[index] != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FoodDetailPage(meal: mealDetails[index]!),
                                ),
                              );
                            }
                          },
                          trailing: _userId == "66e0146c3a1b06783624"
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (mealDetails[index] != null)
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          removeMealFromPlan(index);
                                        },
                                      ),
                                  ],
                                )
                              : null,
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Consumer<UserController>(
        builder: (context, userController, child) {
          return _userId == "66e0146c3a1b06783624"
              ? FloatingActionButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddMealToWeekView(
                          onMealAdded: () async {
                            await getMealPlans();
                          },
                        ),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                )
              : Container();
        },
      ),
    );
  }
}
