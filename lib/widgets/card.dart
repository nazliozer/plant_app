import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/disease_detection.dart';
import 'package:plant_app/themes/colors.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:intl/intl.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiseaseDetection()),
          );
        },
        child: Card(
          color: Color(0xFFF8F9F9),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FutureBuilder<List<dynamic>>(
              future: ApiService().getMyHistory(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final List<dynamic> historyData = snapshot.data!;
                  final historyData1 = historyData.first;

                  final String diseaseName =
                      historyData1['responses'][0]['label'];
                  final String date = DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(historyData1['dateTime']));
                  return Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFE3E9E9),
                        radius: 35,
                        child: ClipOval(
                          child: Image.network(
                            historyData1['imageUrl'],
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        // Using Expanded to avoid overflow
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Disease Name: $diseaseName',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.onSurface,
                              ),
                            ),
                            Text(
                              'Date: $date',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: AppColors.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        iconSize: 32,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiseaseDetection(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Color(0xFF2B826D),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text("No history available");
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
