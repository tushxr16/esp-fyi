import 'package:flutter/material.dart';

class HumidCircle extends StatefulWidget {
  final double humidV;
  HumidCircle({required this.humidV});

  @override
  _HumidCircleState createState() => _HumidCircleState();
}

const Two_Pi = 3.1415 * 2;

class _HumidCircleState extends State<HumidCircle> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final size = height / 7;
    double humidVal = widget.humidV;

    return Container(
      child: Center(
        child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: (humidVal / 100.0)),
            duration: Duration(seconds: 2),
            builder: (context, value, child) {
              int percent = (value * 100).ceil();
              return Container(
                width: size,
                height: size,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    ShaderMask(
                      shaderCallback: (rect) {
                        return SweepGradient(
                          startAngle: 0.0,
                          endAngle: Two_Pi,
                          stops: [value, value],
                          center: Alignment.center,
                          colors: [Colors.blue, Colors.white],
                        ).createShader(rect);
                      },
                      child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: Image.asset(
                              "assets/images/dashed.png",
                            ).image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: size * 0.9,
                        height: size * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.transparent, shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            '$percent %',
                            style: TextStyle(
                                color: Colors.grey[350],
                                fontWeight: FontWeight.w800,
                                fontSize: height / 30),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
