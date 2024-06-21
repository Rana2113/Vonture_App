import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final String hinttext;
  final void Function(List<String>)? onChanged;
  final List<String> value;
  final String? Function(List<String>?)? validator;
  final List<String> items;

  const MultiSelectDropdown({
    super.key,
    required this.hinttext,
    required this.onChanged,
    required this.value,
    required this.validator,
    required this.items,
  });

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  late List<String> _selectedItems;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Success'),
                    content:
                  Container(
                    padding: const EdgeInsets.all(16.0),

                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          StatefulBuilder(
                            builder: (context,set) {
                              return Column(
                                  children:[
                                    ...widget.items.map((item) {
                                      final isSelected = _selectedItems.contains(item);
                                      return CheckboxListTile(
                                        value: isSelected,
                                        title: Text(item),
                                        onChanged: (bool? checked) {
                                          set(() {
                                            isSelected==true;
                                          });
                                          print(isSelected);
                                          setState(() {
                                            if (checked == true) {

                                              _selectedItems.add(item);
                                            } else {
                                              _selectedItems.remove(item);
                                            }
                                            widget.onChanged!(_selectedItems);
                                          });
                                        },
                                      );
                                    }).toList(),

                                  ]
                              );
                            }
                          ),

                        ],
                      ),
                    ),
                  ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: InputDecorator(
              decoration: InputDecoration(
                hintText: widget.hinttext,
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              isEmpty: _selectedItems.isEmpty,
              child: Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: _selectedItems
                    .map((item) => Chip(
                          label: Text(item),
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () {
                            setState(() {
                              _selectedItems.remove(item);
                              widget.onChanged!(_selectedItems);
                            });
                          },
                        ))
                    .toList(),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
