
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_templat/core/utils/general_utile.dart';


abstract class PaymentManager{

  static Future<void>makePayment(int amount,String currency)async{
    try {
      String clientSecret=storage.getPayment();
      await _initializePaymentSheet(clientSecret);
      await Stripe.instance.presentPaymentSheet();
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<void>_initializePaymentSheet(String clientSecret)async{
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "Basel",
      ),
    );
  }

}