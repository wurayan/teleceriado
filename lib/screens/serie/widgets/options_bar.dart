import 'package:flutter/material.dart';

class OptionsBar extends StatefulWidget {
  final Function function;
  const OptionsBar({super.key, required this.function});

  @override
  State<OptionsBar> createState() => _OptionsBarState();
}

class _OptionsBarState extends State<OptionsBar> {
  bool option = true;

  change(bool value) {
    option = option ? value : !value;
    widget.function(!option);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _OptionsItem(isActive: option, title: "Episódios", function: change),
        _OptionsItem(isActive: !option, title: "Detalhes", function: change),
      ],
    );
  }
}

class _OptionsItem extends StatelessWidget {
  final bool isActive;
  final String title;
  final Function function;
  const _OptionsItem(
      {required this.isActive, required this.title, required this.function});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          function(isActive);
        },
        child: Container(
          height: double.infinity,
          decoration: isActive
              ? BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: Colors.grey[800],
                )
              : const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
