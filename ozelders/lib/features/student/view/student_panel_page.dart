import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class StudentPanelPage extends StatefulWidget {
  const StudentPanelPage({super.key});

  @override
  State<StudentPanelPage> createState() => _StudentPanelPageState();
}

class _StudentPanelPageState extends State<StudentPanelPage> {
  int _selectedIndex = 0;
  bool _isSidebarOpen = true;
  
  // Fotoğraf seçimi için
  final ImagePicker _imagePicker = ImagePicker();
  List<File> _selectedPhotos = [];
  
  // Mock veriler - Öğretmen paneliyle uyumlu
  final List<Map<String, dynamic>> _announcements = [
    {
      'id': 1,
      'title': 'Matematik Sınavı',
      'content': 'Yarın matematik sınavı yapılacak. Konular: Türev ve İntegral',
      'date': '2024-01-15',
      'time': '14:30',
      'teacher': 'Ahmet Hoca'
    },
    {
      'id': 2,
      'title': 'Ödev Teslimi',
      'content': 'Fizik ödevi bu hafta sonuna kadar teslim edilecek.',
      'date': '2024-01-14',
      'time': '16:00',
      'teacher': 'Ayşe Hoca'
    },
  ];

  // Bu öğrenciye ait ödevler (öğretmen panelinden gelecek)
  final List<Map<String, dynamic>> _assignments = [
    {
      'id': 1,
      'title': 'Matematik Ödevi',
      'content': 'Sayfa 45-50 arası problemler',
      'dueDate': '2024-01-20',
      'status': 'Aktif',
      'type': 'individual', // 'individual' veya 'group'
      'groupId': null,
      'groupName': null,
      'teacher': 'Ahmet Hoca'
    },
    {
      'id': 2,
      'title': 'Fizik Ödevi',
      'content': 'Newton yasaları ile ilgili problemler',
      'dueDate': '2024-01-18',
      'status': 'Tamamlandı',
      'type': 'individual',
      'groupId': null,
      'groupName': null,
      'teacher': 'Ayşe Hoca'
    },
    {
      'id': 3,
      'title': 'Matematik Grubu Ödevi',
      'content': 'Türev konusunda grup projesi',
      'dueDate': '2024-01-25',
      'status': 'Aktif',
      'type': 'group',
      'groupId': 1,
      'groupName': 'Matematik Grubu',
      'teacher': 'Ahmet Hoca'
    },
  ];

  // Bu öğrenciye ait sorular
  final List<Map<String, dynamic>> _questions = [
    {
      'id': 1,
      'subject': 'Matematik',
      'question': 'Türev konusunda yardıma ihtiyacım var. Bu integrali nasıl çözebilirim?',
      'date': '2024-01-15',
      'status': 'Bekliyor',
      'photos': 2,
      'answered': false,
      'answer': null,
      'answerDate': null
    },
    {
      'id': 2,
      'subject': 'Fizik',
      'question': 'Newton yasaları hakkında sorum var. Bu kuvvet diyagramı doğru mu?',
      'date': '2024-01-14',
      'status': 'Cevaplandı',
      'photos': 1,
      'answered': true,
      'answer': 'Kuvvet diyagramın genel olarak doğru, ancak sürtünme kuvvetini de eklemeyi unutmuşsun. Detaylı açıklama için derse gel.',
      'answerDate': '2024-01-15'
    },
  ];

  // Bu öğrencinin grup bilgileri
  final Map<String, dynamic> _studentInfo = {
    'id': 1,
    'name': 'Ahmet Yılmaz',
    'email': 'ahmet@email.com',
    'group': 'Matematik Grubu',
    'groupId': 1,
    'grade': '11. Sınıf',
    'joinDate': '2024-01-10'
  };

