import 'package:http/http.dart';
import 'package:news_app/models/category_news_model.dart';
import 'package:news_app/models/news_channel_headline_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final repo = NewsRepository();

// for channel
  Future<NewChannelHeadlineModel> getNewsChannelHeadlineApi(
      String channelName) async {
    final response = await repo.getNewsChannelHeadlineApi(channelName);
    return response;
  }

  // for Categories
  Future<CategoryNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await repo.fetchCategoriesNewsApi(category);
    return response;
  }
}
