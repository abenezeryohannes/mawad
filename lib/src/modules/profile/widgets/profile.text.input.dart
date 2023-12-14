import 'package:flutter/material.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

class ProfileTextInput extends StatefulWidget {
  const ProfileTextInput({
    super.key,
    required this.onChange,
    this.label,
    this.placeholder,
    this.initialText,
    this.readolny = false,
    this.controller,
    this.validator,
  });

  final Function(String text) onChange;
  final String? label;
  final String? placeholder;
  final String? initialText;
  final bool readolny;
  final Function(String?)? validator;
  final TextEditingController? controller;

  @override
  State<ProfileTextInput> createState() => _ProfileTextInputState();
}

class _ProfileTextInputState extends State<ProfileTextInput> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = widget.controller ?? TextEditingController();
    if (widget.initialText != null) {
      _textController.text = widget.initialText!;
    }
  }

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
                    color: AppColorTheme.yellow, fontWeight: FontWeight.bold),
              ),
            ),
          TextFormField(
            controller: _textController,
            decoration: InputDecoration(
              fillColor: AppColorTheme.lightgray,
              filled: true,
              hintText: widget.placeholder ?? '',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            style: Theme.of(context).textTheme.titleSmall,
            onChanged: (String text) {
              widget.onChange(text);
            },
            validator: (value) {
              if (widget.validator != null) {
                return widget.validator!(value);
              }
              return null;
            },
            readOnly: widget.readolny,
          ),
        ],
      ),
    );
  }
}
