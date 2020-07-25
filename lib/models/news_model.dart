import 'package:newsapp/networking.dart';

class NewsModel {
  Future<dynamic> getNewsData() async {
    var url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=d907e94095a9411eabd494e7c29bde9b";
    NetworkHelper networkHelper = NetworkHelper(url);
    var newsData = await networkHelper.getData();
    return newsData["articles"];
  }

  Future<dynamic> getCategoryNewsData(String category) async {
    var url =
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=d907e94095a9411eabd494e7c29bde9b";
    NetworkHelper networkHelper = NetworkHelper(url);
    var newsData = await networkHelper.getData();
    return newsData["articles"];
  }
}
