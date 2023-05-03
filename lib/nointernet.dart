import 'package:dr_balcony/getStart.dart';
import 'package:flutter/material.dart';


class Nointernet extends StatelessWidget {
  const Nointernet({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      color:const Color.fromARGB(255, 233, 237, 241),
      child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children: [
  Image.asset("assets/nowifi.png"),
  const Padding(
    padding: EdgeInsets.all(10.0),
    child: Text(
        textAlign: TextAlign.center,
                              "There Is No Internet Connection",
                              style: TextStyle(
                               
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 41, 0, 0)),
                            ),
  ),
  const Padding(
    padding: EdgeInsets.all(10.0),
    child: Text(
      textAlign: TextAlign.center,
                            "Please Check Your Internet Connection And Try Again.",
                            style: TextStyle(
                             
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color.fromARGB(255, 41, 0, 0)),
                          ),
  ),
  
                        SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      // style: const ButtonStyle(
                      //   backgroundColor: MaterialStatePropertyAll<Color>(
                      //       Color.fromARGB(255, 255, 208, 0)),
                      // ),
                      onPressed: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GetStart()));
                      },
                      child: const Text(
                        "Back",
                        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
],
      ),
    );
  }
}