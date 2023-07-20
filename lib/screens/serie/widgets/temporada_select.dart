import 'package:flutter/material.dart';

class SelectTemporada extends StatefulWidget {
  final Function update;
  final int qtdeTemporadas;
  final Widget child;
  const SelectTemporada(
      {super.key,
      required this.update,
      required this.qtdeTemporadas,
      required this.child});
  @override
  State<SelectTemporada> createState() => _SelectTemporadaState();
}

class _SelectTemporadaState extends State<SelectTemporada> {
  int temporada = 1;

  List<DropdownMenuItem<int>> lista(int temporadas) {
    List<DropdownMenuItem<int>> res = [];
    for (var i = 1; i <= temporadas; i++) {
      DropdownMenuItem<int> item = DropdownMenuItem<int>(
        value: i,
        child: Text(
          "Temp. $i",
          style: const TextStyle(color: Colors.black),
        ),
      );
      res.add(item);
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: height*0.01),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.03, bottom: height * 0.01),
              child: Container(
                height: height * 0.045,
                width: width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.grey[400]!,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<int>(
                  value: temporada,
                  items: lista(widget.qtdeTemporadas),
                  onChanged: (int? newItem) {
                    temporada = newItem!;
                    widget.update(temporada);
                    setState(() {});
                  },
                  isExpanded: true,
                  padding: const EdgeInsets.only(left: 10),
                  dropdownColor: Colors.grey[400],
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            widget.child
          ],
        ),
      ),
    );
  }
}
