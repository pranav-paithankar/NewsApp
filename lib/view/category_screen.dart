import 'package:flutter/material.dart';
import 'package:news_portal/res/color.dart';
import 'package:news_portal/utils/utils.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatelessWidget {
  Utils utils = Utils();

  CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text('Select Category'),
      ),
      body: ListView.builder(
        itemCount: utils.categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(utils.categories[index]),
            onTap: () {
              Navigator.pop(context, utils.categories[index]);
            },
          );
        },
      ),
    );
  }
}
