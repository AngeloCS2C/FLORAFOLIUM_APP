import 'package:flutter/material.dart';

class SnapTipsOverlayCebuano extends StatelessWidget {
  const SnapTipsOverlayCebuano({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Mga Tip sa Snap'),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              '1. I-FOKUS SA USA KA DAHON.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0), // Left and right padding
              child: Text(
                'Kumuha ug litrato sa usa ka dahon lang, aron dili malibog ang app sa ubang mga tanom nga naglibot niini.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '2. MAGPICTURE SA HAYAG NGA SUGA.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Kumuha sa litrato sa natural nga suga aron masiguro ang klaro nga detalye sa hulagway.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '3. I-SENTRO ANG DAHON.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Ibutang ang dahon sa sentro sa screen, aron sayon ra kini mailhan sa app. Siguruha nga ang tibuok dahon makita.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '4. HAWIRI OG TARONG ANG TELEPONO PARA DILI MALABO ANG HULAGWAY.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Hawiri og tarong imong telepono nga dili maglihok sa dihang nagkuha ka sa litrato, aron dili kini magkaada og malabo nga hulagway.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '5. LIKAYI ANG HUGAW OG BASA NGA DAHON.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Siguruha nga ang dahon limpyo ug uga para sa mas maayo nga pagkakita sa tekstura, kolor, ug estruktura niini.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '6. DAPAT LIMPYO ANG BACKGROUND.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Gamit og plain nga background aron masiguro nga ang dahon nagbarug sa hulagway.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '7. MAGPICTURE OG LAIN-LAIN ANGGULO.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Sulayi ang lainlaing anggulo aron makuha ang tanan nga detalye sa dahon.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '8. SIGURADOA NGA WALAY MAKASAMOK SA FRAME.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Siguruha nga walay laing butang sa background, sama sa ubang mga tanom o sa imong kamot, aron dili maglibog ang app.',
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
