import 'package:flutter/material.dart';
import 'package:news_portal/data/database_helper.dart';
import 'package:news_portal/model/user.dart';
import 'package:news_portal/res/color.dart';
import 'package:news_portal/res/size_config.dart';
import 'package:news_portal/utils/routes/routes_name.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final DatabaseHelper _databaseHelper = DatabaseHelper();

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
      margin: EdgeInsets.only(top: 60, bottom: 20, right: 20, left: 20),
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 70),
                _buildTextFormField(
                  controller: _identifierController,
                  label: 'Email or Mobile',
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email or mobile number';
                    }

                    final isEmail = RegExp(
                      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
                    ).hasMatch(value);
                    final isMobile = RegExp(r'^[0-9]{10}$').hasMatch(value);

                    if (!isEmail && !isMobile) {
                      return 'Please enter a valid email or mobile number';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                _buildTextFormField(
                  controller: _usernameController,
                  label: 'Username',
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    // You can add additional validation for the username if needed
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                _buildTextFormField(
                  controller: _passwordController,
                  label: 'Password',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 62.0),
                _buildElevatedButton(),
                const SizedBox(height: 10),
                _buildLoginRow(),
              ],
            ),
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
      onPressed: () => _onSignUpButtonPressed(),
      style: ElevatedButton.styleFrom(
        primary: AppColors.bgColor,
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
      child: const Text(
        'Sign Up',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildLoginRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(color: AppColors.greyColor),
        ),
        TextButton(
          child: const Text("Login"),
          onPressed: () => _navigateToLoginScreen(),
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

  void _onSignUpButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      String identifier = _identifierController.text;
      String username = _usernameController.text;
      String password = _passwordController.text;

      User newUser = User(
        identifier: identifier,
        username: username,
        password: password,
      );

      int userId = await _databaseHelper.insertUser(newUser);

      // ignore: use_build_context_synchronously
      _showSuccessMessage(context);

      // Delay navigation to the next page
      Future.delayed(const Duration(seconds: 2), () {
        _navigateToLoginScreen();
      });

      print(
          'User ID: $userId, Identifier: $identifier, Username: $username, Password: $password');
    }
  }

  void _navigateToLoginScreen() {
    Navigator.pushReplacementNamed(context, RoutesName.loginscreen);
  }

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('User Created Successfully!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }
}
