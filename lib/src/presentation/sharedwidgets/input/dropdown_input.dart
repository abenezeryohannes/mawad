import 'package:flutter/material.dart';

class DropdownInput<T> extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final List<T> items;
  final String? initialValue;
  final bool isEnabled;
  final void Function(T?) onChange;
  final String Function(T) getDisplayName;
  final String Function(T) getValue;

  const DropdownInput({
    Key? key,
    this.label,
    this.placeholder,
    required this.items,
    this.initialValue,
    this.isEnabled = true,
    required this.onChange,
    required this.getDisplayName,
    required this.getValue,
  }) : super(key: key);

  @override
  _DropdownInputState<T> createState() => _DropdownInputState<T>();
}

// The State part of the DropdownInput widget also needs to be generic
class _DropdownInputState<T> extends State<DropdownInput<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      // Find the item with the initial value
      selectedValue = widget.items.firstWhere(
        (item) => widget.getValue(item) == widget.initialValue,
        orElse: () => widget.items.first,
      );
    } else {
      selectedValue = widget.items.isNotEmpty ? widget.items.first : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.label!,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          DropdownButtonFormField<T>(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              filled: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              hintText: widget.placeholder,
            ),
            value: selectedValue,
            items: widget.items.map((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(widget.getDisplayName(value)),
              );
            }).toList(),
            onChanged: widget.isEnabled
                ? (T? newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                    widget.onChange(newValue);
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
