// Import necessary packages
import 'package:flutter/material.dart';
import 'package:my_news/models/news_model.dart';

import '../services/news_services.dart';

class NewsProvider with ChangeNotifier {
  // Create an instance of the NewsService to interact with the News API
  final NewsService _newsService = NewsService();

  // Private list to hold fetched articles
  List<Article> _articles = [];

  // Private boolean to track loading state
  bool _loading = true;

  // Private string to hold error messages, if any
  String _error = '';

  // Public getter to access the list of articles
  List<dynamic> get articles => _articles;

  // Public getter to check the loading state
  bool get loading => _loading;

  // Public getter to retrieve error messages
  String get error => _error;

  // Method to fetch top news articles
  Future<void> fetchTopNews({String country = 'us'}) async {
    // Set loading state to true and reset error
    _loading = true;
    _error = '';

    // Notify listeners of state change
    notifyListeners();

    try {
      // Fetch top news articles from the API
      var response = await _newsService.fetchTopNews(country: country);

      // Parse the response into a NewsModel object
      NewsModel? newsModel = newsModelFromJson(response);

      // Update the list of articles with the fetched data
      _articles = newsModel.articles!;
    } catch (e) {
      // Set error message if fetching fails
      _error = 'Failed to fetch news: $e';
    } finally {
      // Set loading state to false once the operation is complete
      _loading = false;

      // Notify listeners of the updated state
      notifyListeners();
    }
  }
}
