import 'package:flutter/foundation.dart';
import 'package:quote/data/respose/api_response.dart';
import 'package:quote/repository/quote_repository.dart';
import 'package:quote/utils/utils.dart';

import '../model/favourite_model.dart';
import '../model/quote_model.dart';
import '../repository/favourite_repository.dart';
import '../utils/database_helper.dart';

class FavouriteViewModel with ChangeNotifier {
  FavouriteViewModel() {
    DatabaseHelper().initDB();
  }
  final myRepo = FavouriteRepository();
  //Response loading
  ApiResponse<List<FavouriteQuote>> listResponse = ApiResponse.loading();

  String favsearch = "";

//Setter method to pass a generic response
  setListResponse(ApiResponse<List<FavouriteQuote>> response) {
    listResponse = response;
    notifyListeners();
  }

  Future<void> fetchFavouriteQuoteList() async {
    setListResponse(ApiResponse.loading());
    myRepo.favouritePage().then((value) {
      setListResponse(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        setListResponse(ApiResponse.error(error.toString()));
        print(error);
      }
    });
  }

  Future<void> searchFavouriteQuoteList(String word) async {
    setListResponse(ApiResponse.loading());
    myRepo.searchPage(word).then((value) {
      setListResponse(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        setListResponse(ApiResponse.error(error.toString()));
        print(error);
      }
    });
  }

  Future<void> addToFavouriteQuote(String id, String quote) async {
    try {
      final result = await DatabaseHelper().insertQuote(FavouriteQuote(
        id: id,
        quote: quote,
      ));

      Utils.toastMessage("Saved");
    } catch (e) {
      print("error : - $e");
      Utils.toastMessage("Something Went Wrong !!!");
    }
  }

  Future<void> updateFavouriteQuote(String id, String quote) async {
    try {
      final result = await DatabaseHelper().updateQuote(FavouriteQuote(
        id: id,
        quote: quote,
      ));

      Utils.toastMessage("Updated");
      render();
    } catch (e) {
      print("error : - $e");
      Utils.toastMessage("Something Went Wrong !!!");
    }
  }

  Future<void> deleteFavouriteQuote(String id) async {
    try {
      DatabaseHelper().deleteQuote(id);

      Utils.toastMessage("Deleted");
      render();
    } catch (e) {
      print("error : - $e");
      Utils.toastMessage("Something Went Wrong !!!");
    }
  }

  Future<void> deleteAllFavouriteQuote() async {
    try {
      DatabaseHelper().deleteAll();

      Utils.toastMessage("Deleted all");
      fetchFavouriteQuoteList();
    } catch (e) {
      print("error : - $e");
      Utils.toastMessage("Something Went Wrong !!!");
    }
  }

  render() {
    if (favsearch.length != 0) {
      searchFavouriteQuoteList(favsearch);
    } else {
      fetchFavouriteQuoteList();
    }
  }
}
