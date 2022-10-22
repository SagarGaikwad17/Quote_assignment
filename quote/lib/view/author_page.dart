import 'package:flutter/material.dart';
import 'package:quote/view_model/author_view_model.dart';
import 'package:provider/provider.dart';

import '../data/respose/status.dart';
import '../resources/components/search_bar.dart';
import '../utils/routes/routes_name.dart';
import '../view_model/author_quote_view_model.dart';

class AuthorPage extends StatefulWidget {
  AuthorPage({Key? key}) : super(key: key);

  @override
  State<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AuthorViewModel>(context, listen: false)
          .fetchResourcesListApi(" ");
    });
  }

  _onSearchFieldChanged(String value) async {
    Provider.of<AuthorViewModel>(context, listen: false)
        .fetchResourcesListApi(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Author Quote'),
          centerTitle: true,
        ),
        backgroundColor: Color(0xfffbfafa),
        body: Column(
          children: [
            SearchBar(
              title: 'Search Author',
              onPress: _onSearchFieldChanged,
            ),
            Consumer<AuthorViewModel>(
              builder: (context, value, _) {
                print(value.listResponse.status);
                switch (value.listResponse.status) {
                  case Status.loading:
                    return Expanded(
                        child:
                            const Center(child: CircularProgressIndicator()));
                  case Status.error:
                    return Center(
                        child: Text(value.listResponse.message.toString()));
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
                                  contentPadding: EdgeInsets.all(8),
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(value
                                        .listResponse.data!.results![index].name
                                        .toString()),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(value.listResponse.data!
                                        .results![index].description
                                        .toString()),
                                  ),
                                  onTap: () {
                                    Provider.of<AuthorQuoteViewModel>(context,
                                                listen: false)
                                            .authorName =
                                        value.listResponse.data!.results![index]
                                            .name
                                            .toString();
                                    Navigator.pushNamed(
                                        context, RoutesName.authorQuotePage);
                                  },
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
