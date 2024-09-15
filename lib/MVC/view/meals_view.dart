import 'dart:io';
import 'package:crud/MVC/controller/authh.dart';
import 'package:crud/MVC/view/addMeal_view.dart';
import 'package:crud/localization/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crud/MVC/controller/meal_controller.dart';
import 'package:crud/MVC/view/NavigationBar/appbar.dart';
import 'package:crud/MVC/view/NavigationBar/drawer.dart';
import 'package:provider/provider.dart';

class MealView extends StatefulWidget {
  const MealView({super.key});

  @override
  State<MealView> createState() => _MealViewState();
}

class _MealViewState extends State<MealView> {
  MealController mealController = MealController();
  List<Map<String, dynamic>> mealsList = [];

  String? _selectedImagePath;

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

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Provider.of<UserController>(context).currentUser != null;
    return Scaffold(
      appBar: AppBarr(
        isLoggedIn: isLoggedIn,
      ),
      drawer: const Drawerr(
        selectedIndex: 2,
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: isEnglishNotifier,
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: mealsList.length,
            itemBuilder: (context, index) {
              final mealData = mealsList[index];
              String name;
              String type;
              if (value == "en") {
                name = mealData["en_name"];
                type = mealData["en_type"];
              } else {
                name = mealData["de_name"];
                type = mealData["de_type"];
              }
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${LocaleData.price.getString(context)}: ${mealData["price"]}€'),
                      Text('${LocaleData.type.getString(context)}: $type'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          final enNameController =
                              TextEditingController(text: mealData["en_name"]);
                          final deNameController =
                              TextEditingController(text: mealData["de_name"]);
                          final priceController = TextEditingController(
                              text: mealData["price"].toString());
                          final enTypeController =
                              TextEditingController(text: mealData["en_type"]);
                          final deTypeController =
                              TextEditingController(text: mealData["de_type"]);

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    LocaleData.editMeal.getString(context)),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: enNameController,
                                        decoration: InputDecoration(
                                            labelText: LocaleData.nameEnglish
                                                .getString(context)),
                                        onChanged: (value) {
                                          if (value.isEmpty) {
                                            enNameController.text =
                                                mealData["en_name"] ?? "";
                                          }
                                        },
                                      ),
                                      TextField(
                                        controller: deNameController,
                                        decoration: InputDecoration(
                                            labelText: LocaleData.nameGerman
                                                .getString(context)),
                                        onChanged: (value) {
                                          if (value.isEmpty) {
                                            deNameController.text =
                                                mealData["de_name"] ?? "";
                                          }
                                        },
                                      ),
                                      TextField(
                                        controller: priceController,
                                        decoration: InputDecoration(
                                            labelText: LocaleData.price
                                                .getString(context)),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value.isEmpty) {
                                            priceController.text =
                                                mealData["price"].toString();
                                          }
                                        },
                                      ),
                                      TextField(
                                        controller: enTypeController,
                                        decoration: InputDecoration(
                                            labelText: LocaleData.typeEnglish
                                                .getString(context)),
                                        onChanged: (value) {
                                          if (value.isEmpty) {
                                            enTypeController.text =
                                                mealData["en_type"] ?? "";
                                          }
                                        },
                                      ),
                                      TextField(
                                        controller: deTypeController,
                                        decoration: InputDecoration(
                                            labelText: LocaleData.typeGerman
                                                .getString(context)),
                                        onChanged: (value) {
                                          if (value.isEmpty) {
                                            deTypeController.text =
                                                mealData["de_type"] ?? "";
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await pickImage();
                                        },
                                        child: Text(LocaleData.changePicture
                                            .getString(context)),
                                      ),
                                      if (_selectedImagePath != null)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.file(
                                            File(_selectedImagePath!),
                                            height: 100,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                        LocaleData.cancel.getString(context)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      String? imageUrl = mealData["imageUrl"];
                                      if (mealData["imageUrl"] == null ||
                                          mealData["imageUrl"].isEmpty) {
                                        imageUrl = 'default_image_url';
                                      }

                                      if (_selectedImagePath != null) {
                                        String? uploadedFileId =
                                            await mealController
                                                .uploadMealImage(
                                                    _selectedImagePath!);
                                        if (uploadedFileId != null) {
                                          imageUrl = mealController
                                              .getMealImageUrl(uploadedFileId);
                                        }
                                      }

                                      if (enNameController.text.isNotEmpty &&
                                          deNameController.text.isNotEmpty &&
                                          priceController.text.isNotEmpty &&
                                          enTypeController.text.isNotEmpty &&
                                          deTypeController.text.isNotEmpty &&
                                          imageUrl != null) {
                                        await mealController
                                            .updateMealWithImage(
                                          mealData["id"],
                                          enNameController.text,
                                          deNameController.text,
                                          double.tryParse(
                                                  priceController.text) ??
                                              0.00,
                                          enTypeController.text,
                                          deTypeController.text,
                                          imageUrl,
                                        );
                                        Navigator.of(context).pop();
                                        await getMealData();
                                      } else {
                                        print("Missing required fields.");
                                      }
                                    },
                                    child: Text(
                                        LocaleData.save.getString(context)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await mealController
                              .deleteMeal(mealsList[index]["id"]);
                          await getMealData();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Consumer<UserController>(
        builder: (context, userController, child) {
          return FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddMealView(),
                ),
              );
              await getMealData();
            },
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
