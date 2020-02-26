import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../lib/simple_flutter_i18n.dart';
import './screens/homeScreen.dart';

void main() => runApp(MyApp());

Map<String, dynamic> en = {'isRtl': false, 'welcome': "Welcome"};

class MyApp extends StatelessWidget {
  Widget _builder(context, child) {
    final isRtl = Provider.of<I18n>(context).isRtl;

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: I18n())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        builder: _builder,
        home: HomeScreen(),
      ),
    );
  }
}
