// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:task_inditab/components/AppButton.dart';

import '../utils/AppText.dart';

class PaymentService {
  Razorpay razorpay = Razorpay();

  void handlePaymentSuccess(
      PaymentSuccessResponse response, BuildContext context) {
    // Do something when payment succeeds
    print(
        '_handlePayementSuccess method ${response.orderId} ${response.paymentId} ${response.signature}');
    _dialoge(context, 'Succcess',
        'Thank you for booking your table in our restraunt');
  }

  void handlePaymentError(
      PaymentFailureResponse response, BuildContext context) {
    // Do something when payment fails
    print(
        '_handlePaymentError method ${response.code} ${response.error} ${response.message}');
    _dialoge(context, 'failed', 'Oops, Something went wrong');
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print('_handleExternalWallet method ${response.walletName}');
  }

  void openCheckout(double amount, String membership, String contact,
      String email, String name) async {
    var options = {
      'key': 'rzp_test_j2cV9sDEvlXviH',
      'amount': amount,
      'name': name,
      'description': 'Payment for $membership',
      'prefill': {'contact': contact, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  void _dialoge(BuildContext context, String status, String msg) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Center(child: Utils.appText('Payment $status')),
          content: Wrap(
            children: [Utils.appText(msg)],
          ),
          actions: [
            Center(
              child: AppButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  name: 'Okay'),
            )
          ]),
    );
  }
}
