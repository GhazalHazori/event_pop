import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/card_payment_view/payment_strip.dart';
import 'package:lottie/lottie.dart';


class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isProcessing = false;

  Future<void> _pay() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      // إنشاء PaymentMethod يدوياً باستخدام البيانات المدخلة
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(
              name: _nameController.text,
            ),
          ),
        ),
      );

      // تأكيد الدفع
      await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: 'pi_3S1kCQRqsc1ffDMG0CSlJy7w_secret_3chA4ZmZcDZX52sOZahP5IsFV',
        data: PaymentMethodParams.cardFromMethodId(
          paymentMethodData: PaymentMethodDataCardFromMethod(
            paymentMethodId: paymentMethod.id,
          ),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تمت عملية الدفع بنجاح!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('فشلت عملية الدفع: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  String? _validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم البطاقة';
    }
    if (value.replaceAll(' ', '').length != 16) {
      return 'رقم البطاقة يجب أن يكون 16 رقمًا';
    }
    return null;
  }

  // String? _validateExpiry(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'يرجى إدخال تاريخ الانتهاء';
  //   }
  //   if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$').hasMatch(value)) {
  //     return 'صيغة التاريخ غير صحيحة (MM/YY)';
  //   }
  //   return null;
  // }

  String? _validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال CVV';
    }
    if (value.length != 3 && value.length != 4) {
      return 'CVV يجب أن يكون 3 أو 4 أرقام';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          
          children: [  screenHeight(40).ph,
            Text("Complete payment ",style: TextStyle(color: AppColors.blacktext,fontFamily: 'Tajawal',fontSize: screenWidth(15),fontWeight: FontWeight.w500),),
            screenHeight(10).ph,
           Center(
             child: SizedBox(
                   
                      child: Lottie.asset(
                        'assets/lottie/payment.json',
                        repeat: true,
                      ),
                    ),
           ),
            Spacer(),
            
            // Pay Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
            onPressed: ()=>PaymentManager.makePayment(40, "EGP"), 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(245, 151, 98, 100),
                  padding: EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
                child: _isProcessing
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "pay now",
                        style: TextStyle(
                          fontSize: 20,color: AppColors.whitecolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}