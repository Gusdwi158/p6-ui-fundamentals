import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/course.dart';

class CourseService {
  Future<List<Course>> loadCourses() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/student_data.json',
      );
      final Map<String, dynamic> data =
          jsonDecode(jsonString) as Map<String, dynamic>;
      final List<dynamic> list = data['courses'] as List<dynamic>;
      return list
          .map((item) => Course.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [
        Course(
          code: 'MOB01',
          title: 'Git & GitHub',
          credits: 2,
          status: 'done',
        ),
        Course(
          code: 'MOB02',
          title: 'Dart Fundamentals',
          credits: 2,
          status: 'done',
        ),
        Course(
          code: 'MOB03',
          title: 'State Management',
          credits: 3,
          status: 'active',
        ),
        Course(
          code: 'MOB04',
          title: 'Clean Architecture',
          credits: 3,
          status: 'active',
        ),
        Course(
          code: 'MOB05',
          title: 'Local Persistence & DB',
          credits: 3,
          status: 'upcoming',
        ),
      ];
    }
  }
}
