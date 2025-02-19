// import 'package:flutter/material.dart';
// import 'package:news_app/models/category_news_model.dart';
// import 'package:news_app/models/news_channel_headline_model.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class NewsRepository {
//   // FOR HEADLINE
//   Future<NewChannelHeadlineModel> getNewsChannelHeadlineApi(
//       String newsChannel) async {
//     String url =
//         'https://newsapi.org/v2/top-headlines?sources=$newsChannel&apiKey=9682d2cc84de4a3f97b19212a4e885df';

//     final response = await http.get(Uri.parse(url));
//     final data = jsonDecode(response.body);
//     try {
//       if (response.statusCode == 200) {
//         return NewChannelHeadlineModel.fromJson(data);
//       } else {
//         Center(child: CircularProgressIndicator());
//       }
//     } catch (e) {
//       throw Exception('Error');
//     }
//     throw Exception('Error');
//   }

//   // FOR CATEGORRIES
//   Future<CategoryNewsModel> fetchCategoriesNewsApi(String category) async {
//     String url =
//         'https://newsapi.org/v2/everything?q=$category&apiKey=9682d2cc84de4a3f97b19212a4e885df';

//     final response = await http.get(Uri.parse(url));
//     final data = jsonDecode(response.body);
//     try {
//       if (response.statusCode == 200) {
//         return CategoryNewsModel.fromJson(data);
//       } else {
//         Center(child: CircularProgressIndicator());
//       }
//     } catch (e) {
//       throw Exception('Error');
//     }
//     throw Exception('Error');
//   }
// }

// 💨💨💨💨💨💨💨💨 GPT 💨💨💨💨💨💨💨💨💨💨💨💨💨💨💨💨💨💨
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/category_news_model.dart';
import 'package:news_app/models/news_channel_headline_model.dart';

class NewsRepository {
  static const String _apiKey =
      '9682d2cc84de4a3f97b19212a4e885df'; // Store securely

  // Fetch News Channel Headlines
  Future<NewChannelHeadlineModel> getNewsChannelHeadlineApi(
      String newsChannel) async {
    final String url =
        'https://newsapi.org/v2/top-headlines?sources=$newsChannel&apiKey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return NewChannelHeadlineModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load headlines: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news headlines: $e');
    }
  }

  // Fetch Category-Based News
  Future<CategoryNewsModel> fetchCategoriesNewsApi(String category) async {
    final String url =
        'https://newsapi.org/v2/everything?q=$category&apiKey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return CategoryNewsModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load category news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching category news: $e');
    }
  }
}
