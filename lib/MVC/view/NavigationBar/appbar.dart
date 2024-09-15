import 'package:crud/MVC/controller/authh.dart';
import 'package:crud/MVC/view/login_vieww.dart';
import 'package:crud/main.dart';
import 'package:flutter/material.dart';

class AppBarr extends StatefulWidget implements PreferredSizeWidget {
  final bool isLoggedIn;

  const AppBarr({required this.isLoggedIn, super.key});
  @override
  State<AppBarr> createState() => _AppBarrState();

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

class _AppBarrState extends State<AppBarr> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    UserController().checkSessions().then((value) {
      setState(() {
        isLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.teal,
      toolbarHeight: 120,
      title: Row(
        children: [
          const SizedBox(width: 20),
          const Text(
            "LüneFood",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(child: Container()),
          const SizedBox(width: 10),
          isLoggedIn
              ? IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white, size: 30),
                  onPressed: () async {
                    await UserController().logout();
                    setState(() {
                      isLoggedIn = false;
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckSession(),
                      ),
                    );
                  })
              : IconButton(
                  icon: const Icon(Icons.person, color: Colors.white, size: 30),
                  onPressed: () {
                    print(isLoggedIn);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                )
        ],
      ),
    );
  }
}
