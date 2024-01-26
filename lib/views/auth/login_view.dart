import 'package:appwrite/appwrite.dart';
import 'package:dhwani/services/auth_service.dart';
import 'package:dhwani/widgets/auth/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerWidget {
  static const routename = '/login';
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    final [emailController, passController] =
        List<TextEditingController>.generate(2, (_) => TextEditingController());
    return Scaffold(
      body: Column(
        children: [
          const AuthHeader(
            authType: "SignIn",
          ),
          const SizedBox(height: 20),
          const Text("Welcome Back !",
              style: TextStyle(
                letterSpacing: 1.2,
                color: Color(0xFF04434E),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                InputField(
                  hint: "Email",
                  inputType: "email",
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                InputField(
                  hint: "Password",
                  inputType: "password",
                  controller: passController,
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Forgot Password ?",
            style: TextStyle(
              letterSpacing: 1.2,
              color: Color(0xFF0CC0DF),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (emailController.text.isEmpty || passController.text.isEmpty) {
                return;
              }

              try {
                await ref.read(authServiceProvider).login(
                    email: emailController.text, password: passController.text);

                ref.invalidate(authServiceProvider);
              } on AppwriteException catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 10,
              padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 12),
              backgroundColor: const Color(0xFF04434E),
            ),
            child: const Text(
              "Sign In",
              style: TextStyle(
                letterSpacing: 1.8,
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Image(
        image: const AssetImage("assets/auth_footer.png"),
        width: screenWidth, // Set the width to the screen width
        fit: BoxFit.cover,
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField(
      {super.key, this.hint, this.inputType, required this.controller});
  final TextEditingController controller;
  final String? hint;
  final String? inputType;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      shadowColor: Colors.grey.withOpacity(0.5),
      borderRadius: BorderRadius.circular(10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: inputType == "email"
              ? const Icon(Icons.email_rounded, color: Color(0xFF6D6D6D))
              : const Icon(Icons.lock, color: Color(0xFF6D6D6D)),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF9A9A9A)),
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xFFE4E4E4), width: 1.0),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xFFE4E4E4), width: 1.0),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xFFE4E4E4), width: 1.0),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xFFE4E4E4), width: 1.0),
              borderRadius: BorderRadius.circular(10)),
          disabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xFFE4E4E4), width: 1.0),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
