import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote/utils/database_helper.dart';

import '../data/respose/status.dart';
import '../resources/components/search_bar.dart';
import '../utils/database_helper.dart';
import '../view_model/favourite_view_model.dart';
import '../view_model/quote_view_model.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageeState();
}

class _SearchPageeState extends State<SearchPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper().initDB();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<QuoteViewModel>(context, listen: false)
    //       .fetchQuoteListApi("");
    // });
  }

  _onSearchFieldChanged(String value) async {
    if (value.length != 0) {
      Provider.of<QuoteViewModel>(context, listen: false)
          .fetchQuoteListApi(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Search Quote'),
          centerTitle: true,
        ),
        backgroundColor: Color(0xfffbfafa),
        body: Column(
          children: [
            SearchBar(
              title: 'Search Quote',
              onPress: _onSearchFieldChanged,
            ),
            Consumer<QuoteViewModel>(
              builder: (context, value, _) {
                print(value.listResponse.status);
                switch (value.listResponse.status) {
                  case Status.loading:
                    return Expanded(
                        child:
                            const Center(child: CircularProgressIndicator()));
                  case Status.error:
                    return Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 28.0),
                            child: Text(value.listResponse.message.toString()),
                          )),
                        ],
                      ),
                    );
                  case Status.completed:
                    return Expanded(
                      child: ListView.builder(
                          itemCount: value.listResponse.data!.results!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            10.0)), // Set rounded corner radius
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          color: Colors.grey,
                                          offset: Offset(1, 3))
                                    ] // Make rounded corner of border
                                    ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(20),
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(value.listResponse.data!
                                        .results![index].content
                                        .toString()),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(value.listResponse.data!
                                        .results![index].author
                                        .toString()),
                                  ),
                                  trailing: OutlinedButton(
                                    onPressed: () async {
                                      String id = value
                                          .listResponse.data!.results![index].id
                                          .toString();

                                      String quote = value.listResponse.data!
                                          .results![index].content
                                          .toString();

                                      Provider.of<FavouriteViewModel>(context,
                                              listen: false)
                                          .addToFavouriteQuote(id, quote);
                                    },
                                    child: Text("save"),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                }
                return Container();
              },
            ),
          ],
        ));
  }
}
