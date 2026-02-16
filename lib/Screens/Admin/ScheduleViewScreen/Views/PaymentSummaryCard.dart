import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleDetailsScreen.dart';
import 'package:flutter/material.dart';

class PaymentSummaryCard extends StatelessWidget {
  BookingDetailModel bookings;

  PaymentSummaryCard({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          // Line items
          // _PaymentRow(
          //     label: 'Base price',
          //     value: '\$${bookings.service..toStringAsFixed(2)}'),
          // const SizedBox(height: 10),
          // _PaymentRow(
          //     label: 'Service Fee',
          //     value: '\$${payment.serviceFee.toStringAsFixed(2)}'),
          // const SizedBox(height: 10),
          // _PaymentRow(
          //     label: 'Tax', value: '\$${payment.tax.toStringAsFixed(2)}'),
          // const SizedBox(height: 12),
          // const Divider(height: 1, color: AppColors.divider),
          // const SizedBox(height: 12),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Service Charge',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.dark)),
              Text(
                '\$${bookings.price}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.dark),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 14),

          // Payment Mode Row
          // Row(
          //   children: [
          //     const Icon(Icons.credit_card_outlined,
          //         size: 18, color: AppColors.grey),
          //     const SizedBox(width: 8),
          //     Text(
          //       'Paid with ${payment.cardBrand} ending in ${payment.cardLastFour}',
          //       style: const TextStyle(fontSize: 12, color: AppColors.grey),
          //     ),
          //   ],
          // ),
          //  const SizedBox(height: 10),

          // Payment Mode Badge
          Row(
            children: [
              const Icon(Icons.payment_outlined,
                  size: 18, color: AppColors.grey),
              const SizedBox(width: 8),
              const Text('Payment Mode: ',
                  style: TextStyle(fontSize: 12, color: AppColors.grey)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.tealLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  bookings.paymentMethod!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.teal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentRow extends StatelessWidget {
  final String label;
  final String value;

  const _PaymentRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 13, color: AppColors.grey)),
        Text(value,
            style: const TextStyle(
                fontSize: 13,
                color: AppColors.dark,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}
