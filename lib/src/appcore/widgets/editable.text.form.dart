import 'package:flutter/material.dart';
import 'package:mawad/src/appcore/widgets/text.input.form.dart';

class EditableTextForm extends StatefulWidget {
  const EditableTextForm(this.text,
      {super.key,
      this.style,
      this.editable = true,
      this.editing = false,
      this.onEditClicked,
      this.onSaveClicked,
      this.onCancelClicked,
      this.iconSize,
      this.textEditorWidth = 200,
      this.placeholder});
  final String text;
  final TextStyle? style;
  final bool editable;
  final Function? onEditClicked;
  final Function(String? val)? onSaveClicked;
  final Function? onCancelClicked;
  final double? iconSize;
  final bool editing;
  final String? placeholder;
  final double textEditorWidth;
  @override
  State<EditableTextForm> createState() => _EditableTextFormState();
}

class _EditableTextFormState extends State<EditableTextForm> {
  bool editing = false;
  late String text;
  @override
  void initState() {
    if (widget.editing) {
      editing = true;
    }
    text = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (editing) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // SizedBox(
          //   width: (widget.iconSize ?? 16) * 4,
          // ),
          SizedBox(
              width: widget.textEditorWidth,
              child: TextInputForm(
                onChanged: (String val) {
                  setState(() {
                    text = val;
                  });
                  if (widget.onSaveClicked != null) {
                    widget.onSaveClicked!(val);
                  }
                },
                textAlign: TextAlign.center,
                enabled: widget.editing,
                fillColor: (widget.editing)
                    ? Theme.of(context).cardColor
                    : Colors.transparent,
                contentPadding: const EdgeInsets.only(
                    left: 20, right: 20, top: 14, bottom: 14),
                radius: 20,
                initialValue: widget.text,
                placeholder: widget.placeholder ?? widget.text,
              )),
          // const SizedBox(
          //   width: 8,
          // ),
          // _saveButton(),
          // const SizedBox(
          //   width: 15,
          // ),
          // _cancelButton()
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.editable)
          SizedBox(
            width: (widget.iconSize ?? 16) * 3,
          ),
        Text(
          widget.text,
          style: widget.style ??
              TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground),
        ),
        if (widget.editable) _editButton()
      ],
    );
  }

  Widget _editButton() {
    return IconButton(
        onPressed: () {
          setState(() {
            editing = !editing;
          });
          if (widget.onEditClicked != null) {
            widget.onEditClicked!();
          }
        },
        icon: Icon(
          Icons.edit,
          size: widget.iconSize ?? 18,
          color: Theme.of(context).colorScheme.primary,
        ));
  }

  Widget _saveButton() {
    return InkWell(
        onTap: () {
          setState(() {
            editing = false;
          });
          if (widget.onSaveClicked != null) {
            widget.onSaveClicked!(text);
          }
        },
        child: Icon(
          Icons.check,
          size: widget.iconSize ?? 18,
          color: Theme.of(context).colorScheme.secondary,
        ));
  }

  Widget _cancelButton() {
    return InkWell(
        onTap: () {
          setState(() {
            editing = false;
          });
          if (widget.onCancelClicked != null) {
            widget.onCancelClicked!();
          }
        },
        // padding: EdgeInsets.zero,
        child: Icon(
          Icons.close,
          size: widget.iconSize ?? 18,
          color: Theme.of(context).colorScheme.onBackground,
        ));
  }
}
