import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğretmen Paneli'),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Colors.lightGreen],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Öğretmen Paneli',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _buildMenuCard(
                context,
                icon: Icons.add_circle,
                title: 'Ders Ekle',
                subtitle: 'Yeni ders ilanı oluştur',
                onTap: () {
                  // Ders ekleme sayfasına yönlendir
                },
              ),
              const SizedBox(height: 15),
              _buildMenuCard(
                context,
                icon: Icons.list,
                title: 'Derslerim',
                subtitle: 'İlan verdiğim dersleri görüntüle',
                onTap: () {
                  // Derslerim sayfasına yönlendir
                },
              ),
              const SizedBox(height: 15),
              _buildMenuCard(
                context,
                icon: Icons.message,
                title: 'Mesajlar',
                subtitle: 'Öğrencilerden gelen mesajlar',
                onTap: () {
                  // Mesajlar sayfasına yönlendir
                },
              ),
              const SizedBox(height: 15),
              _buildMenuCard(
                context,
                icon: Icons.schedule,
                title: 'Randevular',
                subtitle: 'Planlanan ders randevuları',
                onTap: () {
                  // Randevular sayfasına yönlendir
                },
              ),
              const SizedBox(height: 15),
              _buildMenuCard(
                context,
                icon: Icons.assessment,
                title: 'Kazançlarım',
                subtitle: 'Ders gelirlerini görüntüle',
                onTap: () {
                  // Kazançlar sayfasına yönlendir
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

