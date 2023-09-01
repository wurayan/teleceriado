import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/screens/profile/edit_profile_dialog/edit_profile_dialog.dart';
import 'package:teleceriado/screens/profile/widget/about_you.dart';
import 'package:teleceriado/screens/profile/widget/profile_comentarios.dart';
import 'package:teleceriado/screens/profile/widget/profile_header.dart';
import 'package:teleceriado/screens/profile/widget/seguidores.dart';
import 'package:teleceriado/services/user_dao/firebase_export.dart';

import '../../components/custom_appbar.dart';
import '../../models/badge.dart';
import '../../models/usuario.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseUsers _usuarios = FirebaseUsers();
  Usuario? usuario;
  bool update = true;

  Future getUsuarioData() async {
    usuario = await _usuarios.getUserdata();
    List<UserBadge> badges = await _usuarios.getBadges();
    usuario!.badges = badges;
    if (mounted) setState(() {});
  }

  updateData(context) {
    Provider.of<Usuario>(context).update(usuario!);
    update = false;
    // Provider.of<UpdateSeguindo>(context).headerChanged = false;
    if (mounted) setState(() {});
  }

  fullUpdate(context) async {
    usuario = await _usuarios.getUserdata();
    List<UserBadge> badges = await _usuarios.getBadges();
    usuario!.badges = badges;
    Provider.of<Usuario>(context, listen: false).update(usuario!);
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getUsuarioData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (update && usuario != null) updateData(context);

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileHeader(usuario: Provider.of<Usuario>(context)),
                      SeguidoresCounter(usuario: Provider.of<Usuario>(context)),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01, bottom: height * 0.015),
                        child: Divider(
                          height: 2,
                          thickness: 1,
                          color: Colors.grey[400],
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: height * 0.15,
                          width: width * 0.9,
                          child: Text(
                            Provider.of<Usuario>(context).bio ??
                                "Que tal contar um pouco mais sobre você e as séries que gosta de ver?",
                            style: const TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height*0.01),
                        child: SizedBox(
                          height: height * 0.06,
                          width: width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: usuario?.badges?.length ?? 0,
                            itemBuilder: (context, index) {
                              if (usuario?.badges == null ||
                                  usuario!.badges!.isEmpty) return null;
                              UserBadge badge =
                                  usuario?.badges?[index] ?? UserBadge();
                              return _BadgeItem(badge: badge);
                            },
                          ),
                        ),
                      ),
                      AboutYou(
                        usuario: Provider.of<Usuario>(context),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            width * 0.01, height * 0.01, width * 0.05, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Seus Comentários:",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "${Provider.of<Usuario>(context).editados ?? 0}",
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: ProfileComentarios(
                      usuario: Provider.of<Usuario>(context),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * 0.07,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomAppbar(),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const EditProfileDialog(),
                      ).then((value) => fullUpdate(context));
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white38,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final UserBadge badge;
  const _BadgeItem({required this.badge});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
        height: height * 0.06,
        width: height * 0.06,
        child: Image.network(
          badge.link!,
          fit: BoxFit.contain,
          alignment: Alignment.center,
          errorBuilder: (context, error, stackTrace) => const Text("Erro"),
        ),
      ),
    );
  }
}
