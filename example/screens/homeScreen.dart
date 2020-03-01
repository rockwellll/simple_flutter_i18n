import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "../../lib/simple_flutter_i18n.dart";

Map<String, dynamic> ku = {'isRtl': true, 'welcome': 'بەخێر هاتيت'};
Map<String, dynamic> ar = {'isRtl': true, 'welcome': "Welcome in Arabic"};

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<I18n>(context, listen: false).load(fallback: ar);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<I18n>(context).lang;

    print(language);

    return Scaffold(
      appBar: AppBar(
        title: Text(language['welcome']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text("Change Langauge"),
              onPressed: () {
                Provider.of<I18n>(context, listen: false).setLocale('en');
              },
            )
          ],
        ),
      ),
    );
  }
}
