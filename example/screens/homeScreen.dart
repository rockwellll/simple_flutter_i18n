import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../lib/simple_flutter_i18n.dart';

Map<String, dynamic> ku = {'isRtl': true, 'welcome': 'بەخێر هاتيت'};

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<I18n>(context).lang;

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
                Provider.of<I18n>(context, listen: false).setLocale(ku);
              },
            )
          ],
        ),
      ),
    );
  }
}