  // Bu öğrencinin bulunduğu grup
  final Map<String, dynamic> _studentGroup = {
    'id': 1,
    'name': 'Matematik Grubu',
    'description': 'Matematik dersini alan öğrenciler',
    'subject': 'Matematik',
    'studentCount': 2,
    'createdAt': '2024-01-10',
    'members': [
      {'id': 1, 'name': 'Ahmet Yılmaz', 'email': 'ahmet@email.com'},
      {'id': 3, 'name': 'Mehmet Kaya', 'email': 'mehmet@email.com'},
    ]
  };

  // Bu öğrencinin puanları (öğretmen panelinden gelecek)
  final List<Map<String, dynamic>> _grades = [
    {
      'id': 1,
      'assignmentTitle': 'Matematik Ödevi',
      'score': 85,
      'maxScore': 100,
      'comment': 'Çok güzel çalışma! Türev konusunda iyi anlayış var.',
      'criteria': 'Matematik',
      'gradedAt': '2024-01-16',
      'teacher': 'Ahmet Hoca'
    },
    {
      'id': 3,
      'assignmentTitle': 'Matematik Grubu Ödevi',
      'score': 78,
      'maxScore': 100,
      'comment': 'Grup çalışması iyi, ancak bireysel katkı artırılabilir.',
      'criteria': 'Matematik',
      'gradedAt': '2024-01-18',
      'teacher': 'Ahmet Hoca'
    },
  ];

  final List<Map<String, dynamic>> _lessons = [
    {
      'id': 1,
      'title': 'Matematik Dersi',
      'teacher': 'Ahmet Hoca',
      'date': '2024-01-16',
      'time': '09:00',
      'duration': '60 dakika',
    },
    {
      'id': 2,
      'title': 'Fizik Dersi',
      'teacher': 'Ayşe Hoca',
      'date': '2024-01-17',
      'time': '14:00',
      'duration': '90 dakika',
    },
  ];

  // Controllers
  final _questionSubjectController = TextEditingController();
  final _questionContentController = TextEditingController();

