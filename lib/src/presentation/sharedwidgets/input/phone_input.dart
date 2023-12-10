import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/core/jsons/contry_code.dart';
import 'package:mawad/src/core/models/country_code.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class CustomPhoneInput extends StatefulWidget {
  final Color? inputColor;
  final String hint;
  final int? phoneNumberMaxLength;
  final String Function(String) onChanged;
  final String? Function(String?)? validator;

  const CustomPhoneInput(
      {Key? key,
      this.inputColor,
      this.hint = 'Phone Number',
      this.phoneNumberMaxLength,
      this.validator,
      required this.onChanged})
      : super(key: key);

  @override
  _CustomPhoneInputState createState() => _CustomPhoneInputState();
}

class _CustomPhoneInputState extends State<CustomPhoneInput> {
  CountryCode? selectedCountry;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Set the default selected country
    selectedCountry =
        countriesCode.firstWhere((country) => country.dialCode == "+965",
            orElse: () => CountryCode(
                  name: 'Kuwait',
                  flag: 'KW',
                  code: 'KW',
                  dialCode: '+965',
                ));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: _controller,
        onChanged: (value) {
          widget.onChanged(value);
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.phoneNumberMaxLength),
          FilteringTextInputFormatter.digitsOnly,
        ],
        // maxLength: widget.phoneNumberMaxLength,
        // maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        decoration: InputDecoration(
          hintTextDirection: TextDirection.rtl,
          hintText: widget.hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide.none,
          ),
          fillColor: widget.inputColor,
          filled: true,
          prefixIcon: _buildSuffixIcon(),
        ),
        keyboardType: TextInputType.phone,
        validator: widget.validator,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.end);
  }

  Widget _buildSuffixIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 12.sp),
            CircleAvatar(
              radius: 20.r,
              backgroundColor: AppColorTheme.white,
              child: Text(selectedCountry!.flag,
                  style: TextStyle(fontSize: 27.sp, color: Colors.white)),
            ),
            SizedBox(width: 12.sp),
            // const Icon(Icons.arrow_drop_down),
            Text(selectedCountry!.dialCode,
                style: AppTextTheme.darkblueTitle17),
            SizedBox(width: 12.sp),
            Container(
              color: AppColorTheme.lightGray2,
              height: 55.h,
              width: 2,
            ),
            SizedBox(width: 12.sp),
          ],
        )
        // CountryDropdown(
        //   selectedCountry: selectedCountry,
        //   onCountrySelected: (CountryCode? country) {
        //     setState(() {
        //       // selectedCountry = country;
        //     });
        //   },
        // ),
      ],
    );
  }
}

class CountryDropdown extends StatelessWidget {
  final CountryCode? selectedCountry;
  final ValueChanged<CountryCode?> onCountrySelected;

  const CountryDropdown({
    super.key,
    required this.selectedCountry,
    required this.onCountrySelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CountryCode>(
        onSelected: onCountrySelected,
        itemBuilder: (BuildContext context) {
          return countriesCode.map((CountryCode country) {
            return PopupMenuItem<CountryCode>(
              value: country,
              child: Container(
                color: AppColorTheme.white,
                alignment: Alignment.centerLeft,
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(country.name, style: const TextStyle(fontSize: 12)),
                      Text(country.dialCode,
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(country.flag, style: const TextStyle(fontSize: 20)),
                      // Text(country.dialCode),
                    ],
                  ),
                ),
              ),
            );
          }).toList();
        },

        // Row(
        //   children: [
        //     Text(country.name, style: const TextStyle(fontSize: 12)),
        //     Column(
        //       children: [
        //         Text(country.flag, style: const TextStyle(fontSize: 30)),
        //         const SizedBox(height: 8),
        //         Text(country.dialCode),
        //       ],
        //     )
        //   ],
        // ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 12.sp),
            Container(
              color: AppColorTheme.lightGray2,
              height: 55.h,
              width: 2,
            ),
            SizedBox(width: 12.sp),
            const Icon(Icons.arrow_drop_down),
            Text(selectedCountry!.dialCode,
                style: AppTextTheme.darkblueTitle17),
            SizedBox(width: 12.sp),
            CircleAvatar(
              radius: 20.r,
              backgroundColor: AppColorTheme.darkGray,
              child: Text(
                selectedCountry!.flag,
                style: AppTextTheme.darkblueTitle17,
              ),
            ),
            SizedBox(width: 12.sp),
          ],
        ));
  }
}

List<CountryCode> countriesCode = countries
    .map((country) => CountryCode(
          name: country['name']!,
          flag: country['flag']!,
          code: country['code']!,
          dialCode: country['dial_code']!,
        ))
    .toList();
