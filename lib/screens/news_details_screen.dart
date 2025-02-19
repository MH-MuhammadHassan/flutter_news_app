import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String newsImage,
      newsTitle,
      author,
      newsDescription,
      newsContent,
      newsPublishedAt,
      source;
  // Added link for "Read More"

  const NewsDetailsScreen({
    super.key,
    required this.newsImage,
    required this.newsTitle,
    required this.newsPublishedAt,
    required this.newsDescription,
    required this.author,
    required this.source,
    required this.newsContent,
  });

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    DateTime dateTime = DateTime.parse(widget.newsPublishedAt);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "News Details",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News Image
            Container(
              width: width,
              height: height * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: widget.newsImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // News Title
            Text(
              widget.newsTitle,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // News Meta Info (Source & Date)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.source,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                Text(
                  format.format(dateTime),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // News Description
            Text(
              widget.newsDescription,
              style: const TextStyle(
                  fontSize: 16, color: Colors.black87, height: 1.5),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// 💨💨💨💨💨💨💨💨💨  GPT CODE  💨💨💨💨💨💨💨💨💨
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class NewsDetailsScreen extends StatelessWidget {
//   final String newsImage, newsTitle, author, newsDescription, newsContent, newsPublishedAt, source;

//   const NewsDetailsScreen({
//     super.key,
//     required this.newsImage,
//     required this.newsTitle,
//     required this.newsPublishedAt,
//     required this.newsDescription,
//     required this.author,
//     required this.source,
//     required this.newsContent,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.sizeOf(context).width;
//     final height = MediaQuery.sizeOf(context).height;
//     final dateTime = DateTime.parse(newsPublishedAt);
//     final formattedDate = DateFormat('MMMM dd, yyyy').format(dateTime);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           "News Details",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: CachedNetworkImage(
//                 imageUrl: newsImage,
//                 width: width,
//                 height: height * 0.35,
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//               ),
//             ),
//             const SizedBox(height: 15),
//             Text(newsTitle, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(source, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
//                 Text(formattedDate, style: const TextStyle(fontSize: 14, color: Colors.grey)),
//               ],
//             ),
//             const SizedBox(height: 15),
//             Text(newsDescription, style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5)),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
