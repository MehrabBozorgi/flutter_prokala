import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../const/theme/colors.dart';

class TextFormFieldMobileWidget extends StatelessWidget {
  final String labelText;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextEditingController controller;
  final Widget? icon;

  const TextFormFieldMobileWidget({
    super.key,
    required this.labelText,
    required this.icon,
    required this.textInputAction,
    required this.floatingLabelBehavior,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      textAlign: TextAlign.start,
      cursorColor: primary2Color,
      style: theme.textTheme.bodyMedium,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      maxLength: 11,
      textInputAction: textInputAction,
      keyboardType: TextInputType.number,
      minLines: 1,
      controller: controller,
      decoration: InputDecoration(
        counter: const SizedBox.shrink(),
        prefixIcon: icon,
        floatingLabelBehavior: floatingLabelBehavior,
        labelText: labelText,
      ),
      validator: (String? value) {
        if (value!.trim().isEmpty) {
          return 'این فیلد نمی تواند خالی باشد';
        }
        if (value.trim().length != 11) {
          return 'شماره همراه نادرست می باشد';
        }
        if (!value.startsWith('09')) {
          return 'شماره همراه نادرست می باشد';
        }
        return null;
      },
      onTap: () {
        if (controller.text.isNotEmpty) {
          if (controller.text[controller.text.length - 1] != ' ') {
            controller.text = (controller.text + '');
          }
          if (controller.selection ==
              TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length - 1))) {}
        }
      },
    );
  }
}
