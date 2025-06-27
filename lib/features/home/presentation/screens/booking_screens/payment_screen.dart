import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:test_cark/core/utils/custom_toast.dart';

class PaymentScreen extends material.StatefulWidget {
  final double totalPrice;

  const PaymentScreen({super.key, required this.totalPrice});

  @override
  material.State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends material.State<PaymentScreen> {
  String _selectedPaymentMethod = 'visa';
  bool _isLoading = false;

  Future<void> _handlePayment() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate successful payment
      _showPaymentResult('Success!', 'Your payment was processed successfully.');
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