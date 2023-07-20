import 'package:flutter/material.dart';

import '../../../services/api_service.dart';

class AboutYouButton extends StatelessWidget {
  final Function function;
  final String? image;
  final String title;
  AboutYouButton(
      {super.key,
      required this.function,
      required this.image,
      required this.title});
  final ApiService _api = ApiService();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.4,
      height: height * 0.14,
      child: GestureDetector(
        onTap: () {
          function();
        },
        child: Column(
          children: [
            Text(
              "$title:",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Container(
              height: height*0.11,
              width: double.infinity,
              decoration: BoxDecoration(
                image: image != null
                    ? DecorationImage(
                        image: Image.network(
                          _api.getSeriePoster(image!),
                          errorBuilder: (context, error, stackTrace) {
                            return const Text(
                                "Não foi possível recuperar a imagem");
                          },
                        ).image,
                        fit: BoxFit.cover,
                      )
                    : null,
                // color: Colors.grey[600],
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.white10, Colors.black26],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
