class CryptoModel {
  String? name, image, symbol;
  num? currentPrice,
      marketCap,
      totalVolume,
      high,
      low,
      priceChange,
      changePercentage,
      maxSupply,
      athChangePercentage;

  CryptoModel(
      {required this.athChangePercentage,
      required this.changePercentage,
      required this.currentPrice,
      required this.high,
      required this.image,
      required this.low,
      required this.marketCap,
      required this.maxSupply,
      required this.name,
      required this.priceChange,
      required this.symbol,
      required this.totalVolume});

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      athChangePercentage: json['ath_change_percentage'],
      changePercentage: json['price_change_percentage_24h'],
      currentPrice: json['current_price'],
      high: json['high_24h'],
      image: json['image'],
      low: json['low_24h'],
      marketCap: json['market_cap'],
      maxSupply: json['max_supply'],
      name: json['name'],
      priceChange: json['price_change_24h'],
      symbol: json['symbol'],
      totalVolume: json['total_volume'],
    );
  }
}
