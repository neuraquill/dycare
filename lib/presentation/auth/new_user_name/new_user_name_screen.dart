//lib/presentation/auth/new_user_name/new_user_name_screen.dart
import 'package:dycare/presentation/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/theme/app_colors.dart';
import 'package:dycare/presentation/auth/new_user_name/controller/new_user_name_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewUserNameScreen extends GetView<NewUserNameController> {
  const NewUserNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final verticalSpacing = screenHeight * 0.02;
    final horizontalPadding = screenWidth * 0.06;
    final buttonHeight = screenHeight * 0.065;

    final fontSizes = ResponsiveFontSizes(
      tiny: screenHeight * 0.016,
      small: screenHeight * 0.018,
      medium: screenHeight * 0.02,
      large: screenHeight * 0.024,
      xlarge: screenHeight * 0.032,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image Section
                Container(
                  height: screenHeight * 0.5,
                  width: double.infinity,
                  color: AppColors.secondaryLight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.textPrimary,
                          size: screenHeight * 0.024,
                        ),
                        onPressed: () => Get.back(),
                      ),
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            'assets/images/newuser_image.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Input Section
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalSpacing * 2,
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name Input
                        AuthTextField(
                          controller: controller.nameController,
                          label: 'Name',
                          fontSize: fontSizes,
                          validator: controller.validateName,
                          hintText: 'Enter your full name',
                        ),
                        SizedBox(height: verticalSpacing * 1.5),

                        // Age Input
                        AuthTextField(
                          controller: controller.ageController,
                          label: 'Age',
                          fontSize: fontSizes,
                          keyboardType: TextInputType.number,
                          validator: controller.validateAge,
                          hintText: 'Enter your age',
                        ),
                        SizedBox(height: verticalSpacing * 1.5),

                        // Location Search
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AuthTextField(
                              controller: controller.locationController,
                              label: 'Location',
                              fontSize: fontSizes,
                              hintText: 'Search or allow location access',
                              onChanged: controller.searchLocation,
                            ),
                            Obx(() {
                              if (controller.isSearching.value) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              if (controller.locationSuggestions.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Container(
                                margin: const EdgeInsets.only(top: 8.0),
                                constraints: BoxConstraints(maxHeight: screenHeight * 0.2),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.inputBorder),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.locationSuggestions.length,
                                  itemBuilder: (context, index) {
                                    final location = controller.locationSuggestions[index];
                                    return ListTile(
                                      title: Text(
                                        location.displayName,
                                        style: TextStyle(
                                          fontSize: fontSizes.small,
                                        ),
                                      ),
                                      onTap: () {
                                        controller.setSelectedLocation(location);
                                        FocusScope.of(context).unfocus();
                                      },
                                    );
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: verticalSpacing * 2),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: buttonHeight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              ),
                            ),
                            onPressed: controller.submitDetails,
                            child: Obx(
                              () => controller.isLoading.value
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : Text(
                                      'Register',
                                      style: TextStyle(
                                        fontSize: fontSizes.medium,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: verticalSpacing * 2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Add this class to your models
class LocationSuggestion {
  final String displayName;
  final double lat;
  final double lon;

  LocationSuggestion({
    required this.displayName,
    required this.lat,
    required this.lon,
  });

  factory LocationSuggestion.fromJson(Map<String, dynamic> json) {
    return LocationSuggestion(
      displayName: json['display_name'] ?? '',
      lat: double.parse(json['lat'] ?? '0'),
      lon: double.parse(json['lon'] ?? '0'),
    );
  }
}

// The AuthTextField widget remains the same as in your previous code
class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final ResponsiveFontSizes fontSize;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextCapitalization textCapitalization;
  final String? hintText;
  final Function(String)? onChanged;

  const AuthTextField({
    required this.controller,
    required this.label,
    required this.fontSize,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.hintText,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: fontSize.medium,
        color: AppColors.textPrimary,
      ),
      cursorColor: AppColors.textPrimary,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: fontSize.large,
          fontWeight: FontWeight.w500,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: fontSize.medium,
          color: AppColors.textSecondary,
        ),
        floatingLabelStyle: TextStyle(
          color: Colors.black,
          fontSize: fontSize.medium,
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
        isDense: true,
        filled: false,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
