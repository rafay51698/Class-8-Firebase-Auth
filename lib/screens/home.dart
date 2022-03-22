import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  createUser() async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text, password: passController.text);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      emailController.clear();
      passController.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            // style: TextStyle(color: white),
            controller: emailController,
            autocorrect: true,
            // autofocus: true,
            // obscureText: true,

            keyboardType: TextInputType.name,
            // validator: (val) =>
            //     val!.isEmpty ? "This field must not be empty!" : null,
            decoration: InputDecoration(
              // prefixIconColor: Colors.white,

              labelText: "Email",
              // labelStyle: TextStyle(color: white),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              helperText: "rafay@gmail.com",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            // style: TextStyle(color: white),
            controller: passController,
            autocorrect: true,
            // autofocus: true,
            // obscureText: true,

            keyboardType: TextInputType.name,
            // validator: (val) =>
            //     val!.isEmpty ? "This field must not be empty!" : null,
            decoration: InputDecoration(
              // prefixIconColor: Colors.white,

              labelText: "Password",
              // labelStyle: TextStyle(color: white),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              // helperText: "Abdul Rafay",
            ),
          ),
          ElevatedButton(
            onPressed: createUser,
            child: const Text("Signup"),
          ),
        ],
      ),
    ));
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
