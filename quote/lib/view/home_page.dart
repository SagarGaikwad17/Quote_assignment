import 'package:flutter/material.dart';
import 'package:quote/view_model/author_view_model.dart';
import 'package:provider/provider.dart';

import '../data/respose/status.dart';
import '../resources/components/card.dart';
import '../utils/routes/routes_name.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Quotes'),
        centerTitle: true,
      ),
      backgroundColor: Color(0xfffbfafa),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomeCard(
                    title: 'Author Quote',
                    onPress: () {
                      Navigator.pushNamed(context, RoutesName.authorPage);
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomeCard(
                    title: 'Search Quote',
                    onPress: () {
                      Navigator.pushNamed(context, RoutesName.searchPage);
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomeCard(
                    title: 'Favourite Quote',
                    onPress: () {
                      Navigator.pushNamed(context, RoutesName.favouritePage);
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
