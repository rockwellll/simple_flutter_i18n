# simple_flutter_i18n

## Motive
while i was searching for the packages to help me with multi-langauge stuff , setting them up was hard, working with them was even harder, so i created this simple package to help me
i hope it helps you to.

## How to use: 
this class is to be used with the provider package,

1- import it
```
import "package:simple_flutter_i18n/simple_flutter_i18n.dart";
```

parameters : 
```
 langauge // Map<String, dynamic> language;
 the langauge should a isRtl key because the package looks for that key;

 isRtl // bool

  ChangeNotifierProvider.value(value: I18n(yourLanguageObject))
```

2- proivde it in the list of providers in your application

```
    MultiProvider(
    providers: [  // other providers of your application
        ChangeNotifierProvider.value(value: I18n(ku))
        ],
    child: child,
  );
```


3 - wrap the root of your project with a 

```
final isRtl = Provider.of<I18n>(context).isRtl; // get the rtl of the currenctLanguage

Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: child,
);
```


## Methods: 

1- changeLangaugeTo(newLanguage) // Map<String, dynamic >
