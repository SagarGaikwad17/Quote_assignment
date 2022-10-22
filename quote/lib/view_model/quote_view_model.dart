import 'package:flutter/foundation.dart';
import 'package:quote/data/respose/api_response.dart';
import 'package:quote/repository/quote_repository.dart';

import '../model/quote_model.dart';

class QuoteViewModel with ChangeNotifier {
  final myRepo = QuoteRepository();
  //Response loading
  ApiResponse<QuoteResponse> listResponse = ApiResponse.loading();

//Setter method to pass a generic response
  setListResponse(ApiResponse<QuoteResponse> response) {
    listResponse = response;
    notifyListeners();
  }

  Future<void> fetchQuoteListApi(String? authorName) async {
    setListResponse(ApiResponse.loading());
    myRepo.quotePageApi(authorName).then((value) {
      setListResponse(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        setListResponse(ApiResponse.error(error.toString()));
        print(error);
      }
    });
  }
}
