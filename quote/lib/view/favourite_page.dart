import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/respose/status.dart';
import '../resources/components/search_bar.dart';
import '../utils/database_helper.dart';
import '../utils/routes/routes_name.dart';
import '../view_model/favourite_view_model.dart';

class FavouritePage extends StatefulWidget {
  FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  TextEditingController _textFieldController = TextEditingController();

  String? codeDialog;
  String? valueText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper().initDB();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      DatabaseHelper().initDB().whenComplete(() {
        Provider.of<FavouriteViewModel>(context, listen: false)
            .fetchFavouriteQuoteList();
      });
    });
  }

  _onSearchFieldChanged(String value) async {
    if (value.length != 0) {
      Provider.of<FavouriteViewModel>(context, listen: false).favsearch = value;
      Provider.of<FavouriteViewModel>(context, listen: false)
          .searchFavouriteQuoteList(value);
    } else {
      Provider.of<FavouriteViewModel>(context, listen: false).favsearch = value;
      Provider.of<FavouriteViewModel>(context, listen: false)
          .fetchFavouriteQuoteList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Favourite Quote'),
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<FavouriteViewModel>(context, listen: false)
                        .deleteAllFavouriteQuote();
                  },
                  child: Icon(
                    Icons.delete_forever,
                    size: 26.0,
                  ),
                )),
          ],
        ),
        backgroundColor: Color(0xfffbfafa),
        body: Column(
          children: [
            SearchBar(
              title: 'Search Favourite Quote',
              onPress: _onSearchFieldChanged,
            ),
            Consumer<FavouriteViewModel>(
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
                          itemCount: value.listResponse.data!.length,
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
                                        .listResponse.data![index].quote
                                        .toString()),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 18.0),
                                    child: Container(
                                      height: 30,
                                      child: Row(
                                        children: [
                                          RaisedButton(
                                            textColor: Colors.white,
                                            color: Colors.green,
                                            onPressed: () {
                                              String id = value
                                                  .listResponse.data![index].id
                                                  .toString();

                                              _textFieldController.text = value
                                                  .listResponse
                                                  .data![index]
                                                  .quote
                                                  .toString();
                                              ;

                                              _displayTextInputDialog(
                                                  context, id);
                                            },
                                            child: const Text('Update'),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          RaisedButton(
                                            textColor: Colors.white,
                                            color: Colors.green,
                                            onPressed: () {
                                              setState(() {
                                                String id = value.listResponse
                                                    .data![index].id
                                                    .toString();
                                                Provider.of<FavouriteViewModel>(
                                                        context,
                                                        listen: false)
                                                    .deleteFavouriteQuote(id);
                                              });
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      ),
                                    ),
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

  Future<void> _displayTextInputDialog(BuildContext context, String id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Type ..."),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    Provider.of<FavouriteViewModel>(context, listen: false)
                        .updateFavouriteQuote(id, _textFieldController.text);

                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
