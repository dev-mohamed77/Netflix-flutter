import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:flutter_multi_formatter/widgets/country_dropdown.dart';
import 'package:netflix/core/extensions/color_extensions.dart';

import '../../../../../core/manager/color/colors_manager.dart';

class PhoneFormSection extends StatelessWidget {
  const PhoneFormSection({
    super.key,
    required this.phoneController,
  });

  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CountryDropdown(
              onCountrySelected: (PhoneCountryData countryData) {
                phoneController.text = countryData.phoneCode ?? "20";
              },
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              height: 53,
              padding: const EdgeInsets.only(top: 2),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.red.shade100.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: phoneController,
                validator: (value) {
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColorsManager.accentColor,
                      width: 1.8,
                    ),
                  ),
                  hintText: "Phone",
                  hintStyle: TextStyle(
                    color: context.scrimColor,
                  ),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  PhoneInputFormatter(
                    allowEndlessPhone: false,
                    onCountrySelected: (value) {
                      print(value);
                    },
                    shouldCorrectNumber: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
