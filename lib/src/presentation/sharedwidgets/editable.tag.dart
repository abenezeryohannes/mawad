import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/presentation/sharedwidgets/autocomplete.text.form.dart';

class EditableTag extends StatefulWidget {
  const EditableTag(
      {super.key,
      this.searchOption,
      this.onSelected,
      this.suggestions = const [],
      this.placeholder,
      this.suggestionPropertyToShow = 'name',
      this.validator,
      this.onTagDelete,
      this.tags = const []});
  final Function(String)? searchOption;
  final Function(String)? onSelected;
  final List<dynamic> suggestions;
  final String suggestionPropertyToShow;
  final String? placeholder;
  final String? Function(String?)? validator;
  final Function(String tag)? onTagDelete;
  final List<String> tags;
  @override
  State<EditableTag> createState() => _EditableTagState();
}

class _EditableTagState extends State<EditableTag> {
  String text = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            AutoCompleteTextForm(
              fillColor: Theme.of(context).cardColor,
              radius: 200,
              rightMargin: MediaQuery.of(context).size.width / 4,
              elevation: 1,
              clearOnSubmit: true,
              initialValue: text,
              contentPadding: const EdgeInsets.only(left: 20, right: 34),
              validator: (val) {
                if (widget.validator != null) {
                  return widget.validator!(val);
                } else {
                  return null;
                }
              },
              onChanged: (String val) {
                setState(() {
                  text = val;
                });
                if (widget.searchOption != null) widget.searchOption!(val);
              },
              placeholder: widget.placeholder ?? '',
              onSelected: (String selected) {
                setState(() {
                  text = selected;
                });
                if (widget.onSelected != null) widget.onSelected!(selected);
              },
              suggestions: widget.suggestions,
              suggestionPropertyToShow: widget.suggestionPropertyToShow,
            ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: Padding(
            //     padding: const EdgeInsets.only(right: 10.0),
            //     child: InkWell(
            //       child: Icon(Icons.add,
            //           size: 24,
            //           color: (text.length < 4)
            //               ? Theme.of(context).disabledColor
            //               : Theme.of(context).colorScheme.onBackground),
            //       onTap: () {
            //         if (widget.onSelected != null) widget.onSelected!(text);
            //         // setState(() {
            //         //   text = '';
            //         // });
            //       },
            //     ),
            //   ),
            // )
          ],
        ),
        if (widget.tags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 5, top: 10),
            child: Wrap(
                spacing: 3,
                runSpacing: 5,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                direction: Axis.horizontal,
                children: widget.tags.map((String tag) {
                  return _tag(tag, context);
                }).toList()),
          )
      ],
    );
  }

  Widget _tag(String tag, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Theme.of(context).colorScheme.tertiary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '#${tag.capitalizeFirst ?? ''}',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(width: 4.0),
          InkWell(
            child: Icon(Icons.cancel,
                size: 14.0, color: Theme.of(context).colorScheme.onBackground),
            onTap: () {
              if (widget.onTagDelete != null) {
                widget.onTagDelete!(tag);
              }
            },
          )
        ],
      ),
    );
  }
}
