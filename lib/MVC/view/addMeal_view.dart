import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:crud/MVC/controller/meal_controller.dart';
import 'package:crud/MVC/model/meal.dart';

class AddMealView extends StatefulWidget {
  const AddMealView({super.key});

  @override
  _AddMealViewState createState() => _AddMealViewState();
}

class _AddMealViewState extends State<AddMealView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _deNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _typeController = TextEditingController();
  final _deTypeController = TextEditingController();
  String? _imageUrl;

  final MealController mealController = MealController();
  final Client client = Client()
      .setEndpoint("https://cloud.appwrite.io/v1")
      .setProject("66d21c6d003b3e4fc841");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Meal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name(English)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _deNameController,
                  decoration: const InputDecoration(labelText: 'Name(German)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      String newValue = value;
                      List<String> parts = value.split('.');
                      if (parts[0].length > 2) {
                        parts[0] = parts[0].substring(0, 2);
                      }
                      if (parts.length > 1) {
                        if (parts[1].length > 2) {
                          parts[1] = parts[1].substring(0, 2);
                        }
                        newValue = '${parts[0]}.${parts[1]}';
                      } else {
                        newValue = parts[0];
                      }
                      if (newValue != value) {
                        _priceController.text = newValue;
                        _priceController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _priceController.text.length),
                        );
                      }
                    }
                  },
                ),
                TextFormField(
                  controller: _typeController,
                  decoration: const InputDecoration(labelText: 'Type(English)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a type';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _deTypeController,
                  decoration: const InputDecoration(labelText: 'Type(German)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => pickAndUploadImage(),
                  child: const Text('Select and Upload Image'),
                ),
                if (_imageUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.network(_imageUrl!),
                  )
                else
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Icon(Icons.image, size: 100),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_imageUrl != null) {
                        addMealWithImage(
                          _nameController.text,
                          _deNameController.text,
                          double.parse(_priceController.text),
                          _typeController.text,
                          _deTypeController.text,
                          _imageUrl!,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please select an image')),
                        );
                      }
                    }
                  },
                  child: const Text('Add Meal'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addMealWithImage(String name, String de_name, double price, String type,
      String de_type, String imageUrl) async {
    final meal = Meal(
      id: await _getNextId(),
      name: name,
      de_name: de_name,
      price: price,
      type: type,
      de_type: de_type,
      imageUrl: imageUrl,
    );

    await mealController.createMeal(meal);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Meal added!')),
    );
    Navigator.of(context).pop();
  }

  Future<void> pickAndUploadImage() async {
    if (kIsWeb) {
      final html.FileUploadInputElement uploadInput =
          html.FileUploadInputElement();
      uploadInput.accept = 'image/*';
      uploadInput.click();

      uploadInput.onChange.listen((event) async {
        final file = uploadInput.files!.first;
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);

        reader.onLoadEnd.listen((event) async {
          Uint8List fileBytes = reader.result as Uint8List;

          String? fileId = await uploadImageBytes(fileBytes, file.name);
          if (fileId != null) {
            setState(() {
              _imageUrl = getMealImageUrl(fileId);
            });
          } else {
            print('Error uploading image.');
          }
        });
      });
    } else {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        String filePath = pickedFile.path;
        String? fileId = await mealController.uploadMealImage(filePath);

        if (fileId != null) {
          setState(() {
            _imageUrl = getMealImageUrl(fileId);
          });
        } else {
          print('Error uploading image.');
        }
      } else {
        print('No image selected.');
      }
    }
  }

  Future<String?> uploadImageBytes(Uint8List fileBytes, String fileName) async {
    try {
      models.File uploadedFile = await Storage(client).createFile(
        bucketId: '66d9c70c0014a279e6f5',
        fileId: ID.unique(),
        file: InputFile(
          filename: fileName,
          bytes: fileBytes,
        ),
      );
      return uploadedFile.$id;
    } on AppwriteException catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<String> _getNextId() async {
    List? meals = await mealController.showMealIds();

    if (meals == null || meals.isEmpty) {
      return '1';
    } else {
      meals.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
      final lastId = meals.last;
      final lastNum = int.parse(lastId);
      final nextNum = lastNum + 1;
      return nextNum.toString();
    }
  }

  String getMealImageUrl(String fileId) {
    return 'https://cloud.appwrite.io/v1/storage/buckets/66d9c70c0014a279e6f5/files/$fileId/view?project=66d21c6d003b3e4fc841';
  }
}
