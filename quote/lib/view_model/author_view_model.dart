import 'package:flutter/foundation.dart';
import 'package:quote/data/respose/api_response.dart';
import 'package:quote/repository/author_repository.dart';

import '../model/author_model.dart';

class AuthorViewModel with ChangeNotifier {
  final myRepo = AuthorRepository();
  //Response loading
  ApiResponse<AuthorResponse> listResponse = ApiResponse.loading();

//Setter method to pass a generic response
  setListResponse(ApiResponse<AuthorResponse> response) {
    listResponse = response;
    notifyListeners();
  }

  Future<void> fetchResourcesListApi(String? authorName) async {
    setListResponse(ApiResponse.loading());
    myRepo.authorPageApi(authorName).then((value) {
      setListResponse(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        setListResponse(ApiResponse.error(error.toString()));
        print(error);
      }
    });
  }
}
