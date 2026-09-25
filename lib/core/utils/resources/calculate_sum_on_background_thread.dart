import 'package:flutter/foundation.dart';

Future<BigInt> calculateSumOnBackgroundThread(Set<BigInt> items) async {
  return await compute(_sum, items);
}

BigInt _sum(Set<BigInt> items) {
  return items.fold<BigInt>(BigInt.from(0), (total, item) => total + item);
}
