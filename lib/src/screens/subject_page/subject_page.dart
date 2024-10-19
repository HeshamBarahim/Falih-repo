import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/screens/subject_page/widgets/subjects_label.dart';
import 'package:flutter/material.dart';

class SubjectPage extends StatelessWidget {
  SubjectPage(
      {super.key, required this.name, required this.color, required this.icon});

  final String name;
  final LinearGradient color;
  final String icon;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // box who has the subject name and image
          Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.sizeOf(context).height * 0.35,
              decoration: BoxDecoration(
                gradient: color,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // show image and subject name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Text(
                        name,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                      Image.asset(
                        icon,
                        // color: Colors.white,
                        height: 150,
                        width: 150,
                      )
                    ],
                  ),
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          SubjectsLabels(
            color: color,
            name: name,
          ),
          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future:
                _firestore.collection('subjects_ar_9').doc("biology_9").get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No data found'));
              }

              final subjectData = snapshot.data!.data() as Map<String, dynamic>;
              final units = subjectData['units'];

              return Expanded(
                child: ListView.builder(
                  itemCount: units.length,
                  itemBuilder: (context, index) {
                    final unit = units[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: const Color(0xFFFBF7FC),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const CircleAvatar(),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Chapter: ${index + 1}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(unit["unitName"]),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                "${unit["questions"].length} Questions",
                                style: const TextStyle(
                                    color: Color(0xFF3CD797),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Color(0xFF743089),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
