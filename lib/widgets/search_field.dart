import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Function findByName;
  const SearchField({super.key, required this.findByName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          decoration: InputDecoration(
              hintText: 'Buscar',
              hintStyle: const TextStyle(fontSize: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.only(left: 30),
              suffixIcon: const Icon(
                Icons.search,
                color: Colors.black,
                size: 24,
              )),
          onChanged: (value) {
            findByName(value);
          },
        ),
      ),
    );
  }
}
