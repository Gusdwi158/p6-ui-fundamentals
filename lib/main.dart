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
      title: 'Tahap 4 - ValueNotifier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1976D2)),
        useMaterial3: true,
      ),
      home: const ValueNotifierDemoPage(),
    );
  }
}

class ValueNotifierDemoPage extends StatefulWidget {
  const ValueNotifierDemoPage({super.key});

  @override
  State<ValueNotifierDemoPage> createState() => _ValueNotifierDemoPageState();
}

class _ValueNotifierDemoPageState extends State<ValueNotifierDemoPage> {
  final ValueNotifier<int> favoriteCount = ValueNotifier<int>(0);

  @override
  void dispose() {
    favoriteCount.dispose();
    super.dispose();
  }

  void incrementFavorite() {
    favoriteCount.value++;
  }

  void decrementFavorite() {
    if (favoriteCount.value > 0) {
      favoriteCount.value--;
    }
  }

  void resetFavorite() {
    favoriteCount.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 4: ValueNotifier & Listener'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        'Total Kursus Favorit Terpilih',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ValueListenableBuilder<int>(
                        valueListenable: favoriteCount,
                        builder: (context, value, child) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.blue.shade200),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.bookmark,
                                  color: Colors.pinkAccent,
                                  size: 30,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '$value Kursus',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Hanya widget di dalam ValueListenableBuilder yang dibangun ulang saat nilai berubah tanpa memicu render ulang Scaffold induk.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: incrementFavorite,
                      icon: const Icon(Icons.add),
                      label: const Text('Tambah (+1)'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: decrementFavorite,
                      icon: const Icon(Icons.remove),
                      label: const Text('Kurang (-1)'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: resetFavorite,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset Nilai'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
