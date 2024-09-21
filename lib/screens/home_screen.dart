// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_news/models/news_model.dart';
import 'package:my_news/provider/auth_provider.dart';
import 'package:my_news/provider/news_provider.dart';
import 'package:my_news/screens/news_detail_screen.dart';
import 'package:my_news/utils/routes.dart';
import 'package:my_news/utils/theme.dart';
import 'package:my_news/widgets/shimmer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).fetchTopNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xffF5F9FD),
      // appBar: AppBar(title: const Text('Home')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            width: MediaQuery.of(context).size.width,
            color: ThemeUtil.baseColor,
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "MyNews",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () async {
                    await Provider.of<AuthProvider>(context, listen: false)
                        .signOut();
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.authScreen);
                  },
                  child: const Icon(Icons.logout, color: Colors.white),
                ),
              ],
            ),
          ),
          newsProvider.loading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const NewsShimmer();
                    },
                  ),
                )
              : newsProvider.error.isNotEmpty
                  ? Center(child: Text(newsProvider.error))
                  : Expanded(
                      child: ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: newsProvider.articles.length,
                        itemBuilder: (context, index) {
                          Article? article = newsProvider.articles[index];
                          if (article?.title == "[Removed]") {
                            return const SizedBox.shrink();
                          }
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      NewsDetailScreen(article: article)));
                            },
                            child: NewsDetailWidget(article: article),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}

class NewsDetailWidget extends StatelessWidget {
  NewsDetailWidget({super.key, required this.article});
  Article? article;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          SizedBox(
            // padding: const EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width * 0.58,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article?.title ?? "",
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                Text(
                  article?.description ?? "",
                  maxLines: 3,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 6),
                Text(
                  article?.publishedAt.toString() ?? "",
                  maxLines: 3,
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          NewsImage(
            imageUrl: article?.urlToImage ?? "",
          ),
          // SizedBox(
          //   height: 100,
          //   width: 100,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(10),
          //     child: Image.network(
          //       article?.urlToImage ?? "",
          //       fit: BoxFit.cover,
          //       errorBuilder: (context, error, stackTrace) {
          //         return const SizedBox();
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class NewsImage extends StatelessWidget {
  final String? imageUrl;

  const NewsImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imageUrl ?? "",
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox(); // Empty if there's an error loading the image
          },
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child; // Image is fully loaded
            } else {
              // Show shimmer while the image is loading
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.white,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
