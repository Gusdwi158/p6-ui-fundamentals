import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import '../widgets/course_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final favList = provider.favoriteCourses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Favorit Tersimpan'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: favList.isEmpty
            ? const Center(
                child: Text(
                  'Belum ada mata kuliah yang ditambahkan ke favorit.',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: favList.length,
                itemBuilder: (context, index) {
                  return CourseCard(course: favList[index]);
                },
              ),
      ),
    );
  }
}
