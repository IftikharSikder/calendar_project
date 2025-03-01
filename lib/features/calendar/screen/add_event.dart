import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateController extends GetxController {
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final eventTitleController = TextEditingController();
  final DateFormat dateFormat = DateFormat("EEE, d MMM");

  void setDate(DateTime? date) {
    selectedDate.value = date;
  }

  String get formattedDate {
    return selectedDate.value != null
        ? dateFormat.format(selectedDate.value!)
        : dateFormat.format(DateTime.now());
  }

  void clearDate() {
    selectedDate.value = null;
  }

  Rx<bool> isAllDay = Rx<bool>(false);

  void setAllDay(bool value) {
    isAllDay.value = value;
  }

  var description = "Description".obs;

  void updateDescription(String newDescription) {
    description.value = newDescription;
    if(description.value.length<=1){
      description.value= "Description";
    }
  }
  var selectedIconIndex = RxInt(-1);

  void selectIcon(int index) {
    selectedIconIndex.value = index;
  }

  var selectedRepetition = "One-time task".obs;

  void changeRepetition(String? newValue) {
    if (newValue != null) {
      selectedRepetition.value = newValue;
    }
  }

}

class AddEvent extends StatelessWidget {
  AddEvent({super.key});

  final DateController controller = Get.put(DateController());

  final DateController dateController = Get.put(DateController());
  final TextEditingController textController = TextEditingController();
  final List<String> repetitionOptions = ["One-time task", "Repetitive"];

