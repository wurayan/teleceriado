import 'package:flutter/material.dart';
import 'package:teleceriado/screens/serie/episodios/edit_episodio.dart';
import '../../../models/episodio.dart';
import 'episodio_details.dart';

class EpisodioWrapper extends StatefulWidget {
  final Episodio episodio;
  const EpisodioWrapper({super.key, required this.episodio});

  @override
  State<EpisodioWrapper> createState() => _EpisodioWrapperState();
}

class _EpisodioWrapperState extends State<EpisodioWrapper> {
  bool isEditing = false;

  edit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      clipBehavior: Clip.hardEdge,
      child: SingleChildScrollView(
        child: SizedBox(
          width: width * 0.9,
          height: isEditing ? height * 0.55 : height * 0.45,
          child: isEditing
              ? EditEpisodio(episodio: widget.episodio, reload: edit)
              : EpisodioDetails(episodio: widget.episodio, reload: edit),
        ),
      ),
    );
  }
}
