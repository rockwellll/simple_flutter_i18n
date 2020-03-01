import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../lib/registry.dart';

import '../lib/simple_flutter_i18n.dart';
import './screens/homeScreen.dart';

Map<String, dynamic> en = {'isRtl': false, 'welcome': "Welcome"};
Map<String, dynamic> ku = {'isRtl': true, 'welcome': "Welcome in kurdish"};
Map<String, dynamic> ar = {'isRtl': true, 'welcome': "Welcome in Arabic"};

void main() {
  I18nRegistry.register('en', en);
  I18nRegistry.register('ku', ku);
  I18nRegistry.register('ar', ar);

  I18nRegistry.setInitialLanguage(en);

  runApp(MyApp());
}

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
      providers: [ChangeNotifierProvider(create: (dd) => I18n())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        builder: _builder,
        home: HomeScreen(),
      ),
    );
  }
}
