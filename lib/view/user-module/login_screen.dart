import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:news_portal/data/database_helper.dart';
import 'package:news_portal/model/user.dart';
import 'package:news_portal/res/color.dart';
import 'package:news_portal/res/size_config.dart';
import 'package:news_portal/utils/routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Center(
            child: Stack(
              children: [
                _buildContainer(),
                _buildLogo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Container(
      width: SizeConfig.screenWidth * 0.75,
      height: SizeConfig.screenHeight * 0.7,
      margin: const EdgeInsets.only(top: 60, right: 20, left: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              _buildTextFormField(
                controller: _identifierController,
                label: 'Email or Mobile',
                prefixIcon: Icons.person,
                validator: (value) {
                  return value?.isEmpty == true
                      ? 'Please enter your email or mobile number'
                      : null;
                },
              ),
              const SizedBox(height: 16.0),
              _buildTextFormField(
                controller: _passwordController,
                label: 'Password',
                prefixIcon: Icons.lock,
                obscureText: true,
                validator: (value) {
                  return value?.isEmpty == true
                      ? 'Please enter a password'
                      : null;
                },
              ),
              const SizedBox(height: 82.0),
              _buildElevatedButton(),
              const SizedBox(height: 10),
              _buildSignUpRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }

  Widget _buildElevatedButton() {
    return ElevatedButton(
      onPressed: () => _onLoginButtonPressed(),
      style: ElevatedButton.styleFrom(
        primary: AppColors.bgColor,
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
      child: const Text(
        'Login',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildSignUpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: AppColors.greyColor),
        ),
        TextButton(
          child: const Text("SignUp"),
          onPressed: () => _navigateToSignUpScreen(),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            'assets/logo.jpg',
            width: 80,
            height: 80,
          ),
        ),
      ),
    );
  }

  void _onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {
      String enteredIdentifier = _identifierController.text;
      String enteredPassword = _passwordController.text;

      _loginUser(enteredIdentifier, enteredPassword);
    }
  }

  void _loginUser(String enteredIdentifier, String enteredPassword) async {
    try {
      List<User?> users = await DatabaseHelper().getAllUsers();

      if (users.isNotEmpty) {
        User? validUser = users.firstWhereOrNull(
          (user) => user!.identifier == enteredIdentifier,
        );

        if (validUser != null && validUser.password == enteredPassword) {
          _navigateToNextPage(context);
        } else {
          _showErrorMessage('Invalid username or password. Please try again.');
        }
      } else {
        _showErrorMessage('No user found. Please try again.');
      }
    } catch (e) {
      //print('Error retrieving user data: $e');
      _showErrorMessage('An error occurred. Please try again.');
    }
  }

  void _navigateToNextPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(RoutesName.newsscreen);
  }

  void _navigateToSignUpScreen() {
    Navigator.pushNamed(context, RoutesName.signupscreen);
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}
