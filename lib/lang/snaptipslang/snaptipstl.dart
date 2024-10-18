import 'package:flutter/material.dart';

class SnapTipsOverlayTagalog extends StatelessWidget {
  const SnapTipsOverlayTagalog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Mga Tip sa Pagkuha ng Larawan'),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              '1. MAG-FOKUS SA ISANG DAHON.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0), // Left and right padding
              child: Text(
                'Kumuha ng larawan ng isang dahon lamang, upang hindi malito ang app sa ibang mga halaman sa paligid nito.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '2. KUMUHA SA MAGANDANG ILAW.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Kumuha ng larawan sa natural na liwanag ng araw upang masiguradong malinaw ang detalye ng imahe.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '3. I-GITNA ANG DAHON.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Ilagay ang dahon sa gitna ng screen, upang madali itong matukoy ng app. Siguraduhing nakikita ang buong dahon.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '4. HAWAKAN NG MAHIGPIT UPANG MAIWASAN ANG MALABONG MGA LARAWAN.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Huwag igalaw ang iyong telepono habang kumukuha ng larawan upang hindi ito lumabas na malabo.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '5. IWASAN ANG MGA BASA O MADUMING DAHON.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Siguraduhing malinis at tuyo ang dahon para mas mahusay na makita ang texture, kulay, at estruktura nito.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '6. MAHALAGA ANG BACKGROUND.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Gumamit ng simpleng background upang matiyak na ang dahon ay namumukod-tangi sa imahe.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '7. KUMUHA NG IBA\'T IBANG ANGULO.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Subukan ang iba\'t ibang angulo upang makuha ang lahat ng detalye ng dahon.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '8. PANATILIHING MALINAW ANG FRAME.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Siguraduhing walang ibang bagay sa background, tulad ng ibang mga halaman o iyong kamay, upang hindi malito ang app.',
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Isara'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
