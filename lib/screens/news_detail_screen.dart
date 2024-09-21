import 'package:flutter/material.dart';
import 'package:my_news/models/news_model.dart';
import 'package:my_news/utils/theme.dart';

class NewsDetailScreen extends StatelessWidget {
  Article? article;

  NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: Text(
          article?.title ?? "",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: ThemeUtil.baseColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Image.network(article?.urlToImage ?? ""),
              ),
              const SizedBox(height: 10),
              Text(
                article?.title ?? "",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                article?.description ?? 'No description available',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              // Add any additional details or content
              Text(
                'Published At: ${article?.publishedAt ?? 'Unknown'}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Text(
                article?.content ?? 'No content available',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
