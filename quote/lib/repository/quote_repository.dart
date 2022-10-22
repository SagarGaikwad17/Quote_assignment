import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../model/quote_model.dart';
import '../resources/app_urls.dart';

class QuoteRepository {
  BaseApiServices apiServices = NetworkApiService();
  Future<QuoteResponse> quotePageApi(String? authorName,
      {String? limit = "10"}) async {
    dynamic response = await apiServices
        .getApiResponse(AppUrl.QuoteUrl + "$authorName ?? " "&limit=$limit");
    try {
      return response = QuoteResponse.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
