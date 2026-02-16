import 'package:cleanby_maria/Screens/Admin/ClientScreen/Models/BookingDetailModel.dart';
import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/ScheduleDetailsScreen.dart';
import 'package:flutter/material.dart';

class PropertyDetailsSection extends StatelessWidget {
  BookingDetailModel property;

  PropertyDetailsSection({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'PROPERTY DETAILS ( ${property.propertyType} )',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.sectionLabel,
                  letterSpacing: 0.8,
                ),
              ),
              Spacer(),
              if (property.isEco == true || property.materialProvided == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.teal),
                  child: Text(
                    (property.isEco == true) ? "Is Eco" : "Material Provided",
                    style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                )
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _PropertyStat(
                icon: Icons.bed_outlined,
                value: '${property.noOfRooms}',
                label: 'Rooms',
              ),
              VerticalDivider(),
              _PropertyStat(
                icon: Icons.bathtub_outlined,
                value: '${property.noOfBathRooms}',
                label: 'Bathrooms',
              ),
              VerticalDivider(),
              _PropertyStat(
                icon: Icons.square_foot_outlined,
                value: '${property.areaSize} ft²',
                label: 'Total Area',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PropertyStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _PropertyStat(
      {required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 22, color: AppColors.teal),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.dark),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
                fontSize: 10,
                color: AppColors.grey,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
