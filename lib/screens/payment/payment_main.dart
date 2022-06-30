import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/utils/globals.dart';
import 'package:parkspace/widgets/button.dart';
import 'package:sizer/sizer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/services.dart';

class PaymentMain extends StatefulWidget {
  final int amount;
  final String product;
  final Function onSuccess;
  final Function onError;

  PaymentMain({
    Key? key,
    required this.amount,
    required this.product,
    required this.onSuccess,
    required this.onError,
  }) : super(key: key);

  @override
  State<PaymentMain> createState() => _PaymentMainState();
}

class _PaymentMainState extends State<PaymentMain> {
  Razorpay _razorpay = Razorpay();
  bool isPaying = false;

  @override
  void initState() {
    isPaying = false;
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_HT3pXXWVclSbUj',
      'amount': widget.amount,
      'name': 'Parkspace',
      'description': widget.product,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    setState(() {
      isPaying = false;
    });
    widget.onSuccess();
    
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    setState(() {
      isPaying = false;
    });
    widget.onError();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() {
      isPaying = false;
    });
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Rs. ${widget.amount}",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: kSecondaryColor,
              ),
            ),
            const Divider(),
            CButton(
              title: "Pay Now",
              isDisabled: isPaying,
              isLoading: isPaying,
              onTap: () async {
                setState(() {
                  isPaying = true;
                });
                openCheckout();
              },
            )
          ],
        ),
      ),
    );
  }
}
