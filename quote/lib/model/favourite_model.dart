class FavouriteQuote {
  String? id;
  String quote;

  FavouriteQuote({
    this.id,
    required this.quote,
  });

  FavouriteQuote.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        quote = res["quote"];

  Map<String, Object?> toMap() {
    return {'id': id, 'quote': quote};
  }
}
