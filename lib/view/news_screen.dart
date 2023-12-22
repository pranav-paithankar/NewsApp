import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_portal/model/news_module.dart';
import 'package:news_portal/res/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_portal/utils/routes/routes_name.dart';
import 'package:news_portal/view/category_screen.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Data>? newsData;
  int index = 0;

  @override
  void initState() {
    super.initState();
    fetchData(
        'national'); // Set an initial category or remove this line if not needed
  }

  Future<void> fetchData(String category) async {
    try {
      final response = await http.get(
        Uri.parse('https://inshortsapi.vercel.app/news?category=$category'),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        // Check if 'data' key exists and is a list
        if (responseData is Map &&
            responseData.containsKey('data') &&
            responseData['data'] is List) {
          final List<dynamic> jsonData = responseData['data'];

          setState(() {
            newsData = jsonData.map((item) => Data.fromJson(item)).toList();
          });
        } else {
          // Handle unexpected data structure
          print('Unexpected data structure in API response');
        }
      } else {
        // Handle error
        print('Failed to load news');
      }
    } catch (error) {
      // Handle exceptions
      print('Error: $error');
    }
  }

  void updateContent(direction) {
    int itemCount = newsData!.length;
    if (itemCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No data redirecting to main screen'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
      Navigator.of(context).pushReplacementNamed(RoutesName.newsscreen);

      return;
    }
    if (itemCount == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No data redirecting to main screen'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
      Navigator.of(context).pushReplacementNamed(RoutesName.newsscreen);

      return;
    } // Handle empty list
    if (index <= 0 && direction == DismissDirection.down) {
      index = itemCount - 1;
      setState(() {
        // Ensure the index stays within bounds
        index = index.clamp(0, itemCount - 1);
      });
    } else if (index == itemCount - 1 && direction == DismissDirection.up) {
      index = 0;
      setState(() {
        // Ensure the index stays within bounds
        index = index.clamp(0, itemCount - 1);
      });
    } else if (direction == DismissDirection.up) {
      index++;
      setState(() {
        // Ensure the index stays within bounds
        index = index.clamp(0, itemCount - 1);
      });
    } else {
      index--;
      setState(() {
        // Ensure the index stays within bounds
        index = index.clamp(0, itemCount - 1);
      });
    }
    // setState(() {
    //   // Ensure the index stays within bounds
    //   index = index.clamp(0, itemCount - 1);
    // });
  }

  String getShareText() {
    return "${newsData![index].title}\n${newsData![index].url}";
  }

  Widget newsCard(int index) {
    SizeConfig().init(context);
    if (index < 0 || index >= newsData!.length) {
      // Handle out-of-bounds index
      return Container(
        child: const Center(
          child: Text('No data '),
        ),
      );
    }

    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.2),
            child: networkImage(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              newsData![index].title ?? '',
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              newsData![index].content ?? '',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
              ),
              maxLines: 8,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              " author by ${newsData![index].author} / ${newsData![index].date}",
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12.0,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToCategorySelection() async {
    final selectedCategory = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryScreen()),
    );

    if (selectedCategory != null) {
      fetchData(selectedCategory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: newsData != null
            ? Dismissible(
                background: newsCard(index - 1),
                child: newsCard(index),
                secondaryBackground: newsCard(index + 1),
                resizeDuration: const Duration(milliseconds: 10),
                key: Key(index.toString()),
                direction: DismissDirection.vertical,
                onDismissed: (direction) {
                  updateContent(direction);
                },
              )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToCategorySelection();
        },
        child: const Icon(Icons.category),
      ),
    );
  }

  placeholderImage() {
    return Image.network(
      'https://cdn.vectorstock.com/i/preview-1x/82/99/no-image-available-like-missing-picture-vector-43938299.jpg', // Use a default image or handle null
      fit: BoxFit.fill,
    );
  }

  networkImage() {
    try {
      return CachedNetworkImage(
        imageUrl: newsData![index].imageUrl ?? "",
        placeholder: (context, url) => placeholderImage(),
        errorWidget: (context, url, error) => placeholderImage(),
        fit: BoxFit.fill,
      );
    } catch (_) {
      return placeholderImage();
    }
  }
}
