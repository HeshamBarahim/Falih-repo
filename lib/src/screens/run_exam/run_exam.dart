import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

class RunExam extends StatefulWidget {
  const RunExam({super.key});

  @override
  State<RunExam> createState() => _RunExamState();
}

class _RunExamState extends State<RunExam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customGrey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Background
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: AppColors.primaryGradients,
                    ),
                    height: 300,
                    width: double.infinity,
                    child: const Icon(Icons.arrow_back),
                  ),
                  // Positioned Text
                  Positioned(
                    top: 100,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(
                                5, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      height: 300,
                      width: 350,
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text('05'), Text('07')],
                            ),
                            Center(
                              child: Text('Questions 13/20'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'How many students in your class from north korea How many students in your class from north korea How many students in your class from north korea? ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Positioned Circle Avatar
                  const Positioned(
                    top: 50,
                    left: 140,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      child: Text('20'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                  color: AppColors.customGrey,
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text('data'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradients,
                borderRadius:
                    BorderRadius.circular(12), // Optional for rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                    4.0), // Creates space for the border effect
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.customGrey, // Inner container color
                    borderRadius: BorderRadius.circular(
                        12), // Match the outer border radius
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                  color: AppColors.customGrey,
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('data'),
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.black)),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradients,
                borderRadius:
                    BorderRadius.circular(12), // Optional for rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                    4.0), // Creates space for the border effect
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.customGrey, // Inner container color
                    borderRadius: BorderRadius.circular(
                        12), // Match the outer border radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('data'),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                              border:
                                  Border.all(width: 1, color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
