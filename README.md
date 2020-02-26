# simple_flutter_i18n
flutter internationalization made simple and easy to use.

## Motive
while i was searching for the packages to help me with multi-langauge stuff , setting them up was hard, working with them was even harder, so i created this simple package to help me
i hope it helps you to.

## How to use: 
this class is to be used with the [provider](https://pub.dev/packages/provider) package,


 Properties   | Description                          | Data type
------------- | ------------------------------------ | ------------
lang          | the current language,                | **Map<String, dymanic>**
isRtl         | gets the rtl of the current langauge | **boll**



## Using it

the example directory show how to set up the class to work in your project


1- import it

```dart
import "package:simple_flutter_i18n/simple_flutter_i18n.dart";
```
***

2- proivde it in the list of providers in your application

```dart
MultiProvider(
  providers : [  // other providers of your application
        ChangeNotifierProvider.value(value: I18n())
      ],
  child : MaterialApp(
    // rest of your application
  ),
);
```

***

# important step
4 - in the first screen of your application you should call the load method and pass a **fallback** parameter, which will be used as your app's initial langauge.
the best location to do so is the **initState** of your first screen

```dart

MultiProvider(
  providers : [  // other providers of your application
        ChangeNotifierProvider.value(value: I18n())
      ],
  child : MaterialApp(
    home: HomeScreen()
    // rest of your application
  ),
);

***

// home_screen.dart

@override
void initState() {
  super.initState();
  
  Provider.of<I18n>(context, listen: false).load(fallback: en); // en is your initial language
}
```

if there exists a current langauge in the storgae, the package will use that, else it will use the fallback parameter and will call  **I18n.persist** to persist the language.

3 - anywhere you need to change the direction of a Widget, wrap it in a [Directionality](https://api.flutter.dev/flutter/widgets/Directionality-class.html) widget

```dart

final isRtl = Provider.of<I18n>(context).isRtl;

return Directionality(
  textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
  child: YourWidget(),
);

```

the ideal place to do so is in the root of your project so that your whole application flips on a language change

```dart

// in your MaterialApp provider the builder argument

return MaterialApp(
    // rest of your application,
    builder: (context, child) {
      final isRtl = Provider.of<I18n>(context).isRtl;

      return Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: child,
      );
    }
  )
```
# this way all of your application will listen to language change and flip on langauge change

***


## Methods

Method        | Description
------------- | -------------
setLocale     | sets the locale for the app and notifies listeners   
load          | loads the persisted language from storage and sets it
persist       | persists the current language to the storage
