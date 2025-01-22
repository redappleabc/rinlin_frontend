import 'package:purchases_flutter/object_wrappers.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class Coins {
  static const idCoins10 = "rinlin_10_coin";
  static const idCoins50 = "rinlin_50_coin";
  static const idCoins100 = "rinlin_100_coin";

  static const allIds = [idCoins10, idCoins50, idCoins100];
}

class PurchaseApi {
  static PurchasesConfiguration? configuration;
  static const _apiKey = 'goog_CWKUatFZFRIrGobNPtNluHyXqFr';
  static Future init() async {
    configuration = PurchasesConfiguration(_apiKey);

    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(_apiKey);
  }

  static Future<List<Offering>> fetchOffers({bool showcoin = false}) async {
    final offerings = await Purchases.getOfferings();
    //final offerings = await Purchases.getOfferings();
    final current = offerings.current;
    // return current == null ? [] : [current];

    return showcoin
        ? offerings.all.values.toList()
        : current == null
            ? []
            : [current];
  }

  static Future<bool> purchasePackage(Package package) async {
    try {
      CustomerInfo customer = await Purchases.purchasePackage(package);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> purchaseRestore() async {
    try {
      await Purchases.restorePurchases();
      return true;
    } catch (e) {
      return false;
    }
  }
}
