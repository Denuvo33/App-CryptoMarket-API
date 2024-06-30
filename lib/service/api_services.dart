import 'dart:convert';
import 'package:crypto_api/model/crypto_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<CryptoModel>> fetchData() async {
    var response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
    if (response.statusCode == 200) {
      final List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => CryptoModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final cryptoProvider = Provider<ApiServices>((ref) => ApiServices());
