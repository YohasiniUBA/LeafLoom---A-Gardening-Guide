import 'package:flutter/material.dart';
import 'package:leaf_loom/registration_page.dart'; // Import the RegistrationPage class
import 'package:leaf_loom/database_helper.dart';
import 'package:leaf_loom/home_page.dart'; // Import the HomePage class

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController passwordController = TextEditingController();

  late FocusNode usernameFocusNode;

  late TextEditingController usernameController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    usernameFocusNode = FocusNode();
    usernameFocusNode.addListener(() {
      if (!usernameFocusNode.hasFocus) {
        if (usernameController.text.isEmpty) {
          _showUsernameErrorMessage();
        }
      }
    });
  }

  @override
  void dispose() {
    usernameFocusNode.dispose();
    super.dispose();
  }

  void _showUsernameErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Username is required.'),
        duration: Duration(seconds: 5),
      ),
    );
  }

  void _showPasswordErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password is required.'),
        duration: Duration(seconds: 5),
      ),
    );
  }

  void _showPasswordLengthErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password should be between 8 and 15 characters.'),
        duration: Duration(seconds: 5),
      ),
    );
  }

  void _login() async {
    String username = usernameController.text;
    String password = passwordController.text;

    print('login page: $username');
    if (username.isEmpty) {
      _showUsernameErrorMessage();
      return;
    }

    if (password.isEmpty) {
      _showPasswordErrorMessage();
      return;
    }

    if (password.length < 8 || password.length > 15) {
      _showPasswordLengthErrorMessage();
      return;
    }

    bool isAuthenticated = await DatabaseHelper.instance.verifyUser(
        username, password);

    if (isAuthenticated) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          HomePage(username: username))); // Replace current screen with HomePage
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username or password.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _navigateToRegistrationPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegistrationPage()));
  }

  @override
  Widget build(BuildContext context) {
    usernameController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFC1E1C1),
          child: Column(
            children: [
              Container(
                color: Color(0xFF588C7E),
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'website');
                      },
                      child: Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'LeafLoom',
                        style: TextStyle(
                          fontFamily: 'Livvic',
                          fontSize: 24,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 300,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF588C7E),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: usernameController,
                        focusNode: usernameFocusNode,
                        decoration: InputDecoration(
                          labelText: 'Username:',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password:',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 8 || value.length > 15) {
                            return 'Password should be between 8 and 15 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _login,
                        child: Text('Login'),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: _navigateToRegistrationPage,
                        child: Text(
                            "Don't have an account? Register", style: TextStyle(
                            color: Colors.white)), // Change text color to white
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20), // Add some space at the bottom
              Container(
                color: Color(0xFF588C7E),
                padding: EdgeInsets.all(20),
                child: Text(
                  'Contact Us: support@gardeningmadeeasy.com | Phone: +91 9846263749',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
