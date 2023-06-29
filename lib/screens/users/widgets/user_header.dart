import 'package:flutter/material.dart';
import 'package:teleceriado/components/emoji_generator.dart';

import '../../../models/usuario.dart';
import '../../../services/api_service.dart';

class UserHeader extends StatefulWidget {
  final Usuario usuario;
  const UserHeader({super.key, required this.usuario});

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  final ApiService _api = ApiService();
  String backdrop = "";

  getBackdrop() async {
    if (widget.usuario.avatar == null) {
      backdrop = await _api.getRandomBackdrop();
      setState(() {});
    }
  }

  @override
  void initState() {
    getBackdrop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          width: width,
          height: height * 0.2,
          child: widget.usuario.avatar != null
              ? Image.network(
                  widget.usuario.avatar!,
                  fit: BoxFit.cover,
                )
              : backdrop.isEmpty
              ? Padding(
                padding: EdgeInsets.only(top: height*0.075),
                child: EmojiGenerator(generate: backdrop.isEmpty,
                style: const TextStyle(
                  fontSize: 30
                ),),
              )
              : Image.network(
                  backdrop,
                  fit: BoxFit.cover,
                ),
        ),
        Container(
          width: width,
          height: height * 0.21,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.grey[850]!],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: width*0.02, bottom: height*0.01),
              child: Text(
                widget.usuario.username ?? widget.usuario.uid!,
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.01, left: width * 0.02),
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(Icons.arrow_back_ios_rounded),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
