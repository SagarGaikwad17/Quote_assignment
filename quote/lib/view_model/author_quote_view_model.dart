import 'package:flutter/foundation.dart';
import 'package:quote/data/respose/api_response.dart';
import 'package:quote/repository/author_repository.dart';

import '../model/quote_model.dart';

class AuthorQuoteViewModel with ChangeNotifier {
  final myRepo = AuthorRepository();
  //Response loading
  ApiResponse<QuoteResponse> listResponse = ApiResponse.loading();

  String authorName = " ";

//Setter method to pass a generic response
  setListResponse(ApiResponse<QuoteResponse> response) {
    listResponse = response;
    notifyListeners();
  }

  Future<void> fetchQuoteList() async {
    setListResponse(ApiResponse.loading());
    myRepo.authorQuotePageApi(authorName).then((value) {
      setListResponse(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        setListResponse(ApiResponse.error(error.toString()));
        print(error);
      }
    });
  }
}
