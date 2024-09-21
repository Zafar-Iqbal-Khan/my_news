import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:my_news/utils/constants.dart';
import 'dart:convert';
import '../utils/network_util.dart';

class NewsService {
  // Fetch top headlines
  Future<String> fetchTopNews({String country = 'us'}) async {
    // Check network connectivity
    if (!await NetworkUtil.isConnected()) {
      print('No internet connection');
      return ""; // Return an empty list if there's no connection
    }

    final Uri url = Uri.parse(
        '${Constants.BASE_URL}?country=${Constants.DEFAULT_COUNTRY}&apiKey=${Constants.NEWS_API_KEY}');
    print(url);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // log(response.body);
        return response.body;
      } else {
        print('Failed to load news. Status Code: ${response.statusCode}');
        return "";
      }
    } catch (e) {
      print('Error fetching news: $e');
      return "";
    }
  }
}
