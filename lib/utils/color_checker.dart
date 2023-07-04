import 'package:http/http.dart';
import 'package:image/image.dart' as im;

Future<int> isDark(String url) async {
  final res = (await get(Uri.parse(url))).bodyBytes;
  im.Image? image = im.decodeImage(res);
  final data = image?.getBytes();
  var color = 0;
  for (var x = 0; x < data!.length - 2; x += 4) {
    final int r = data[x];
    final int g = data[x + 1];
    final int b = data[x + 2];
    final int avg = ((r + g + b) / 3).floor();
    color += avg;
  }
  return (color / (image!.width * image.height)).floor();
}

