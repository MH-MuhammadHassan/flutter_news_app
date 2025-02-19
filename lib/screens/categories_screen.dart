import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/category_news_model.dart';
import 'package:news_app/screens/news_details_screen.dart';
import 'package:news_app/view_model/news_view_model.dart'; // (for date format)

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // Creates an instance of NewsViewModel to fetch news data.
  NewsViewModel newsViewModel = NewsViewModel();

  // Defines the date format (e.g., "January 01, 2024").
  final format = DateFormat('MMMM dd, yyyy');

  // Stores the currently selected category (default: 'General').
  String initialCategory = 'General';

  // A list of categories available for selection.
  List<String> categoriesList = [
    'General',
    'Health',
    'Business',
    'Entertainment',
    'Science',
    'Sports',
    'Technology'
  ];

  @override
  Widget build(BuildContext context) {
    // Gets the full width and height of the screen
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            // Category Selection Buttons:
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        // updates the selected category.
                        initialCategory = categoriesList[index];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: initialCategory == categoriesList[index]
                              ? Colors.blueAccent
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Center(
                            child: Text(
                              categoriesList[index].toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Space between category selection buttons and news data
            SizedBox(
              height: 20,
            ),
            // Fetching News Data Using FutureBuilder
            Expanded(
              child: FutureBuilder<CategoryNewsModel>(
                  future: newsViewModel.fetchCategoriesNewsApi(initialCategory),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      // Displaying the List of News Articles:
                      return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        // shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // Converts the API date format to a DateTime object.
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          // Passes news details like title, image, author, description, and source.
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsDetailsScreen(
                                            newsPublishedAt: snapshot.data!
                                                .articles![index].publishedAt
                                                .toString(),
                                            newsImage: snapshot.data!
                                                .articles![index].urlToImage
                                                .toString(),
                                            newsTitle: snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            author: snapshot
                                                .data!.articles![index].author
                                                .toString(),
                                            newsDescription: snapshot.data!
                                                .articles![index].description
                                                .toString(),
                                            newsContent: snapshot
                                                .data!.articles![index].content
                                                .toString(),
                                            source: snapshot.data!
                                                .articles![index].source!.name
                                                .toString(),
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                children: [
                                  // Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      height: height * .18,
                                      width: width * .3,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        height: height * .18,
                                        width: width * .3,
                                        alignment: Alignment.center,
                                        color: Colors.grey[
                                            300], // Placeholder background color
                                        child:
                                            CircularProgressIndicator(), // Show loader while loading
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        height: height * .18,
                                        width: width * .3,
                                        alignment: Alignment.center,
                                        color: Colors.grey[300],
                                        child: Icon(Icons.error,
                                            size: 30,
                                            color: Colors.red), // Error icon
                                      ),
                                    ),
                                  ),

                                  // tittle
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      height: height * .18,
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            maxLines: 3,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Spacer(),
                                          // row
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // source
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              // date
                                              Text(
                                                format.format(dateTime),
                                                maxLines: 3,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
