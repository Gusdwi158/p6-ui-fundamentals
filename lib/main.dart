import 'package:flutter/material.dart';

const String studentName = 'I Kadek Agus Dwi Adnyana';
const String studentId = '2415051076';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tahap 2 - Masalah setState & Prop Drilling',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1976D2)),
        useMaterial3: true,
      ),
      home: const ParentStateDemoPage(),
    );
  }
}

// ========================================================
// PARENT WIDGET: Pemilik State (State Ownership) - Poin 9
// ========================================================
class ParentStateDemoPage extends StatefulWidget {
  const ParentStateDemoPage({super.key});

  @override
  State<ParentStateDemoPage> createState() => _ParentStateDemoPageState();
}

class _ParentStateDemoPageState extends State<ParentStateDemoPage> {
  // Satu nilai shared state yang dimiliki oleh Parent
  final List favoriteCourseIds = [1];

  final List rawCourses = const [
    {'id': 1, 'title': 'Git & GitHub', 'code': 'MOB01', 'sks': 2},
    {'id': 2, 'title': 'Dart Fundamentals', 'code': 'MOB02', 'sks': 2},
    {'id': 3, 'title': 'Flutter UI Fundamentals', 'code': 'MOB03', 'sks': 3},
  ];

  // Callback action yang akan dipicu oleh child terbawah
  void toggleFavorite(int id) {
    setState(() {
      if (favoriteCourseIds.contains(id)) {
        favoriteCourseIds.remove(id);
      } else {
        favoriteCourseIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 2: Masalah setState & Prop Drilling'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Identitas Mahasiswa Praktikan
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            studentName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'NIM: $studentId | PTI 5 A',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Poin 10: Child Pertama menerima data via constructor
              CoursesSummary(favoriteCount: favoriteCourseIds.length),
              const SizedBox(height: 16),

              // Poin 10 & 11: Child Kedua menerima data & callback via constructor
              CourseList(
                courses: rawCourses,
                favoriteIds: favoriteCourseIds,
                onToggleFavorite: toggleFavorite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ========================================================
// CHILD 1: CoursesSummary (Menerima data dari Parent)
// ========================================================
class CoursesSummary extends StatelessWidget {
  final int favoriteCount;

  const CoursesSummary({super.key, required this.favoriteCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Ringkasan Favorit (Child 1):',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text(
            '$favoriteCount Tersimpan',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}

// ========================================================
// CHILD 2: CourseList (Perantara Prop Drilling)
// Mengoper data & callback ke grandchild (CourseItemCard)
// ========================================================
class CourseList extends StatelessWidget {
  final List courses;
  final List favoriteIds;
  final Function(int) onToggleFavorite;

  const CourseList({
    super.key,
    required this.courses,
    required this.favoriteIds,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daftar Kursus (Child 2 - Meneruskan Props):',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 10),
        // Prop drilling berlanjut ke CourseItemCard
        ...courses.map((item) {
          final c = item as Map;
          final int id = c['id'] as int;
          final bool isFav = favoriteIds.contains(id);

          return CourseItemCard(
            course: c,
            isFavorite: isFav,
            onToggleFavorite: () => onToggleFavorite(id),
          );
        }),
      ],
    );
  }
}

// ========================================================
// GRANDCHILD: CourseItemCard (Konsumen Aksi Paling Bawah)
// ========================================================
class CourseItemCard extends StatelessWidget {
  final Map course;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const CourseItemCard({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          course['title'].toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${course['code']} • ${course['sks']} SKS'),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: onToggleFavorite, // Memanggil callback naik ke parent
        ),
      ),
    );
  }
}
