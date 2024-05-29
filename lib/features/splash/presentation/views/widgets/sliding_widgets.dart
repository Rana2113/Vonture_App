import 'package:flutter/material.dart';

class SlidingImage extends StatelessWidget {
  const SlidingImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150,
        width: 100,
        child: Image.asset('assets/BAG2.png'),
      ),
    );
  }
}

class SlidingVonture extends StatelessWidget {
  const SlidingVonture({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 150,
        child: Image.asset('assets/LOGO2.png'),
      ),
    );
  }
}

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Center(
      child: Text(
        'Travel With Purpose',
        style: TextStyle(
          color: const Color(0xffD79977),
          fontSize: 13 * MediaQuery.of(context).size.width / 500,
          // fontSize: 13,
          // fontSize: width * 0.026,
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
