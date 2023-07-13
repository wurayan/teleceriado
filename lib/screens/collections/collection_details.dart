import 'package:pixel_snap/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/collection.dart';
import 'package:teleceriado/screens/collections/widget/colecao_body.dart';
import 'package:teleceriado/screens/collections/widget/colecao_header.dart';
import '../../models/usuario.dart';
import '../../services/user_dao/firebase_export.dart';

class CollectionDetails extends StatefulWidget {
  final Collection colecao;
  const CollectionDetails({super.key, required this.colecao});

  @override
  State<CollectionDetails> createState() => _CollectionDetailsState();
}

class _CollectionDetailsState extends State<CollectionDetails> {
  final FirebaseUsers _users = FirebaseUsers();
  late Collection colecao;
  Usuario? dono;

  getOwnerData(String userId) async {
    dono = await _users.getUserdata(userId: userId);
    if (mounted) setState(() {});
  }

  isOwner(context, String colecaoDono) {
    return Provider.of<Usuario>(context).uid == colecaoDono;
  }

  @override
  void initState() {
    colecao = widget.colecao;
    getOwnerData(colecao.dono!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Header(
                collection: colecao,
                dono: isOwner(context, colecao.dono!) ? null : dono,
              ),
            ),
            colecao.series == null || colecao.series!.isEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.1),
                      child: const Center(
                        child: Text(
                          "T-T Não tem séries nessa coleção ainda",
                        ),
                      ),
                    ),
                  )
                : Body(series: widget.colecao.series!)
          ],
        ),
      ),
    );
  }
}
