import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../model/author_model.dart';
import '../model/quote_model.dart';
import '../resources/app_urls.dart';

class AuthorRepository {
  BaseApiServices apiServices = NetworkApiService();
  Future<AuthorResponse> authorPageApi(String? authorName) async {
    dynamic response = await apiServices
        .getApiResponse(AppUrl.AuthoreUrl + "$authorName ?? " "");
    try {
      return response = AuthorResponse.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<QuoteResponse> authorQuotePageApi(String? authorName) async {
    dynamic response = await apiServices
        .getApiResponse(AppUrl.QuoteUrl + "$authorName ?? " "");
    try {
      return response = QuoteResponse.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
