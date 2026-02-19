import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Controller/ScheduleDetailsController.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSummaryCard extends StatelessWidget {
  final BookingDetailModel bookings;
  final bool isAdmin;
  final String bookingId;

  const PaymentSummaryCard({
    super.key,
    required this.bookings,
    this.isAdmin = false,
    required this.bookingId,
  });

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
              Row(
                children: [
                  Text(
                    '\$${bookings.price}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.dark),
                  ),
                  if (isAdmin) ...[
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => _showEditPriceDialog(Get.context!),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.tealLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 16,
                          color: AppColors.teal,
                        ),
                      ),
                    ),
                  ],
                ],
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
              Spacer(),
              if (isAdmin)
                InkWell(
                  onTap: () => _showPaymentMethodOptions(Get.context!),
                  child: Text(
                    "Change",
                    style: TextStyle(
                        fontSize: 12,
                        //   decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                        color: AppColors.teal),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }

  void _showPaymentMethodOptions(BuildContext context) {
    final String currentMethod =
        bookings.paymentMethod?.toLowerCase() ?? 'offline';

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Change Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Current method: ${bookings.paymentMethod}',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.grey,
              ),
            ),
            const SizedBox(height: 20),
            if (currentMethod == 'offline') ...[
              _buildPaymentOptionTile(
                context: context,
                icon: Icons.credit_card,
                title: 'Change to Online',
                subtitle: 'Switch to online payment method',
                onTap: () {
                  Navigator.of(context).pop();
                  _updatePaymentMethod('online');
                },
              ),
            ] else ...[
              _buildPaymentOptionTile(
                context: context,
                icon: Icons.money_off,
                title: 'Change to Offline',
                subtitle: 'Switch to offline payment method',
                onTap: () {
                  Navigator.of(context).pop();
                  _updatePaymentMethod('offline');
                },
              ),
              const SizedBox(height: 12),
              _buildPaymentOptionTile(
                context: context,
                icon: Icons.account_balance,
                title: 'Change Bank',
                subtitle: 'Update bank account details',
                onTap: () {
                  Navigator.of(context).pop();
                  _updatePaymentMethod('online');
                },
              ),
            ],
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Center(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: AppColors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOptionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.tealLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.teal,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void _updatePaymentMethod(String newMethod) async {
    final controller = Get.find<ScheduleDetailsController>();
    await controller.updatePaymentMethod(bookingId, newMethod);
  }

  void _showEditPriceDialog(BuildContext context) {
    final TextEditingController priceController = TextEditingController(
      text: bookings.price,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Edit Service Charge',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter new price:',
              style: TextStyle(fontSize: 14, color: AppColors.grey),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                prefixText: '\$ ',
                hintText: 'Enter price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.teal, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.grey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              final newPrice = double.tryParse(priceController.text);
              if (newPrice == null || newPrice <= 0) {
                Get.snackbar(
                  'Invalid Price',
                  'Please enter a valid price',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.red.withOpacity(0.9),
                  colorText: Colors.white,
                );
                return;
              }

              Navigator.of(context).pop();
              final controller = Get.find<ScheduleDetailsController>();
              await controller.updateBookingPrice(bookingId, newPrice);
            },
            child: const Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
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
