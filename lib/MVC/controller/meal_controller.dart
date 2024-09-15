import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:crud/MVC/model/meal.dart';

class MealController {
  final Client client = Client()
      .setEndpoint("https://cloud.appwrite.io/v1")
      .setProject("66d21c6d003b3e4fc841");

  Future<String?> uploadMealImage(String filePath) async {
    try {
      final storage = Storage(client);

      models.File uploadedFile = await storage.createFile(
        bucketId: '66d9c70c0014a279e6f5',
        fileId: ID.unique(),
        file: InputFile(path: filePath),
      );

      return uploadedFile.$id;
    } on AppwriteException catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> updateMealWithImage(String id, String name, String de_name,
      double price, String type, String de_type, String imageUrl) async {
    try {
      final databases = Databases(client);

      await databases.updateDocument(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21cab0032235c3d6b",
        documentId: id,
        data: {
          "name": name,
          "de_name": de_name,
          "price": price,
          "type": type,
          "de_type": de_type,
          "imageUrl": imageUrl,
        },
      );
    } on AppwriteException catch (e) {
      print('Failed to update meal: ${e.message}, ${e.code}, ${e.response}');
    }
  }

  String getMealImageUrl(String fileId) {
    return 'https://cloud.appwrite.io/v1/storage/buckets/66d9c70c0014a279e6f5/files/$fileId/view?project=66d21c6d003b3e4fc841';
  }

  createMeal(Meal meal) async {
    try {
      final databases = Databases(client);
      String mealId = meal.id;

      // ignore: unused_local_variable
      final document = await databases.createDocument(
          databaseId: "66d21c940032616f4ce7",
          collectionId: "66d21cab0032235c3d6b",
          documentId: ID.custom(mealId),
          data: meal.doc());
    } on AppwriteException catch (e) {
      print(e);
    }
  }

  deleteMeal(String mealId) async {
    try {
      final databases = Databases(client);

      await databases.deleteDocument(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21cab0032235c3d6b",
        documentId: mealId,
      );
    } on AppwriteException catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>?> showMealss(String mealId) async {
    try {
      final databases = Databases(client);
      final document = await databases.getDocument(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21cab0032235c3d6b",
        documentId: mealId,
      );

      List<dynamic> mealData = [
        document.$id,
        document.data["name"],
        document.data["de_name"],
        document.data["price"],
        document.data["type"],
        document.data["de_type"],
        document.data["imageUrl"],
      ];

      return mealData;
    } on AppwriteException catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<dynamic>?> showEnMeal(String mealId) async {
    try {
      final databases = Databases(client);
      final document = await databases.getDocument(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21cab0032235c3d6b",
        documentId: mealId,
      );

      List<dynamic> mealData = [
        document.$id,
        document.data["name"],
        document.data["price"],
        document.data["type"],
        document.data["imageUrl"],
      ];

      return mealData;
    } on AppwriteException catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<dynamic>?> showDeMeal(String mealId) async {
    try {
      final databases = Databases(client);
      final document = await databases.getDocument(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21cab0032235c3d6b",
        documentId: mealId,
      );

      List<dynamic> mealData = [
        document.$id,
        document.data["de_name"],
        document.data["price"],
        document.data["de_type"],
        document.data["imageUrl"],
      ];

      return mealData;
    } on AppwriteException catch (e) {
      print(e);
    }
    return null;
  }

  updateMeal(String id, String name, String de_name, double price, String type,
      String de_type) async {
    try {
      final databases = Databases(client);

      // ignore: unused_local_variable
      final document = await databases.updateDocument(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21cab0032235c3d6b",
        documentId: ID.custom(id),
        data: {
          "name": name,
          "de_name": de_name,
          "price": price,
          "type": type,
          "de_type": de_type
        },
      );
    } on AppwriteException catch (e) {
      print('Failed to update meal: ${e.message}, ${e.code}, ${e.response}');
    }
  }

  Future<List<dynamic>?> showMealIds() async {
    try {
      final databases = Databases(client);
      final document = await databases.listDocuments(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21cab0032235c3d6b",
      );

      List<dynamic> list = [];
      for (var element in document.documents) {
        list.add(element.$id);
      }

      return list;
    } on AppwriteException catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<dynamic>?> showDeMealNames() async {
    try {
      final databases = Databases(client);
      final document = await databases.listDocuments(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21cab0032235c3d6b",
      );

      List<dynamic> list = [];
      for (var element in document.documents) {
        list.add(element.data["de_name"]);
      }
      return list;
    } on AppwriteException catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<dynamic>?> showEnMealNames() async {
    try {
      final databases = Databases(client);
      final document = await databases.listDocuments(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21cab0032235c3d6b",
      );

      List<dynamic> list = [];
      for (var element in document.documents) {
        list.add(element.data["name"]);
      }
      return list;
    } on AppwriteException catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<dynamic>?> showMealPrices() async {
    try {
      final databases = Databases(client);
      final document = await databases.listDocuments(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21cab0032235c3d6b",
      );

      List<dynamic> list = [];
      for (var element in document.documents) {
        list.add(element.data["price"]);
      }
      return list;
    } on AppwriteException catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<dynamic>?> showEnMealTypes() async {
    try {
      final databases = Databases(client);
      final document = await databases.listDocuments(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21cab0032235c3d6b",
      );

      List<dynamic> list = [];
      for (var element in document.documents) {
        list.add(element.data["type"]);
      }
      return list;
    } on AppwriteException catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<dynamic>?> showDeMealTypes() async {
    try {
      final databases = Databases(client);
      final document = await databases.listDocuments(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21cab0032235c3d6b",
      );

      List<dynamic> list = [];
      for (var element in document.documents) {
        list.add(element.data["de_type"]);
      }
      return list;
    } on AppwriteException catch (e) {
      print(e);
    }
    return null;
  }
}
