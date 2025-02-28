import 'package:calendar/custom_widgets/custom_appbar.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';

import 'controller/emoji_feedback_controller.dart';

class FeedBackPage extends StatelessWidget {
  const FeedBackPage({super.key});
  @override
  Widget build(BuildContext context) {
    final EmojiFeedbackController controller =
        Get.put(EmojiFeedbackController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: CustomAppbar(title: 'Feedback'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04,
                vertical: Get.height * 0.02,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Get.width * 0.02),
                ),
                color: const Color(0xFFF5F7FA),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.04,
                      vertical: Get.width * 0.039,
                    ),
                    child: SizedBox(
                      height: Get.height * .1,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Have any Feedbacks?",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: Get.height * 0.025),
                          const Text(
                              "We would like to hear from you on how we can improve our service.")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.08,
                vertical: Get.height * 0.015,
              ),
              child: const Row(
                children: [
                  Text(
                    "Rate Your Experience",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Obx(() {
              return Container(
                height: Get.height * 0.22,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F7FA),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05,
                    vertical: Get.width * 0.05,
                  ),
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () => controller.updateSlider(index),
                              child: Opacity(
                                opacity: controller.selectedValue.value == index
                                    ? 1.0
                                    : 0.4,
                                child: Text(
                                  controller.emojiList[index],
                                  style: TextStyle(
                                    fontSize: Get.width * 0.1,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 10),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 10, // Slider thickness
                            trackShape: GradientSliderTrackShape(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.pinkAccent,
                                  Colors.purple
                                ], // Gradient colors
                              ),
                            ),
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 12), // Thumb styling
                          ),
                          child: Slider(
                            value: controller.selectedValue.value,
                            min: 0,
                            max: 4,
                            divisions: 4,
                            onChanged: (value) {
                              controller.selectedValue.value = value;
                            },
                          ),
                        ),
                        // Slider
                        //  SliderTheme(
                        //    data: SliderTheme.of(context).copyWith(
                        //      trackHeight: 10.0,
                        //      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14.0),
                        //    ),
                        //    child: Slider(
                        //      value: controller.selectedValue.value,
                        //      min: 0,
                        //      max: 4,
                        //      //divisions: 4,
                        //      activeColor: controller.colors[controller.selectedValue.value.toInt()],
                        //      inactiveColor: Colors.grey.shade300,
                        //      onChanged: (value) {
                        //        controller.selectedValue.value = value;
                        //      },
                        //    ),
                        //  ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            SizedBox(
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.09,
                            right: Get.width * 0.09,
                            top: Get.width * 0.069,
                            bottom: Get.width * 0.049,
                          ),
                          child: const Text(
                            "Tell Us About Your Experience",
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * 0.04,
                        right: Get.width * 0.04,
                        top: Get.width * 0,
                        bottom: Get.width * 0,
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Get.width * 0.02),
                        ),
                        color: const Color(0xFFF5F7FA),
                        child: SizedBox(
                          height: 150,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                hintText: "Share Your thoughts",
                                hintStyle: TextStyle(color: Color(0xFFCBCBCB)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                            textAlignVertical: TextAlignVertical.top,
                            maxLines: null,
                            expands: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 55,
                    width: 120,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA2004C),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {},
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
