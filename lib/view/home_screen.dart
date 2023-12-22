import 'package:flutter/material.dart';
import 'package:news_portal/res/color.dart';
import 'package:news_portal/utils/routes/routes_name.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAppLogo(),
            const SizedBox(height: 20),
            _buildWelcomeText('Welcome to'),
            _buildWelcomeText('News App'),
            const SizedBox(height: 40),
            _buildLoginButton(context),
            const SizedBox(height: 20),
            _buildRegisterButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return Container(
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
          'assets/logo.jpg', // Replace with your app icon path
          width: 80,
          height: 80,
        ),
      ),
    );
  }

  Widget _buildWelcomeText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: text.contains('Welcome') ? 18 : 28,
        fontWeight:
            text.contains('Welcome') ? FontWeight.normal : FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, RoutesName.loginscreen);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.bgColor,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: const Text(
        'Login',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        // Navigate to register screen
        Navigator.pushNamed(context, RoutesName.signupscreen);
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      ),
      child: const Text(
        'Register',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