  // İstatistik kartı oluşturma metodu
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğrenci Kontrol Paneli'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(_isSidebarOpen ? Icons.menu_open : Icons.menu),
          onPressed: () => setState(() => _isSidebarOpen = !_isSidebarOpen),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.go('/home'),
          ),
        ],
      ),
      body: Row(
        children: [
          // Sol Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _isSidebarOpen ? 250 : 0,
            child: _isSidebarOpen ? Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(right: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.school, color: Colors.green, size: 30),
                        SizedBox(width: 15),
                        Text(
                          'Öğrenci Paneli',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildSidebarItem(Icons.home, 'Ana Sayfa', 0, Colors.green),
                        _buildSidebarItem(Icons.announcement, 'Duyurular', 1, Colors.blue),
                        _buildSidebarItem(Icons.assignment, 'Ödevlerim', 2, Colors.orange),
                        _buildSidebarItem(Icons.grade, 'Puanlarım', 3, Colors.amber),
                        _buildSidebarItem(Icons.question_answer, 'Soru Gönder', 4, Colors.purple),
                        _buildSidebarItem(Icons.group_work, 'Grubum', 5, Colors.indigo),
                        _buildSidebarItem(Icons.schedule, 'Ders Programı', 6, Colors.teal),
                        _buildSidebarItem(Icons.person, 'Profil', 7, Colors.blue),
                      ],
                    ),
                  ),
                ],
              ),
            ) : null,
          ),
          // Sağ İçerik
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                _buildHomeTab(),
                _buildAnnouncementsTab(),
                _buildAssignmentsTab(),
                _buildGradesTab(),
                _buildQuestionsTab(),
                _buildGroupTab(),
                _buildLessonsTab(),
                _buildProfileTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, int index, Color color) {
    final isSelected = _selectedIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? color : Colors.transparent,
          width: 2,
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? color : Colors.grey[600]),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? color : Colors.grey[800],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () => setState(() => _selectedIndex = index),
      ),
    );
  }

  // Ana Sayfa
  Widget _buildHomeTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🏠 Ana Sayfa', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Card(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.green, Colors.lightGreen]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hoş Geldin! 👋', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 8),
                  Text('Bugün 2 dersin var. Duyuruları ve ödevlerini kontrol etmeyi unutma!', style: TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Duyurular
  Widget _buildAnnouncementsTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('📢 Duyurular', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _announcements.length,
              itemBuilder: (context, index) {
                final announcement = _announcements[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(announcement['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(announcement['content']),
                    trailing: Text('${announcement['date']} ${announcement['time']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Puanlar Tab'ı
  Widget _buildGradesTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📊 Puanlarım',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Puan istatistikleri
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Toplam Puan',
                  '${_grades.length}',
                  Icons.grade,
                  Colors.amber,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Ortalama',
                  '${(_grades.fold(0.0, (sum, grade) => sum + grade['score']) / _grades.length).toStringAsFixed(1)}',
                  Icons.analytics,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'En Yüksek',
                  '${_grades.fold(0, (max, grade) => grade['score'] > max ? grade['score'] : max)}',
                  Icons.trending_up,
                  Colors.green,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Puan listesi
          const Text(
            'Puan Detayları',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          
          Expanded(
            child: ListView.builder(
              itemCount: _grades.length,
              itemBuilder: (context, index) {
                final grade = _grades[index];
                final percentage = (grade['score'] / grade['maxScore'] * 100).round();
                Color scoreColor;
                
                if (percentage >= 90) scoreColor = Colors.green;
                else if (percentage >= 80) scoreColor = Colors.blue;
                else if (percentage >= 70) scoreColor = Colors.orange;
                else scoreColor = Colors.red;
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: scoreColor,
                      radius: 25,
                      child: Text(
                        '${grade['score']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    title: Text(
                      grade['assignmentTitle'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          grade['comment'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                grade['criteria'],
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${grade['gradedAt']}',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Öğretmen: ${grade['teacher']}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: scoreColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${grade['score']}/${grade['maxScore']}',
                            style: TextStyle(
                              color: scoreColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: scoreColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '%$percentage',
                            style: TextStyle(
                              color: scoreColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Ödevler
  Widget _buildAssignmentsTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('📝 Ödevlerim', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          
          // Ödev istatistikleri
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Toplam Ödev',
                  '${_assignments.length}',
                  Icons.assignment,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Aktif Ödev',
                  '${_assignments.where((a) => a['status'] == 'Aktif').length}',
                  Icons.pending,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Tamamlanan',
                  '${_assignments.where((a) => a['status'] == 'Tamamlandı').length}',
                  Icons.check_circle,
                  Colors.green,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Ödev listesi
          const Text(
            'Ödev Detayları',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          
          Expanded(
            child: ListView.builder(
              itemCount: _assignments.length,
              itemBuilder: (context, index) {
                final assignment = _assignments[index];
                final isGroupAssignment = assignment['type'] == 'group';
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: assignment['status'] == 'Aktif' 
                        ? (isGroupAssignment ? Colors.purple : Colors.orange)
                        : Colors.green,
                      child: Icon(
                        assignment['status'] == 'Aktif' 
                          ? (isGroupAssignment ? Icons.group_work : Icons.assignment)
                          : Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(assignment['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(assignment['content']),
                        const SizedBox(height: 4),
                        Text(
                          'Teslim: ${assignment['dueDate']}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        if (isGroupAssignment)
                          Text(
                            'Grup: ${assignment['groupName']}',
                            style: TextStyle(
                              color: Colors.purple[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          )
                        else
                          Text(
                            'Bireysel Ödev',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        Text(
                          'Öğretmen: ${assignment['teacher']}',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: assignment['status'] == 'Aktif' 
                              ? (isGroupAssignment ? Colors.purple.withOpacity(0.1) : Colors.orange.withOpacity(0.1))
                              : Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            assignment['status'],
                            style: TextStyle(
                              color: assignment['status'] == 'Aktif' 
                                ? (isGroupAssignment ? Colors.purple[700] : Colors.orange[700])
                                : Colors.green[700],
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isGroupAssignment ? Colors.purple.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isGroupAssignment ? 'Grup' : 'Bireysel',
                            style: TextStyle(
                              color: isGroupAssignment ? Colors.purple[700] : Colors.green[700],
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Soru Gönderme - Fotoğraf özelliği ile
  Widget _buildQuestionsTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('❓ Soru Gönder & Gelen Cevaplar', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          
          // Mevcut sorular ve cevaplar
          const Text(
            '📋 Gönderdiğim Sorular',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          
          // Soru listesi
          Expanded(
            child: ListView.builder(
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                final question = _questions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: ExpansionTile(
                    leading: Icon(
                      question['answered'] ? Icons.check_circle : Icons.schedule,
                      color: question['answered'] ? Colors.green : Colors.orange,
                    ),
                    title: Text(
                      '${question['subject']} - ${question['answered'] ? 'Cevaplandı' : 'Bekliyor'}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Tarih: ${question['date']}',
                      style: TextStyle(
                        color: question['answered'] ? Colors.green : Colors.grey,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Soru içeriği
                            Text(
                              'Sorum:',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              question['question'],
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            
                            // Fotoğraflar
                            if (question['photos'] > 0) ...[
                              Text(
                                'Eklenen Fotoğraflar (${question['photos']} adet):',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: question['photos'],
                                  itemBuilder: (context, photoIndex) {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      margin: const EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey[400]!),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.photo,
                                          size: 40,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                            
                            // Cevap
                            if (question['answered']) ...[
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.green[200]!),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Öğretmen Cevabı:',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(question['answer']),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Cevap Tarihi: ${question['answerDate']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ] else ...[
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.orange[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.orange[200]!),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.schedule, color: Colors.orange),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Öğretmen henüz cevap vermedi. Lütfen bekleyin.',
                                      style: TextStyle(color: Colors.orange[700]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          
          // Yeni soru gönderme
          const Text(
            '📝 Yeni Soru Gönder',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          
          // Soru gönderme formu
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Öğretmene Soru Gönder',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  
                  // Ders seçimi
                  TextField(
                    controller: _questionSubjectController,
                    decoration: const InputDecoration(
                      labelText: 'Ders',
                      border: OutlineInputBorder(),
                      hintText: 'Örn: Matematik, Fizik, Kimya',
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Soru metni
                  TextField(
                    controller: _questionContentController,
                    decoration: const InputDecoration(
                      labelText: 'Sorunuz',
                      border: OutlineInputBorder(),
                      hintText: 'Sorunuzu detaylı olarak yazın...',
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 15),
                  
                  // Fotoğraf ekleme bölümü
                  const Text(
                    '📸 Fotoğraf Ekle (Opsiyonel)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  
                  // Fotoğraf butonları
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _takePhoto,
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Fotoğraf Çek'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _pickImageFromGallery,
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Galeriden Seç'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Seçilen fotoğraflar
                  if (_selectedPhotos.isNotEmpty) ...[
                    const SizedBox(height: 15),
                    const Text(
                      'Seçilen Fotoğraflar:',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _selectedPhotos.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _selectedPhotos[index],
                                    width: 100,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () => _removePhoto(index),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 20),
                  
                  // Soru gönder butonu
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _sendQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('Soru Gönder', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Gönderilen sorular listesi
          const Text('Gönderilen Sorular', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          
          Expanded(
            child: ListView.builder(
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                final question = _questions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: question['status'] == 'Bekliyor' ? Colors.orange : Colors.green,
                      child: Icon(
                        question['status'] == 'Bekliyor' ? Icons.schedule : Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(question['subject']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(question['question']),
                        const SizedBox(height: 4),
                        Text(
                          question['date'],
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: question['status'] == 'Bekliyor' ? Colors.orange.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        question['status'],
                        style: TextStyle(
                          color: question['status'] == 'Bekliyor' ? Colors.orange[700] : Colors.green[700],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Grup Tab'ı
  Widget _buildGroupTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '👥 Grubum',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Grup bilgileri kartı
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.indigo,
                        radius: 30,
                        child: Text(
                          _studentGroup['name'][0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _studentGroup['name'],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _studentGroup['subject'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              '${_studentGroup['studentCount']} üye',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Açıklama: ${_studentGroup['description']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Oluşturulma: ${_studentGroup['createdAt']}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Grup üyeleri
          const Text(
            'Grup Üyeleri',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          
          Expanded(
            child: ListView.builder(
              itemCount: _studentGroup['members'].length,
              itemBuilder: (context, index) {
                final member = _studentGroup['members'][index];
                final isCurrentStudent = member['id'] == _studentInfo['id'];
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isCurrentStudent ? Colors.green : Colors.blue,
                      child: Text(
                        member['name'][0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      member['name'],
                      style: TextStyle(
                        fontWeight: isCurrentStudent ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(member['email']),
                    trailing: isCurrentStudent
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Sen',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Ders Programı
  Widget _buildLessonsTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('📅 Ders Programı', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _lessons.length,
              itemBuilder: (context, index) {
                final lesson = _lessons[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.schedule, color: Colors.teal),
                    title: Text(lesson['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Öğretmen: ${lesson['teacher']}'),
                        Text('Tarih: ${lesson['date']}'),
                        Text('Saat: ${lesson['time']}'),
                        Text('Süre: ${lesson['duration']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Profil
  Widget _buildProfileTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('👤 Profil', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Kişisel Bilgiler', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _buildProfileItem('Ad Soyad', _studentInfo['name']),
                  _buildProfileItem('E-posta', _studentInfo['email']),
                  _buildProfileItem('Sınıf', _studentInfo['grade']),
                  _buildProfileItem('Grup', _studentInfo['group']),
                  _buildProfileItem('Kayıt Tarihi', _studentInfo['joinDate']),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Grup bilgileri kartı
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Grup Bilgileri', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _buildProfileItem('Grup Adı', _studentGroup['name']),
                  _buildProfileItem('Ders', _studentGroup['subject']),
                  _buildProfileItem('Üye Sayısı', '${_studentGroup['studentCount']} öğrenci'),
                  _buildProfileItem('Açıklama', _studentGroup['description']),
                  _buildProfileItem('Oluşturulma', _studentGroup['createdAt']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  // Fotoğraf çekme fonksiyonu
  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _imagePicker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        setState(() {
          _selectedPhotos.add(File(photo.path));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fotoğraf çekilirken hata: $e'), backgroundColor: Colors.red),
      );
    }
  }

  // Galeriden fotoğraf seçme fonksiyonu
  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedPhotos.add(File(image.path));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fotoğraf seçilirken hata: $e'), backgroundColor: Colors.red),
      );
    }
  }

  // Fotoğraf kaldırma fonksiyonu
  void _removePhoto(int index) {
    setState(() {
      _selectedPhotos.removeAt(index);
    });
  }

  // Soru gönderme fonksiyonu
  void _sendQuestion() {
    if (_questionSubjectController.text.isNotEmpty && _questionContentController.text.isNotEmpty) {
      setState(() {
        _questions.insert(0, {
          'id': DateTime.now().millisecondsSinceEpoch,
          'subject': _questionSubjectController.text,
          'question': _questionContentController.text,
          'date': DateTime.now().toString().split(' ')[0],
          'status': 'Bekliyor',
          'photos': _selectedPhotos.length, // Fotoğraf sayısını da ekle
        });
        
        // Formu temizle
        _questionSubjectController.clear();
        _questionContentController.clear();
        _selectedPhotos.clear();
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Soru ve fotoğraflar gönderildi!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen ders ve soru alanlarını doldurun!'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  void dispose() {
    _questionSubjectController.dispose();
    _questionContentController.dispose();
    super.dispose();
  }
}
