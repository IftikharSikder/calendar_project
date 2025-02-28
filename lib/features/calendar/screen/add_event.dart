import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({super.key});

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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
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
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Color(0xFFE0E9F7), width: 0.8), // Bottom border
                  ),
                ),
                child: const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(" Due Date",
                      style: TextStyle(fontSize: 14, color: Color(0xFF737373))),
                  subtitle: Text(" Wed, 10 Feb",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF171717))),
                  trailing: Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(Icons.close, color: Color(0xFF737373)),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "All-Day",
                    style: TextStyle(fontSize: 15, color: Color(0xFF737373)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(Icons.check_circle_outline,
                        color: Color(0xFF737373)),
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
              child: Container(
                color: Colors.white,
                height: 60,
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Description",
                        style:
                            TextStyle(color: Color(0xFF737373), fontSize: 17),
                      ),
                    ),
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
                      style: TextStyle(color: Color(0xFF737373), fontSize: 17),
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
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Ensures icons align left
                        children: [
                          InkWell(onTap: (){},child: SvgPicture.asset('assets/downArrow.svg'),),
                          InkWell(onTap: (){},child: SvgPicture.asset('assets/double_down_arrow.svg'),),
                          InkWell(onTap: (){},child: SvgPicture.asset('assets/square_box.svg'),),
                          InkWell(onTap: (){},child: SvgPicture.asset('assets/up_arrow.svg'),),
                          InkWell(onTap: (){},child: SvgPicture.asset('assets/double_up_arrow.svg'),),
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
              child: Container(
                color: Colors.white,
                height: 95,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "REPETITION",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF737373),
                            ),
                          ),
                          Text(
                            "Pro features",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFFBA0156)),
                          ),
                          Text(
                            "One-time task",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF737373)),
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
                          InkWell(onTap: (){},child: SvgPicture.asset('assets/images/phone.svg'),),
                          InkWell(onTap: (){},child: SvgPicture.asset('assets/images/cloud.svg'),),
                          InkWell(onTap: (){},child: SvgPicture.asset('assets/images/gallery.svg'),),
                          InkWell(onTap: (){},child: SvgPicture.asset('assets/images/camera.svg'),),
                          InkWell(onTap: (){},child: SvgPicture.asset('assets/images/mic.svg'),),
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
                                      borderRadius: BorderRadius.circular(10)),
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
