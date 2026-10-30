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
      title: 'Tahap 3 - Lifting State Up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1976D2)),
        useMaterial3: true,
      ),
      home: const ParentLiftingStatePage(),
    );
  }
}

// ========================================================
// PARENT WIDGET: Single Source of Truth (Poin 13 & 14)
// ========================================================
class ParentLiftingStatePage extends StatefulWidget {
  const ParentLiftingStatePage({super.key});

  @override
  State<ParentLiftingStatePage> createState() => _ParentLiftingStatePageState();
}

class _ParentLiftingStatePageState extends State<ParentLiftingStatePage> {
  // Poin 13 & 14: State ditempatkan pada parent sebagai acuan tunggal
  bool isFavorite = false;

  // Poin 16: Callback aksi untuk mengubah state di parent
  void handleFavoriteChanged() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 3: Lifting State Up'),
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

              // Poin 15 & 17: Widget Anak 1 menerima data via constructor
              CourseSummaryBadge(isFavorite: isFavorite),
              const SizedBox(height: 16),

              // Poin 15 & 16: Widget Anak 2 menerima data & callback via constructor
              CourseCardItem(
                title: 'State Management & Architecture',
                code: 'MOB06',
                credits: 3,
                isFavorite: isFavorite,
                onFavoriteChanged: handleFavoriteChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ========================================================
// CHILD WIDGET 1: CourseSummaryBadge (Stateless Consumer)
// ========================================================
class CourseSummaryBadge extends StatelessWidget {
  final bool isFavorite;

  const CourseSummaryBadge({super.key, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isFavorite ? Colors.pink.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFavorite ? Colors.pink.shade300 : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                isFavorite ? Icons.bookmark : Icons.bookmark_border,
                color: isFavorite ? Colors.pinkAccent : Colors.grey,
              ),
              const SizedBox(width: 10),
              const Text(
                'Status Sinkronisasi (Child 1):',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Text(
            isFavorite ? 'Tersimpan ke Favorit' : 'Belum Disimpan',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isFavorite ? Colors.pinkAccent : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

// ========================================================
// CHILD WIDGET 2: CourseCardItem (Menerima Data & Memicu Aksi)
// ========================================================
class CourseCardItem extends StatelessWidget {
  final String title;
  final String code;
  final int credits;
  final bool isFavorite;
  final VoidCallback onFavoriteChanged;

  const CourseCardItem({
    super.key,
    required this.title,
    required this.code,
    required this.credits,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$code • $credits SKS',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 28,
                  ),
                  onPressed: onFavoriteChanged, // Callback menuju parent
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Widget anak tidak menyimpan salinan state sendiri. Nilai isFavorite ($isFavorite) diperoleh murni dari parent.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
