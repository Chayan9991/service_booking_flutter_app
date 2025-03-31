import 'dart:js' as js;

import 'package:service_booking_app/core/secrets/razorpay_key.dart';

class RazorpayService {
  void openCheckout(double amount) {
    js.context.callMethod('eval', [
      """
      var options = {
          "key": "${razorpayTestKey}",
          "amount": ${amount * 100}, // Convert amount to paise
          "currency": "INR",
          "name": "Serve Ease pvt ltd.",
          "description": "Test Transaction",
          "image": "https://your-logo-url.com/logo.png",
          "handler": function (response) {
              onPaymentSuccessDart(response.razorpay_payment_id);
          },
          "prefill": {
              "name": "Test User",
              "email": "test@example.com",
              "contact": "9999999999"
          },
          "theme": {
              "color": "#3399cc"
          }
      };
      var rzp1 = new Razorpay(options);
      rzp1.open();
    """,
    ]);
  }
}
