import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/respose/status.dart';
import '../utils/database_helper.dart';
import '../view_model/author_quote_view_model.dart';
import '../view_model/favourite_view_model.dart';

class AuthorQuotePage extends StatefulWidget {
  AuthorQuotePage();

  @override
  _AuthorQuotePageState createState() => _AuthorQuotePageState();
}

class _AuthorQuotePageState extends State<AuthorQuotePage> {
  List<Widget> _samplePages = [
    Center(
      child: Text('Page 1'),
    ),
    Center(child: Text('Page 2'))
  ];
  final _controller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper().initDB();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      DatabaseHelper().initDB().whenComplete(() {
        Provider.of<AuthorQuoteViewModel>(context, listen: false)
            .fetchQuoteList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Authors Quotes'),
          centerTitle: true,
        ),
        backgroundColor: Color(0xfffbfafa),
        body: Consumer<AuthorQuoteViewModel>(
          builder: (context, value, _) {
            print(value.listResponse.status);
            int i = 0;
            switch (value.listResponse.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.error:
                return Center(
                    child: Text(value.listResponse.message.toString()));
              case Status.completed:
                return Column(
                  children: <Widget>[
                    Flexible(
                      child: PageView.builder(
                        controller: _controller,
                        itemCount: value.listResponse.data!.results!.length,
                        itemBuilder: (BuildContext context, int index) {
                          i = index;
                          return card(value
                              .listResponse.data!.results![index].content
                              .toString()); //_samplePages[index % _samplePages.length];
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(
                                10.0)), // Set rounded corner radius
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.grey,
                                  offset: Offset(1, 3))
                            ] // Make rounded corner of border
                            ),
                        child: FlatButton(
                          color: Colors.white,
                          child: Text('Save'),
                          onPressed: () {
                            String id = value.listResponse.data!.results![i].id
                                .toString();

                            String quote = value
                                .listResponse.data!.results![i].content
                                .toString();

                            Provider.of<FavouriteViewModel>(context,
                                    listen: false)
                                .addToFavouriteQuote(id, quote);
                          },
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.lightBlueAccent,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            child: Text('Prev'),
                            onPressed: () {
                              _controller.previousPage(
                                  duration: _kDuration, curve: _kCurve);
                            },
                          ),
                          FlatButton(
                            child: Text('Next'),
                            onPressed: () {
                              _controller.nextPage(
                                  duration: _kDuration, curve: _kCurve);
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                );
            }
            return Container();
          },
        ));
  }

  Widget card(String quote) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)), // Set rounded corner radius
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))
          ] // Make rounded corner of border
          ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Text('$quote'),
        ),
      ),
    );
  }
}
