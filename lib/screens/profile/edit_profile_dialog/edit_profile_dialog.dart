import 'package:flutter/material.dart';
import 'package:teleceriado/screens/profile/edit_profile_dialog/edit_avatar_card.dart';
import 'package:teleceriado/screens/profile/edit_profile_dialog/edit_descricao.dart';
import 'package:teleceriado/screens/profile/edit_profile_dialog/edit_username_dialog.dart';

class EditProfileDialog extends StatelessWidget {
  const EditProfileDialog({super.key});

  editUsername(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EditUsernameDialog(),
      ),
    );
  }

  editDescricao(context) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => EditDescricaoDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: width * 0.8,
        height: height * 0.33,
        child: GridView(
          semanticChildCount: 3,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0),
          children: [
            _CardItem("Editar nome de usuário", editUsername),
            _CardItem("Editar descrição", editDescricao),
            const EditAvatarCard()
          ],
        ),
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  final String title;
  final Function function;
  const _CardItem(this.title, this.function);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function(context);
      },
      child: Card(
        color: Colors.white12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02),
          child: Center(
            child: Text(title,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
