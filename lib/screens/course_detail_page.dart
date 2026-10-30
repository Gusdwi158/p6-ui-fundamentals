import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Kode: ${course.code}'),
                      Text('Bobot: ${course.credits} SKS'),
                      Text('Status: ${course.status}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Consumer<CourseProvider>(
                builder: (context, provider, child) {
                  final bool isFav = provider.isFavorite(course.code);
                  return ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFav
                          ? Colors.red.shade50
                          : Colors.blue.shade50,
                      foregroundColor: isFav
                          ? Colors.red
                          : Colors.blue.shade800,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      context.read<CourseProvider>().toggleFavorite(
                        course.code,
                      );
                    },
                    icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                    label: Text(
                      isFav ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
