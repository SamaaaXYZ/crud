import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('66d21c6d003b3e4fc841')
    .setSelfSigned(status: true);

Account account = Account(client);

class UserController with ChangeNotifier {
  models.User? currentUser;

  Future<String> login(String email, String password) async {
    try {
      bool sessionActive = await checkSessions();
      if (!sessionActive) {
        await account.createEmailPasswordSession(
            email: email, password: password);
      }
      final user = await account.get();
      currentUser = user;
      notifyListeners();
      return "success";
    } on AppwriteException catch (e) {
      print("AppwriteException: ${e.message}");
      return e.message ?? "An error occurred";
    } catch (e) {
      print("General Exception: $e");
      return "An unexpected error occurred";
    }
  }

  Future<bool> checkSessions() async {
    try {
      await account.getSession(sessionId: "current");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future getUserId() async {
    try {
      final id = await account.getSession(sessionId: 'current');
      return id.userId;
    } catch (e) {
      return e;
    }
  }

  Future logout() async {
    await account.deleteSession(sessionId: "current");
    currentUser = null;
    notifyListeners();
    print(currentUser);
  }

  Future<User?> getUser() async {
    try {
      final user = await account.get();
      return user;
    } catch (e) {
      return null;
    }
  }

  bool isAdmin() {
    return currentUser != null && currentUser!.email == 'admin@gmail.com';
  }
}
