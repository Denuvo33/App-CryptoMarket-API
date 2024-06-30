import 'package:crypto_api/model/crypto_model.dart';
import 'package:crypto_api/service/api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cryptoDataprovider = FutureProvider<List<CryptoModel>>((ref) async {
  return ref.watch(cryptoProvider).fetchData();
});

final searchTermProvider = StateProvider((ref) => '');
