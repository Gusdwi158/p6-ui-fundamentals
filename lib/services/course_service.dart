import '../models/course.dart';

class CourseService {
  Future<List<Course>> loadCourses() async {
    await Future.delayed(const Duration(milliseconds: 600));
    throw Exception(
      'Gagal membaca data dari server/assets: HTTP 500 Connection Timeout.',
    );
  }
}
//I KADEK AGUS DWI ADNYANA
// 2415051076
