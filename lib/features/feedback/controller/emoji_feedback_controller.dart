import 'package:flutter/Material.dart';
import 'package:get/get.dart';

class EmojiFeedbackController extends GetxController {
  var selectedValue = 2.0.obs;

  final List<String> emojiList = [
    "😞",
    "😠",
    "🙂",
    "😎",
    "🤩",
  ];

  final List<Color> colors = [
    Colors.blueGrey,
    Colors.red,
    Colors.grey,
    Colors.amber,
    Colors.pinkAccent,
  ];

  void updateSlider(int index) {
    selectedValue.value = index.toDouble();
  }
}

class GradientSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  final LinearGradient gradient;

  GradientSliderTrackShape({required this.gradient});

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = true,
    required RenderBox parentBox,
    Offset? secondaryOffset,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required Offset thumbCenter,
  }) {
    // Define the track rectangle
    final double trackHeight = sliderTheme.trackHeight ?? 4.0;
    final Rect trackRect = Rect.fromCenter(
      center: Offset(parentBox.size.width / 2, thumbCenter.dy),
      width: parentBox.size.width - 32,
      height: trackHeight,
    );

    // Define the active track (from start to thumb)
    final Rect activeTrackRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx, // Dynamic width as thumb moves
      trackRect.bottom,
    );

    // Create the gradient paint
    final Paint paint = Paint()
      ..shader = gradient.createShader(trackRect)
      ..style = PaintingStyle.fill;

    // Draw the active gradient track
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(activeTrackRect, Radius.circular(5)),
      paint,
    );
  }
}
