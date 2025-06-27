import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:test_cark/core/utils/custom_toast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentScreen extends material.StatefulWidget {
  final double totalPrice;

  const PaymentScreen({super.key, required this.totalPrice});

  @override
  material.State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends material.State<PaymentScreen> {
  String _selectedPaymentMethod = 'visa';
  bool _isLoading = false;
  Map<String, dynamic>? _paymentIntent;

  // IMPORTANT: Replace with your backend endpoint
  final String _paymentIntentUrl =
      'https://your-backend-server.com/create-payment-intent';

  // IMPORTANT: Replace with your publishable key from Stripe
  final String _stripePublishableKey =
      'pk_test_51...'; // Example, replace with your actual key

  @override
  void initState() {
    super.initState();
    Stripe.publishableKey = _stripePublishableKey;
  }

  /// SIMULATED Backend Call
  /// In a real app, this function would make an HTTP request to your server.
  Future<Map<String, dynamic>> _createPaymentIntent() async {
    /*
    // REAL IMPLEMENTATION EXAMPLE:
    try {
      final response = await http.post(
        Uri.parse(_paymentIntentUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'amount': (widget.totalPrice * 100).toInt(), // Amount in cents
          'currency': 'usd',
          'payment_method_types': ['card'],
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create payment intent');
      }
    } catch (e) {
      // Handle server errors
      print(e.toString());
      rethrow;
    }
    */

    // For demonstration, we return a mock response.
    // The 'client_secret' is what Stripe's SDK uses to confirm the payment.
    await Future.delayed(const Duration(seconds: 1));
    return {
      'client_secret': 'pi_..._secret_...', // This is a fake secret
      'amount': (widget.totalPrice * 100).toInt(),
    };
  }

  Future<void> _handlePayment() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Create Payment Intent on the backend
      _paymentIntent = await _createPaymentIntent();
      final clientSecret = _paymentIntent!['client_secret'];

      // 2. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Cark Rentals',
          style: material.ThemeMode.light,
        ),
      );

      // 3. Present the payment sheet
      await Stripe.instance.presentPaymentSheet();

      // 4. Handle success
      _showPaymentResult('Success!', 'Your payment was processed successfully.');
    } on StripeException catch (e) {
      _showPaymentResult('Payment Failed', 'Error: ${e.error.localizedMessage}',
          isError: true);
    } catch (e) {
      _showPaymentResult('Error', 'An unexpected error occurred.',
          isError: true);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showPaymentResult(String title, String message,
      {bool isError = false}) {
    showDialog(
      context: context,
      builder: (context) => material.AlertDialog(
        title: material.Row(
          children: [
            material.Icon(
              isError ? material.Icons.error_outline : material.Icons.check_circle_outline,
              color: isError ? material.Colors.red : material.Colors.green,
            ),
            const material.SizedBox(width: 10),
            material.Text(title),
          ],
        ),
        content: material.Text(message),
        actions: [
          material.TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (!isError) {
                // Navigate to a confirmation or home screen
                Navigator.of(context)
                    .popUntil((route) => route.isFirst);
              }
            },
            child: const material.Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  material.Widget build(material.BuildContext context) {
    return material.Scaffold(
      appBar: material.AppBar(
        title: const material.Text('Complete Your Payment'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: material.Column(
          children: [
            _buildPriceSummary(),
            material.SizedBox(height: 32.h),
            _buildPaymentMethodSelector('visa', 'Credit/Debit Card', 'assets/images/img/visa_logo.png'),
            _buildPaymentMethodSelector('paypal', 'PayPal', 'assets/images/img/paypal_logo.png'),
            _buildPaymentMethodSelector('vodafone', 'Vodafone Cash', 'assets/images/img/vodafone_logo.png'),
            material.SizedBox(height: 40.h),
            _buildPayButton(),
          ],
        ),
      ),
    );
  }

  material.Widget _buildPriceSummary() {
    return material.Card(
      elevation: 2,
      shape: material.RoundedRectangleBorder(borderRadius: material.BorderRadius.circular(12.r)),
      child: material.Padding(
        padding: EdgeInsets.all(20.r),
        child: material.Row(
          mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
          children: [
            material.Text('Total Amount',
                style: material.TextStyle(fontSize: 18.sp, color: material.Colors.grey[700])),
            material.Text(
              '\$${widget.totalPrice.toStringAsFixed(2)}',
              style: material.TextStyle(
                  fontSize: 22.sp,
                  fontWeight: material.FontWeight.bold,
                  color: material.Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  material.Widget _buildPaymentMethodSelector(String method, String title, String asset) {
    bool isSelected = _selectedPaymentMethod == method;
    return material.GestureDetector(
      onTap: () {
        if (method != 'visa') {
          showCustomToast('This payment method is not yet available.', true);
          return;
        }
        setState(() {
          _selectedPaymentMethod = method;
        });
      },
      child: material.Card(
        elevation: isSelected ? 4 : 1,
        shape: material.RoundedRectangleBorder(
          borderRadius: material.BorderRadius.circular(10.r),
          side: material.BorderSide(
            color: isSelected ? material.Theme.of(context).primaryColor : material.Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: material.Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: material.Row(
            children: [
              material.Image.asset(asset, width: 40.w, errorBuilder: (c, e, s) => const material.Icon(material.Icons.payment, size: 30)),
              material.SizedBox(width: 16.w),
              material.Expanded(child: material.Text(title, style: material.TextStyle(fontSize: 16.sp, fontWeight: material.FontWeight.w600))),
              if (isSelected)
                material.Icon(material.Icons.check_circle, color: material.Theme.of(context).primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  material.Widget _buildPayButton() {
    return material.SizedBox(
      width: double.infinity,
      child: material.ElevatedButton(
        onPressed: _isLoading ? null : _handlePayment,
        style: material.ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          backgroundColor: material.Theme.of(context).primaryColor,
          shape: material.RoundedRectangleBorder(borderRadius: material.BorderRadius.circular(12.r)),
        ),
        child: _isLoading
            ? const material.CircularProgressIndicator(color: material.Colors.white)
            : material.Text(
                'Pay Now',
                style: material.TextStyle(fontSize: 18.sp, color: material.Colors.white, fontWeight: material.FontWeight.bold),
              ),
      ),
    );
  }
}

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
      ),
      body: Center(
        child: Text(
          'Your saved payment methods will appear here.',
          style: TextStyle(fontSize: 18.sp, color: Colors.grey[700]),
        ),
      ),
    );
  }
} 