  void _showDescriptionDialog(BuildContext context) {

    if(controller.description.value=="Description"){
      textController.text = "";
    }
    else{
      textController.text = controller.description.value;
    }

    Get.dialog(
      AlertDialog(
        title: const Text('Add Description'),
        content: TextFormField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: 'Enter description here',
          ),
          //maxLines: 3,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              controller.updateDescription(textController.text);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  final List<String> iconPaths = [
     'assets/images/downArrow.svg',
     'assets/images/double_down_arrow.svg',
     'assets/images/square_box.svg',
     'assets/images/up_arrow.svg',
     'assets/images/double_up_arrow.svg',
  ];


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0052CC),
              onPrimary: Colors.white,
              onSurface: Color(0xFF171717),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != controller.selectedDate.value) {
      controller.setDate(picked);
    }

  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;


      return Scaffold(
        backgroundColor: const Color(0xFFF5F6FB),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).padding.top,
                  color: Color(0xFFFFFFFF)),
              Container(
                height: screenHeight * .075,
                decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.cancel_outlined,
                              size: 28,
                            )),
                        const Text(
                          "Local task list",
                          style: TextStyle(fontSize: 19),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 35,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.mic,
                              size: 28,
                              color: Colors.black,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.check,
                              size: 28,
                              color: Colors.black,
                            )),
                        const Text(
                          "SAVE",
                          style: TextStyle(fontSize: 19),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: controller.eventTitleController,
                  decoration: InputDecoration(
                    labelText: " Title",
                    labelStyle: TextStyle(color: Color(0xFF737373)),
                    suffixIcon: Icon(Icons.history, color: Color(0xFF737373)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE0E9F7), // Custom border color
                        width: 0.8,
                      ),
                    ),
                    // Border when TextField is focused (clicked)
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE0E9F7), // Change color when focused
                        width: 1.2,
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                child: InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFE0E9F7), width: 0.8),
                      ),
                    ),
                    child: Obx(() => ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text("Due Date",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF737373))),
                          subtitle: Text(" ${controller.formattedDate}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFF171717))),
                          trailing: IconButton(
                            icon: const Icon(Icons.close,
                                color: Color(0xFF737373)),
                            onPressed: controller.selectedDate.value != null
                                ? () => controller.clearDate()
                                : null,
                          ),
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "All-Day",
                      style: TextStyle(fontSize: 15, color: Color(0xFF737373)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Obx(() => InkWell(
                        onTap: () {
                          controller.setAllDay(!controller.isAllDay.value);
                        },
                        child: Icon(
                          controller.isAllDay.value
                              ? Icons.check_circle_outline
                              : Icons.circle_outlined,
                          color: const Color(0xFF737373),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Container(
                  color: Colors.white,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Location",
                          style:
                              TextStyle(color: Color(0xFF737373), fontSize: 17),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.location_on,
                                color: Color(0xFF737373),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.history,
                                  color: Color(0xFF737373),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: GestureDetector(
            onTap: () {
              _showDescriptionDialog(context);
            },
            child: Container(
              color: Colors.white,
              height: 60,
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Obx(
                          () => Text(
                        controller.description.value,
                        style: controller.description.value=="Description"?TextStyle(color: Color(0xFF737373), fontSize: 17):TextStyle(fontSize: 17),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Container(
                  color: Colors.white,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_rounded,
                            color: Color(0xFF737373),
                          )),
                      const Text(
                        "Reminder",
                        style:
                            TextStyle(color: Color(0xFF737373), fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 95,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "PRIORITY",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF737373),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Pro features",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFBA0156),
                              ),
                            ),
                          ],
                        ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        iconPaths.length,
                            (index) => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Obx(
                                () => InkWell(
                              onTap: () {
                                controller.selectIcon(index);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  border: controller.selectedIconIndex.value == index
                                      ? Border.all(color: Colors.blue, width: 2.0)
                                      : null,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: SvgPicture.asset(
                                  iconPaths[index],
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Container(
            color: Colors.white,
            height: 95,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "REPETITION",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF737373),
                        ),
                      ),
                      const Text(
                        "Pro features",
                        style: TextStyle(
                            fontSize: 12, color: Color(0xFFBA0156)),
                      ),
                      Obx(
                            () => DropdownButton<String>(
                              isDense: true,
                          value: controller.selectedRepetition.value,
                          icon: const Icon(Icons.arrow_drop_down),
                         // elevation: 16,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF737373)
                          ),
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                          onChanged: controller.changeRepetition,
                          items: repetitionOptions.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF737373)
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
              
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 95,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "ADD ATTACHMENT",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF737373),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Pro features",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFBA0156),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Ensures icons align left
                          children: [
                            InkWell(
                              onTap: () {},
                              child:
                                  SvgPicture.asset('assets/images/phone.svg'),
                            ),
                            InkWell(
                              onTap: () {},
                              child:
                                  SvgPicture.asset('assets/images/cloud.svg'),
                            ),
                            InkWell(
                              onTap: () {},
                              child:
                                  SvgPicture.asset('assets/images/gallery.svg'),
                            ),
                            InkWell(
                              onTap: () {},
                              child:
                                  SvgPicture.asset('assets/images/camera.svg'),
                            ),
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset('assets/images/mic.svg'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color(0xFFE0E9F7),
                              width: 0.8), // Bottom border
                        ),
                      ),
                      child: ListTile(
                        leading: SvgPicture.asset('assets/Vector.svg'),
                        title: const Text(
                          "PRIVATELY LINK CONTACT",
                          style: TextStyle(
                            color: Color(0xFF737373),
                          ),
                        ),
                        subtitle: const Text(
                          "Pro features",
                          style: TextStyle(
                            color: Color(0xFFBA0156),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color(0xFFE0E9F7),
                              width: 0.8), // Bottom border
                        ),
                      ),
                      child: const ListTile(
                        title: Text(
                          "PRIVATELY LINK CONTACT",
                          style: TextStyle(
                            color: Color(0xFF737373),
                          ),
                        ),
                        subtitle: Text(
                          "Pro features",
                          style: TextStyle(
                            color: Color(0xFFBA0156),
                          ),
                        ),
                        trailing: Icon(Icons.crop_square),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color(0xFFE0E9F7),
                              width: 0.8), // Bottom border
                        ),
                      ),
                      child: const ListTile(
                        title: Text(
                          "PRIVATELY LINK CONTACT",
                          style: TextStyle(
                            color: Color(0xFF737373),
                          ),
                        ),
                        subtitle: Text(
                          "Pro features",
                          style: TextStyle(
                            color: Color(0xFFBA0156),
                          ),
                        ),
                        trailing: Icon(Icons.crop_square),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            height: 60,
                            width: 150,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: const Color(0xFFA2004C)),
                                onPressed: () {},
                                child: const Text(
                                  "Confirm",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )))
                      ],
                    ),
                    const SizedBox(
                      height: 25,
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

