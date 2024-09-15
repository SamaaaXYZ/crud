import 'package:crud/MVC/controller/authh.dart';
import 'package:crud/MVC/view/homePage_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final resetKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Login",
                          style: GoogleFonts.workSans(
                              fontSize: 50, fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .9,
                          child: TextFormField(
                            validator: (value) => value!.isEmpty
                                ? "Email cannot be empty."
                                : null,
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Email"),
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .9,
                        child: TextFormField(
                          validator: (value) => value!.length < 8
                              ? "Password should have atleast 8 characters."
                              : null,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Password"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          height: 65,
                          width: MediaQuery.of(context).size.width * .9,
                          child: ElevatedButton(
                              onPressed: () async {
                                var userController =
                                    Provider.of<UserController>(context,
                                        listen: false);

                                if (formKey.currentState!.validate()) {
                                  // ignore: unused_local_variable
                                  String errorMessage = '';
                                  errorMessage = await userController
                                      .login(
                                    _emailController.text,
                                    _passwordController.text,
                                  )
                                      .then((value) {
                                    if (value == "success") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: const Text(
                                          "Login Successful",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.green.shade400,
                                      ));
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          value,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        backgroundColor: Colors.red.shade400,
                                      ));
                                    }
                                    return "";
                                  });
                                }
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(fontSize: 17),
                              ))),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Continue as a guest",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: const Text("User"),
                          content: const Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Admin", style: TextStyle(fontSize: 21)),
                              Text("Email: admin@gmail.com",
                                  style: TextStyle(fontSize: 17)),
                              Text("Password: admin1310",
                                  style: TextStyle(fontSize: 17)),
                              SizedBox(height: 20),
                              Text("User", style: TextStyle(fontSize: 21)),
                              Text("Email: user@gmail.com",
                                  style: TextStyle(fontSize: 17)),
                              Text("Password: user1310",
                                  style: TextStyle(fontSize: 17)),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text(
                "User Data [Only For Slotos]",
                style: TextStyle(fontSize: 17),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
