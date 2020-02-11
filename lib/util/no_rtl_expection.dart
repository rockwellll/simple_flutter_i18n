class NoRtlExeption implements Exception {
  final String message;

  NoRtlExeption(this.message);

  @override
  String toString() {
    return this.message;
  }
}
