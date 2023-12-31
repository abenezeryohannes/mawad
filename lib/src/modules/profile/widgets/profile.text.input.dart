import 'package:flutter/material.dart';
import 'package:mawad/src/presentation/sharedwidgets/text.input.form.dart';

class ProfileTextInput extends StatefulWidget {
  const ProfileTextInput(
      {super.key,
      required this.onChange,
      this.label,
      this.placeholder,
      this.initialText});
  final Function(String text) onChange;
  final String? label;
  final String? placeholder;
  final String? initialText;

  @override
  State<ProfileTextInput> createState() => _ProfileTextInputState();
}

class _ProfileTextInputState extends State<ProfileTextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.label ?? '',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          TextInputForm(
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              placeholder: widget.placeholder ?? '',
              initialValue: widget.initialText,
              radius: 20,
              onChanged: (String text) {
                widget.onChange(text);
              })
        ],
      ),
    );
  }
}
