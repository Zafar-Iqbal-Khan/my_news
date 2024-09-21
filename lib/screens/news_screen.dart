// // screens/news_screen.dart

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../provider/news_provider.dart';

// class NewsScreen extends StatelessWidget {
//   const NewsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final newsProvider = Provider.of<NewsProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Top News'),
//       ),
     
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           newsProvider.fetchTopNews();
//         },
//         child: const Icon(Icons.refresh),
//       ),
//     );
//   }
// }
