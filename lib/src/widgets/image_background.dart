import 'package:flutter/material.dart';
import 'package:pakitec_components/pakitec_components.dart';
import '../styles/main_style.dart';

class PakiImageBackground extends StatelessWidget {
  final String? url;
  final String? text;

  const PakiImageBackground({Key? key, this.url = '', this.text = ''}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Widget _imageBackground(url) {
      return Expanded(child: Image.asset(url));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        url!.isNotEmpty ? _imageBackground(url) : _imageBackground('assets/images/bermuda-no-data.png'),
        const PakiHorizontalDiv(),
        Text(text!.isNotEmpty ? text! : 'sem dados', style: const TextStyle(color: primaryColor, fontSize: 18.0))
      ],
    );
  }
}
