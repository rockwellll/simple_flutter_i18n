import '../util/no_rtl_expection.dart';

mixin ErrorChecker {
  bool keyExistsOrError(Map src, String key) {
    if (!src.containsKey(key)) {
      throw new NoRtlExeption(
          'the locale object dosent have a key named \'isRtl\'. please make sure that the locale map contains a isRtl key ');
    }

    return true;
  }
}
