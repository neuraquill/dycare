import 'package:dycare/domain/entities/nurse_entity.dart';
import 'package:dycare/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HealthcareProviderCard extends StatelessWidget {
  final NurseEntity provider;
  final Function() onTap;
  final bool isAvailable;

  const HealthcareProviderCard({
    Key? key,
    required this.provider,
    required this.onTap,
    required this.isAvailable,
  }) : super(key: key);

  Widget _buildStarRating(double rating) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          return Icon(
            index < rating.floor()
                ? Icons.star
                : (index == rating.floor() && rating % 1 > 0.5)
                    ? Icons.star_half
                    : Icons.star_border,
            size: 16,
            color: Colors.amber,
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.primary),
      ),
      child: Material( // Added Material widget
        type: MaterialType.transparency,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: provider.profilePicture?.isNotEmpty == true
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          provider.profilePicture!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.person),
                        ),
                      )
                    : const Icon(Icons.person),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      provider.specialization ?? 'No specialization',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      provider.education ?? 'No bio available',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${provider.yearsOfExp ?? 0} Years of Experience',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildStarRating(provider.rating ?? 0),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                   /*
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: isAvailable ? AppColors.success : AppColors.inputBorder,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isAvailable ? 'Available' : 'Not Available',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                */
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.primary, // Added foreground color
                      disabledBackgroundColor: Colors.grey[300], // Added disabled color
                      minimumSize: const Size(80, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Book',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}