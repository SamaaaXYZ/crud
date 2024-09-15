import 'package:appwrite/appwrite.dart';
import 'package:crud/MVC/model/mealplan.dart';

class MealplanController {
  final Client client = Client()
      .setEndpoint("https://cloud.appwrite.io/v1")
      .setProject("66d21c6d003b3e4fc841");

  createMealPlan(MealPlan mealPlan) async {
    int weekNumber = mealPlan.weekNumber;
    List<String> mealPlanList = [];
    for (var meals in mealPlan.meals) {
      mealPlanList.add(meals);
    }
    ;
    try {
      final databases = Databases(client);
      // ignore: unused_local_variable
      final document = await databases.createDocument(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21ca2001c6c47b40f",
        documentId: ID.custom("$weekNumber"),
        data: {"mealsPerWeek": mealPlanList},
      );
    } on AppwriteException catch (e) {
      print(e);
    }
  }

  deleteMealPlan(int weekNumber) async {
    try {
      final databases = Databases(client);
      // ignore: unused_local_variable
      final document = await databases.deleteDocument(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21ca2001c6c47b40f",
        documentId: ID.custom("$weekNumber"),
      );
    } on AppwriteException catch (e) {
      print(e);
    }
  }

  updateMealPlan(String weekNumber, List<String> list) async {
    try {
      final databases = Databases(client);
      // ignore: unused_local_variable
      final document = await databases.updateDocument(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21ca2001c6c47b40f",
        documentId: ID.custom(weekNumber),
        data: {"mealsPerWeek": list},
      );
      print("Meal plan updated successfully: $list");
    } on AppwriteException catch (e) {
      print(
          "Failed to update meal plan: ${e.message}, ${e.code}, ${e.response}");
    }
  }

  showMealPlan(String weekNumber) async {
    try {
      final databases = Databases(client);
      final document = await databases.getDocument(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21ca2001c6c47b40f",
        documentId: weekNumber,
      );
      final List<dynamic>? list = document.data["mealsPerWeek"];
      return list;
    } on AppwriteException catch (e) {
      print(e);
    }
  }

  Future<Map<int, List<dynamic>>?> showAllMealPlan() async {
    try {
      final databases = Databases(client);
      final document = await databases.listDocuments(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d21ca2001c6c47b40f",
      );
      final Map<int, List<dynamic>> list = {};
      for (var element in document.documents) {
        int weekNumber = int.parse(element.$id);
        List<dynamic> list_two = element.data["mealsPerWeek"];
        list[weekNumber] = list_two;
      }
      return list;
    } on AppwriteException catch (e) {
      print(e);
    }
    return null;
  }
}
