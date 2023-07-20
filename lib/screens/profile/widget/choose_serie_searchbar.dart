import 'package:flutter/material.dart';

class ChooseSerieSearchBar extends StatelessWidget {
  final Function function;
  const ChooseSerieSearchBar({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.1,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: TextFormField(
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus!.unfocus(),
          onChanged: (value) => function(value.isEmpty ? null : value),
          onFieldSubmitted: (value) => function(value.isEmpty ? null : value),
          decoration: InputDecoration(
            // isCollapsed: true,
            isDense: true,
            filled: true,
            fillColor: Colors.grey[600],
            contentPadding: EdgeInsets.only(
                left: width * 0.04, top: height * 0.02, bottom: height * 0.02),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(width: 0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(width: 0)),
          ),
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
