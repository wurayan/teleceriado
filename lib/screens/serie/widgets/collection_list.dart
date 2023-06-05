import 'package:flutter/material.dart';

class CollectionList extends StatelessWidget {
  final List<String> collectionList;
  const CollectionList({super.key, required this.collectionList});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Colors.grey[500],
      child: SizedBox(
        height: height*0.5,
        width: width*0.7,
        child: ListView.builder(
          itemCount: collectionList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.pop(context, collectionList[index]);
              },
              child: Card(
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.05,
                  child: Text(collectionList[index], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
