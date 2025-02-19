import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/category_news_model.dart';
import 'package:news_app/screens/categories_screen.dart';
import 'package:news_app/screens/news_details_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// options to show in popup
enum FilterList { bbcNews, alJazeera, aryNews, axios }

class _HomeState extends State<Home> {
  // Selected Value
  FilterList? selectedValue;
  // initial selected news channel
  String initialNews = 'bbc-news';
  // define format of data and time
  final format = DateFormat('MMMM dd, yyyy');
  // Initialize an object class
  NewsViewModel newsViewModel = NewsViewModel();
  @override
  Widget build(BuildContext context) {
    // widht and height
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoriesScreen()));
          },
          icon: Image.asset(
            'images/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        centerTitle: true,
        title: Text(
          "News",
          style: GoogleFonts.poppins(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<FilterList>(
              initialValue: selectedValue,
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              // on
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  initialNews = 'bbc-news';
                }

                if (FilterList.alJazeera.name == item.name) {
                  initialNews = 'al-jazeera-english';
                }

                if (FilterList.aryNews.name == item.name) {
                  initialNews = 'ary-news';
                }

                if (FilterList.axios.name == item.name) {
                  initialNews = 'axios';
                }

                setState(() {
                  selectedValue = item;
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                    PopupMenuItem(
                      value: FilterList.bbcNews,
                      child: Text("BBC News"),
                    ),
                    PopupMenuItem(
                      value: FilterList.alJazeera,
                      child: Text("Al Jazeera English"),
                    ),
                    PopupMenuItem(
                      value: FilterList.aryNews,
                      child: Text("Ary News"),
                    ),
                    PopupMenuItem(
                      value: FilterList.axios,
                      child: Text("Axios"),
                    ),
                  ])
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * .55,
              width: width,
              child: FutureBuilder(
                  future: newsViewModel.getNewsChannelHeadlineApi(initialNews),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.articles!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // Date time convert into STRING
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
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
                            child: SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Image Container
                                  Container(
                                    height: height * 0.6,
                                    width: width * .9,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: height * .02),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child:
                                              CircularProgressIndicator(), // Loader while the image loads
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: Icon(Icons.error,
                                              size: 50,
                                              color: Colors.red), // Error icon
                                        ),
                                      ),
                                    ),
                                  ),

                                  // POSITIONED
                                  Positioned(
                                    bottom: 20,
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      color: Colors.white,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                // card width and height
                                                width: width * 0.7,
                                                height: height * 0.08,
                                                child: Text(
                                                  "${snapshot.data!.articles![index].title}",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.7,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      // source
                                                      Text(
                                                        "${snapshot.data!.articles![index].source!.name}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      // date
                                                      Text(
                                                        format.format(dateTime),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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

            // category work
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder<CategoryNewsModel>(
                  future: newsViewModel.fetchCategoriesNewsApi('general'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.articles!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // Date time convert
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
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
                                        color: Colors
                                            .grey[300], // Placeholder color
                                        child: Center(
                                            child:
                                                CircularProgressIndicator()), // Loading indicator
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        height: height * .18,
                                        width: width * .3,
                                        color: Colors.grey[
                                            400], // Error background color
                                        child: Icon(Icons.error,
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
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

// spin Kit 2

const spinKit2 = SpinKitFadingCircle(
  size: 50,
  color: Colors.amber,
);
