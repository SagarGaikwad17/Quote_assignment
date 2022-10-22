import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../model/favourite_model.dart';
import '../model/quote_model.dart';
import '../resources/app_urls.dart';
import '../utils/database_helper.dart';

class FavouriteRepository {
  Future<List<FavouriteQuote>> favouritePage() async {
    try {
      return await DatabaseHelper().retrieveQuotes();
    } catch (e) {
      throw e;
    }
  }

  Future<List<FavouriteQuote>> searchPage(String word) async {
    try {
      return await DatabaseHelper().searchQuote(word);
    } catch (e) {
      throw e;
    }
  }
}
