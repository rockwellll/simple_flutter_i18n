# simple_flutter_i18n
flutter internationalization made simple and easy to use.

# package inspiration
i got inspired to design the apis of this package by using the amazing package for [svelte](https://svelte.dev/) [svelte-i18n](https://github.com/kaisermann/svelte-i18n)

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

1- Register your langauges thorugh the regisery class of the package;
```dart
import "package:simple_flutter_i18n/regisry.dart";

// before your application langauges, register your langauges

  I18nRegistry.register('en', en);
  I18nRegistry.register('ku', ku);
  I18nRegistry.register('ar', ar);

  I18nRegistry.setInitialLanguage(en); // your initial language that will be used by the I18n provider
```

#### then 

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
        ChangeNotifierProvider( 
          create: (_) => I18n()
        ) // en is your initial language
      ],
  child : MaterialApp(
    home: HomeScreen()
    // rest of your application
  ),
);

// home_screen.dart

@override
void initState() {
  super.initState();
  
  Provider.of<I18n>(context, listen: false).load(fallback: en); // en is your initial/fallback language in case no langauge was found in the shared_preference registry
}
```

***

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

### I18n
Method        | Description
------------- | -------------
setLocale     | sets the locale for the app and notifies listeners   
load          | loads the persisted language from storage and sets it
persist       | persists the current language to the storage

***

### Registry

Method               | Description
-------------------- | --------------
setInitialLanguage   | sets the initial language of your application
register             | registers the langauge key-value pair
initialLanguage      | a getter that will get the initialLanguage of the Regisry class, used by I18n provider class
isEmpty              | checks if the Regisry is empty or not
