import 'package:flutter/material.dart';

import '../../../model/dhwani.dart';
import '../dhwani_screen.dart';
import 'dhwani_example/dhwani_example_screen.dart';


class DhwaniDetailScreen extends StatefulWidget {
  const DhwaniDetailScreen({super.key, required this.dhwani});

  final DhwaniElement dhwani;

  @override
  State<DhwaniDetailScreen> createState() => _DhwaniDetailScreenState();
}

class _DhwaniDetailScreenState extends State<DhwaniDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: 150,
              decoration: const BoxDecoration(
                color: Color(0xffE6F4F1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DhwaniScreen()
                                )
                            );
                          },
                          child: const Text(
                            "अगला खंड",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 23,
                              fontFamily: "NotoSansDevanagari",
                              color: Color(0xff04434E),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.dhwani.dhwaniName,
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: const Color(0xff04434E),
              width: screenWidth,
              height: 2,
            ),
             Padding(
               padding: const EdgeInsets.only(left: 30, right: 30),
               child: Image.network(
                widget.dhwani.dhwaniImage,
                width: screenWidth,
                fit: BoxFit.fill,
                           ),
             ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(widget.dhwani.description,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 23,
                  fontFamily: "NotoSansDevanagari",
                  color: Color(0xff04434E),
                ),),
            ),
            Text("हिंदी में ${widget.dhwani.dhwanis.length} मुख्य ओष्ठय ध्वनियाँ हैं :",
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 23,
                  fontFamily: "NotoSansDevanagari",
                  color: Color(0xff04434E),
                ),),
            GridView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(32.0),
              gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 25.0,
                mainAxisSpacing: 25.0,
              ),
              itemCount: widget.dhwani.dhwanis.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(widget.dhwani.dhwanis[index].name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 50,
                    fontFamily: "NotoSansDevanagari",
                    color: Color(0xff04434E),
                  ),);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, top: 10, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: const Color(0xff0CC0DF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DhwaniExampleScreen(
                                      alphabet: widget.dhwani.dhwanis)
                          )
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(Icons.arrow_forward, color: Colors.white,),
                    )
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
