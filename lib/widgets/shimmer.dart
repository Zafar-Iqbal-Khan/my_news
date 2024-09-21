import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsShimmer extends StatelessWidget {
  const NewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Column with title, description, and date shimmer
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title shimmer
                  Container(
                    width: double.infinity,
                    height: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  // Description shimmer
                  Container(
                    width: double.infinity,
                    height: 15,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  // Date shimmer
                  Container(
                    width: 100,
                    height: 15,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Image shimmer
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
