import 'package:flutter/material.dart';

class AutoCompleteTextForm extends StatefulWidget {
  const AutoCompleteTextForm({
    super.key,
    this.label,
    required this.placeholder,
    this.error,
    this.focusNode,
    this.enabled = true,
    this.initialValue,
    required this.onChanged,
    this.suffixText,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.maxLines = 1,
    this.elevation = 0,
    this.radius = 0,
    this.validator,
    this.minLines = 1,
    this.focusedBorderWidth,
    this.focusedBorderColor,
    this.prefixIcon,
    this.rightMargin = 60,
    this.suffixIcon,
    this.obscureText = false,
    this.keybardType,
    this.fillColor,
    this.textInputAction,
    required this.suggestions,
    required this.onSelected,
    required this.suggestionPropertyToShow,
    this.listItem,
    this.clearOnSubmit = false,
    this.contentPadding,
  });
  final Color? fillColor;
  final List<dynamic> suggestions;
  final String suggestionPropertyToShow;
  final Widget? Function(dynamic item)? listItem;
  final Function(String selected) onSelected;

  final String? label;
  final EdgeInsets? contentPadding;
  final bool clearOnSubmit;
  final int maxLines;
  final int minLines;
  final bool enabled;
  final bool obscureText;
  final double radius;
  final double elevation;
  final double rightMargin;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final FloatingLabelBehavior floatingLabelBehavior;
  final String? initialValue;
  final String? suffixText;
  final String placeholder;
  final TextInputType? keybardType;
  final Function(String val) onChanged;
  final String? error;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final double? focusedBorderWidth;
  final Color? focusedBorderColor;

  @override
  State<AutoCompleteTextForm> createState() => _AutoCompleteTextFormState();
}

class _AutoCompleteTextFormState extends State<AutoCompleteTextForm> {
  @override
  Widget build(BuildContext context) {
    return RawAutocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        } else {
          List<String> matches = <String>[];
          matches.addAll(widget.suggestions
              .map((e) => e.get(widget.suggestionPropertyToShow) as String));

          matches.retainWhere((s) {
            return s
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
          return matches;
        }
      },
      onSelected: (String selection) {
        widget.onSelected(selection);
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return Material(
          elevation: widget.elevation,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius))),
          child: TextField(
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            onChanged: (value) {
              widget.onChanged(value);
            },
            keyboardType: widget.keybardType ?? TextInputType.multiline,
            minLines: widget.minLines,
            focusNode: focusNode,
            maxLines: widget.maxLines,
            enabled: widget.enabled,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.start,
            textInputAction: widget.textInputAction ??
                (widget.maxLines > 1
                    ? TextInputAction.newline
                    : TextInputAction.go),
            decoration: InputDecoration(
              focusColor: Colors.grey.shade800,
              hintText: widget.placeholder,
              suffixText: widget.suffixText,
              errorMaxLines: 3,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              // constraints: BoxConstraints(maxHeight: 42),
              filled: true, fillColor: widget.fillColor ?? Colors.transparent,
              labelText: widget.label,
              labelStyle: TextStyle(color: Colors.grey.shade700),
              floatingLabelBehavior: widget.floatingLabelBehavior,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: widget.focusedBorderWidth ?? 0.3,
                      color: widget.focusedBorderColor ?? Colors.grey.shade300),
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.radius))),
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.grey.shade400),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 0.3, color: Colors.grey.shade300),
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.radius))),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 0.3, color: Colors.grey.shade300),
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.radius))),
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(
                      horizontal: 10, vertical: (widget.maxLines > 1) ? 14 : 0),
              // errorText:     !validCode ? widget.tr('field_required') : null,
            ),
            controller: textEditingController,
            onSubmitted: (String value) {
              widget.onSelected(value);
              if (widget.clearOnSubmit) {
                textEditingController.clear();
              }
            },
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          void Function(String) onSelected, Iterable<String> options) {
        return Material(
            color: Colors.transparent,
            elevation: 0,
            child: SizedBox(
                height: 200,
                child: SingleChildScrollView(
                    child: Column(
                  children: options.map((opt) {
                    return Container(
                        margin:
                            EdgeInsets.only(right: widget.rightMargin, left: 2),
                        child: InkWell(
                          onTap: () {
                            onSelected(opt);
                          },
                          child: widget.listItem != null
                              ? widget.listItem!(opt)
                              : Card(
                                  elevation: 1,
                                  color: Theme.of(context).cardColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    child: Text(opt),
                                  )),
                        ));
                  }).toList(),
                ))));
      },
    );
  }
}
