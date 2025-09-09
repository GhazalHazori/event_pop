import 'package:flutter_templat/core/data/network/network_config.dart';

class PaymentEndpoints {
  static String createPayment = NetworkConfig.getFullApiRoute('payment/create-payment-intent');

  
}
