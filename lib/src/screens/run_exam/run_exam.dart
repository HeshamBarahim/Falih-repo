import 'package:falih/src/config/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RunExam extends StatefulWidget {
  const RunExam({super.key});

  @override
  State<RunExam> createState() => _RunExamState();
}

int? _selectedOption;
final int _correctOption = 1;
final List<String> _options = ['No', 'Yes', 'Maybe', 'Idont Know'];
bool _isAnswered = false;

Color _getOptionColor(int index) {
  if (_isAnswered) {
    if (index == _correctOption) {
      return Colors.purple[100]!;
    } else if (index == _selectedOption && _selectedOption != _correctOption) {
      return Colors.red[100]!;
    }
  }
  return Colors.white;
}

Color _getOptionBorderColor(int index) {
  if (_isAnswered) {
    if (index == _correctOption) {
      return Colors.purple;
    } else if (index == _selectedOption && _selectedOption != _correctOption) {
      return Colors.red;
    }
  }
  return Colors.grey[300]!;
}

Icon? _getIconForOption(int index) {
  if (_isAnswered) {
    if (index == _correctOption) {
      return Icon(Icons.check_circle, color: Colors.purple);
    } else if (index == _selectedOption && _selectedOption != _correctOption) {
      return Icon(CupertinoIcons.multiply_circle_fill, color: Colors.red);
    }
  }
  return null;
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: AppColors.primaryGradients,
                    ),
                    height: 300,
                    width: double.infinity,
                    child: const Icon(Icons.arrow_back),
                  ),
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
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                      height: 300,
                      width: 350,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '05',
                                      style: TextStyle(
                                        color: Colors.green[500],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Icon(
                                    //   CupertinoIcons.minus,
                                    //   color: Colors.green[500],
                                    //   size: 100,
                                    // ),
                                    SizedBox(width: 10.0),
                                    Container(
                                      height: 7.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                        color: Colors.green[500],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 7.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                        color: Colors.red[400],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(
                                      '07',
                                      style: TextStyle(
                                        color: Colors.red[400],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Icon(
                                    //   CupertinoIcons.minus,
                                    //   color: Colors.green[500],
                                    //   size: 100,
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                            Center(
                              child: Text('Questions 13/20'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Are You An Idiot ?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(height: 50),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedOption = null;
                                  _isAnswered = false;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 104, 204, 244),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Center(
                                    child: Text(
                                  'Try Again',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 140,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      child: CircularPercentIndicator(
                        radius: 35,
                        backgroundColor: Colors.white,
                        progressColor: Color.fromARGB(255, 57, 157, 224),
                        percent: .65,
                        center: Text(
                          '20',
                          style: TextStyle(fontSize: 21),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _options.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (!_isAnswered) {
                          setState(() {
                            _selectedOption = index;
                            _isAnswered = true;
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _getOptionColor(index),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _getOptionBorderColor(index),
                            width: 2,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            _options[index],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: _getIconForOption(index),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
