import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TeacherPanelPage extends StatefulWidget {
  const TeacherPanelPage({super.key});

  @override
  State<TeacherPanelPage> createState() => _TeacherPanelPageState();
}

class _TeacherPanelPageState extends State<TeacherPanelPage> {
  int _selectedIndex = 0;
  bool _isSidebarOpen = true; // Sidebar açık/kapalı durumu
  String? _selectedStudentId; // Seçilen öğrenci ID'si

  // Mock veriler
  final List<Map<String, dynamic>> _announcements = [
    {
      'id': 1,
      'title': 'Matematik Sınavı',
      'content': 'Yarın matematik sınavı yapılacak. Konular: Türev ve İntegral',
      'date': '2024-01-15',
      'time': '14:30'
    },
    {
      'id': 2,
      'title': 'Ödev Teslimi',
      'content': 'Fizik ödevi bu hafta sonuna kadar teslim edilecek.',
      'date': '2024-01-14',
      'time': '16:00'
    },
  ];

  final List<Map<String, dynamic>> _assignments = [
    {
      'id': 1,
      'title': 'Matematik Ödevi',
      'content': 'Sayfa 45-50 arası problemler',
      'dueDate': '2024-01-20',
      'student': 'Ahmet Yılmaz',
      'type': 'individual', // 'individual' veya 'group'
      'groupId': null,
      'groupName': null
    },
    {
      'id': 2,
      'title': 'Fizik Ödevi',
      'content': 'Newton yasaları ile ilgili problemler',
      'dueDate': '2024-01-18',
      'student': 'Ayşe Demir',
      'type': 'individual',
      'groupId': null,
      'groupName': null
    },
    {
      'id': 3,
      'title': 'Matematik Grubu Ödevi',
      'content': 'Türev konusunda grup projesi',
      'dueDate': '2024-01-25',
      'student': null,
      'type': 'group',
      'groupId': 1,
      'groupName': 'Matematik Grubu'
    },
  ];

  final List<Map<String, dynamic>> _students = [
    {
      'id': 1,
      'name': 'Ahmet Yılmaz',
      'email': 'ahmet@email.com',
      'group': 'Matematik Grubu',
      'groupId': 1,
      'password': 'abc123'
    },
    {
      'id': 2,
      'name': 'Ayşe Demir',
      'email': 'ayse@email.com',
      'group': 'Fizik Grubu',
      'groupId': 2,
      'password': 'def456'
    },
    {
      'id': 3,
      'name': 'Mehmet Kaya',
      'email': 'mehmet@email.com',
      'group': 'Matematik Grubu',
      'groupId': 1,
      'password': 'ghi789'
    },
    {
      'id': 4,
      'name': 'Fatma Öz',
      'email': 'fatma@email.com',
      'group': 'Fizik Grubu',
      'groupId': 2,
      'password': 'jkl012'
    },
  ];

  // Yeni: Öğrenci grupları
  final List<Map<String, dynamic>> _groups = [
    {
      'id': 1,
      'name': 'Matematik Grubu',
      'description': 'Matematik dersini alan öğrenciler',
      'subject': 'Matematik',
      'studentCount': 2,
      'createdAt': '2024-01-10'
    },
    {
      'id': 2,
      'name': 'Fizik Grubu',
      'description': 'Fizik dersini alan öğrenciler',
      'subject': 'Fizik',
      'studentCount': 2,
      'createdAt': '2024-01-10'
    },
    {
      'id': 3,
      'name': 'Kimya Grubu',
      'description': 'Kimya dersini alan öğrenciler',
      'subject': 'Kimya',
      'studentCount': 0,
      'createdAt': '2024-01-12'
    },
  ];

  final List<Map<String, dynamic>> _questions = [
    {
      'id': 1,
      'student': 'Ahmet Yılmaz',
      'studentId': 1,
      'subject': 'Matematik',
      'question': 'Türev konusunda yardıma ihtiyacım var. Bu integrali nasıl çözebilirim?',
      'date': '2024-01-15',
      'photos': ['photo1.jpg', 'photo2.jpg'],
      'photoCount': 2,
      'answered': false,
      'answer': null,
      'answerDate': null
    },
    {
      'id': 2,
      'student': 'Ayşe Demir',
      'studentId': 2,
      'subject': 'Fizik',
      'question': 'Newton yasaları hakkında sorum var. Bu kuvvet diyagramı doğru mu?',
      'date': '2024-01-14',
      'photos': ['photo3.jpg'],
      'photoCount': 1,
      'answered': false,
      'answer': null,
      'answerDate': null
    },
    {
      'id': 3,
      'student': 'Mehmet Kaya',
      'studentId': 3,
      'subject': 'Matematik',
      'question': 'Bu geometri sorusunda açı hesaplaması yapamıyorum.',
      'date': '2024-01-16',
      'photos': ['photo4.jpg', 'photo5.jpg', 'photo6.jpg'],
      'photoCount': 3,
      'answered': true,
      'answer': 'Açıyı bulmak için sinüs teoremini kullanabilirsin. Detaylı çözüm için derse gel.',
      'answerDate': '2024-01-16'
    },
  ];

  final List<Map<String, dynamic>> _lessons = [
    {
      'id': 1,
      'title': 'Matematik Dersi',
      'studentId': 1,
      'studentName': 'Ahmet Yılmaz',
      'date': '2024-01-16',
      'time': '09:00',
      'duration': '60'
    },
    {
      'id': 2,
      'title': 'Fizik Dersi',
      'studentId': 2,
      'studentName': 'Ayşe Demir',
      'date': '2024-01-17',
      'time': '14:00',
      'duration': '90'
    },
  ];

  // Controllers
  final _announcementTitleController = TextEditingController();
  final _announcementContentController = TextEditingController();
  final _announcementDateController = TextEditingController();
  final _announcementTimeController = TextEditingController();
  final _assignmentTitleController = TextEditingController();
  final _assignmentContentController = TextEditingController();
  final _assignmentDueDateController = TextEditingController();
  final _studentNameController = TextEditingController();
  final _studentEmailController = TextEditingController();
  final _lessonTitleController = TextEditingController();
  final _lessonDateController = TextEditingController();
  final _lessonTimeController = TextEditingController();
  final _lessonDurationController = TextEditingController();
  final _groupNameController = TextEditingController();
  final _groupDescriptionController = TextEditingController();
  final _groupSubjectController = TextEditingController();
  
  // Puanlama controllers
  final _gradeScoreController = TextEditingController();
  final _gradeCommentController = TextEditingController();
  final _gradeCriteriaController = TextEditingController();
  
  // Soru cevaplama controller
  final _questionAnswerController = TextEditingController();

  // Seçim değişkenleri
  String? _selectedAssignmentType; // 'individual' veya 'group'
  String? _selectedGroupId;
  
  // Puanlama verileri
  final List<Map<String, dynamic>> _grades = [
    {
      'id': 1,
      'studentId': 1,
      'studentName': 'Ahmet Yılmaz',
      'assignmentId': 1,
      'assignmentTitle': 'Matematik Ödevi',
      'score': 85,
      'maxScore': 100,
      'comment': 'Çok güzel çalışma! Türev konusunda iyi anlayış var.',
      'criteria': 'Matematik',
      'gradedAt': '2024-01-16',
      'teacher': 'Ahmet Hoca'
    },
    {
      'id': 2,
      'studentId': 2,
      'studentName': 'Ayşe Demir',
      'assignmentId': 2,
      'assignmentTitle': 'Fizik Ödevi',
      'score': 92,
      'maxScore': 100,
      'comment': 'Mükemmel! Newton yasaları çok iyi anlaşılmış.',
      'criteria': 'Fizik',
      'gradedAt': '2024-01-17',
      'teacher': 'Ayşe Hoca'
    },
    {
      'id': 3,
      'studentId': 1,
      'studentName': 'Ahmet Yılmaz',
      'assignmentId': 3,
      'assignmentTitle': 'Matematik Grubu Ödevi',
      'score': 78,
      'maxScore': 100,
      'comment': 'Grup çalışması iyi, ancak bireysel katkı artırılabilir.',
      'criteria': 'Matematik',
      'gradedAt': '2024-01-18',
      'teacher': 'Ahmet Hoca'
    },
  ];

  // Soru cevaplama fonksiyonu
  void _answerQuestion(int questionId, String answer) {
    setState(() {
      final questionIndex = _questions.indexWhere((q) => q['id'] == questionId);
      if (questionIndex != -1) {
        _questions[questionIndex]['answered'] = true;
        _questions[questionIndex]['answer'] = answer;
        _questions[questionIndex]['answerDate'] = DateTime.now().toString().split(' ')[0];
      }
    });
    _questionAnswerController.clear();
  }

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
        title: const Text('Öğretmen Kontrol Paneli'),
        backgroundColor: Colors.orange,
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
          // Sol Sidebar - Kategoriler (Açılıp kapanabilir)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _isSidebarOpen ? 250 : 0,
            child: _isSidebarOpen ? Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(
                  right: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.person, color: Colors.orange, size: 30),
                        SizedBox(width: 15),
                        Text(
                          'Öğretmen Paneli',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildSidebarItem(icon: Icons.announcement, title: 'Duyuru Yönetimi', index: 0, color: Colors.blue),
                        _buildSidebarItem(icon: Icons.assignment, title: 'Ödev Yönetimi', index: 1, color: Colors.green),
                        _buildSidebarItem(icon: Icons.people, title: 'Öğrenci Yönetimi', index: 2, color: Colors.purple),
                        _buildSidebarItem(icon: Icons.group_work, title: 'Öğrenci Grupları', index: 3, color: Colors.indigo),
                        _buildSidebarItem(icon: Icons.grade, title: 'Puanlama & Değerlendirme', index: 4, color: Colors.amber),
                        _buildSidebarItem(icon: Icons.question_answer, title: 'Gelen Sorular', index: 5, color: Colors.red),
                        _buildSidebarItem(icon: Icons.calendar_today, title: 'Takvim & Ders Programı', index: 6, color: Colors.teal),
                      ],
                    ),
                  ),
                ],
              ),
            ) : null,
          ),
          // Sağ İçerik Alanı
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                _buildAnnouncementsTab(),
                _buildAssignmentsTab(),
                _buildStudentsTab(),
                _buildGroupsTab(),
                _buildGradingTab(),
                _buildQuestionsTab(),
                _buildCalendarTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String title,
    required int index,
    required Color color,
  }) {
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
        leading: Icon(
          icon,
          color: isSelected ? color : Colors.grey[600],
        ),
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

  // Duyuru Yönetimi Tab'ı
  Widget _buildAnnouncementsTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📢 Duyuru Yönetimi',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Duyuru ekleme formu
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Yeni Duyuru Ekle',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _announcementTitleController,
                    decoration: const InputDecoration(
                      labelText: 'Duyuru Başlığı',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _announcementContentController,
                    decoration: const InputDecoration(
                      labelText: 'Duyuru İçeriği',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _announcementDateController,
                          decoration: const InputDecoration(
                            labelText: 'Tarih',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () => _selectDate(context, _announcementDateController),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextField(
                          controller: _announcementTimeController,
                          decoration: const InputDecoration(
                            labelText: 'Saat',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.access_time),
                          ),
                          readOnly: true,
                          onTap: () => _selectTime(context, _announcementTimeController),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addAnnouncement,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Duyuru Ekle'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Duyuru listesi
          const Text(
            'Mevcut Duyurular',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          
          Expanded(
            child: ListView.builder(
              itemCount: _announcements.length,
              itemBuilder: (context, index) {
                final announcement = _announcements[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(announcement['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(announcement['content']),
                        Text('${announcement['date']} ${announcement['time']}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteAnnouncement(announcement['id']),
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

  // Ödev Yönetimi Tab'ı
  Widget _buildAssignmentsTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📝 Ödev Yönetimi',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Ödev ekleme formu
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Yeni Ödev Ekle',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _assignmentTitleController,
                    decoration: const InputDecoration(
                      labelText: 'Ödev Başlığı',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _assignmentContentController,
                    decoration: const InputDecoration(
                      labelText: 'Ödev İçeriği',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _assignmentDueDateController,
                    decoration: const InputDecoration(
                      labelText: 'Teslim Tarihi',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context, _assignmentDueDateController),
                  ),
                  const SizedBox(height: 15),
                  
                  // Ödev türü seçimi
                  const Text(
                    '📋 Ödev Türü',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Bireysel Ödev'),
                          value: 'individual',
                          groupValue: _selectedAssignmentType,
                          onChanged: (value) {
                            setState(() {
                              _selectedAssignmentType = value;
                              _selectedStudentId = null;
                              _selectedGroupId = null;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Grup Ödevi'),
                          value: 'group',
                          groupValue: _selectedAssignmentType,
                          onChanged: (value) {
                            setState(() {
                              _selectedAssignmentType = value;
                              _selectedStudentId = null;
                              _selectedGroupId = null;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  // Bireysel ödev için öğrenci seçimi
                  if (_selectedAssignmentType == 'individual') ...[
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Öğrenci Seç',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedStudentId,
                      items: _students.map((student) {
                        return DropdownMenuItem(
                          value: student['id'].toString(),
                          child: Text('${student['name']} (${student['group']})'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStudentId = value;
                        });
                      },
                    ),
                  ],
                  
                  // Grup ödevi için grup seçimi
                  if (_selectedAssignmentType == 'group') ...[
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Grup Seç',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedGroupId,
                      items: _groups.map((group) {
                        return DropdownMenuItem(
                          value: group['id'].toString(),
                          child: Text('${group['name']} (${group['studentCount']} öğrenci)'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGroupId = value;
                        });
                      },
                    ),
                  ],
                  
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addAssignment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Ödev Ekle'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Ödev listesi
          const Text(
            'Mevcut Ödevler',
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
                      backgroundColor: isGroupAssignment ? Colors.purple : Colors.green,
                      child: Icon(
                        isGroupAssignment ? Icons.group_work : Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(assignment['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(assignment['content']),
                        Text('Teslim: ${assignment['dueDate']}'),
                        if (isGroupAssignment)
                          Text('Grup: ${assignment['groupName']}', style: TextStyle(color: Colors.purple[700], fontWeight: FontWeight.w600))
                        else
                          Text('Öğrenci: ${assignment['student']}', style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.w600)),
                      ],
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isGroupAssignment ? Colors.purple.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isGroupAssignment ? 'Grup' : 'Bireysel',
                        style: TextStyle(
                          color: isGroupAssignment ? Colors.purple[700] : Colors.green[700],
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

  // Puanlama & Değerlendirme Tab'ı
  Widget _buildGradingTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📊 Puanlama & Değerlendirme',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Puanlama istatistikleri
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Toplam Değerlendirme',
                  '${_grades.length}',
                  Icons.grade,
                  Colors.amber,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Ortalama Puan',
                  '${(_grades.fold(0.0, (sum, grade) => sum + grade['score']) / _grades.length).toStringAsFixed(1)}',
                  Icons.analytics,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Bu Ay',
                  '${_grades.where((g) => g['gradedAt'].startsWith('2024-01')).length}',
                  Icons.calendar_month,
                  Colors.green,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Yeni puanlama formu
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Yeni Puanlama Ekle',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Öğrenci Seç',
                            border: OutlineInputBorder(),
                          ),
                          value: _selectedStudentId,
                          items: _students.map((student) {
                            return DropdownMenuItem(
                              value: student['id'].toString(),
                              child: Text(student['name']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedStudentId = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Ödev Seç',
                            border: OutlineInputBorder(),
                          ),
                          value: null,
                          items: _assignments.map((assignment) {
                            return DropdownMenuItem(
                              value: assignment['id'].toString(),
                              child: Text(assignment['title']),
                            );
                          }).toList(),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 15),
                  
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _gradeScoreController,
                          decoration: const InputDecoration(
                            labelText: 'Puan',
                            border: OutlineInputBorder(),
                            hintText: '0-100',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _gradeCriteriaController,
                          decoration: const InputDecoration(
                            labelText: 'Kriter',
                            border: OutlineInputBorder(),
                            hintText: 'Matematik, Fizik, vb.',
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 15),
                  
                  TextField(
                    controller: _gradeCommentController,
                    decoration: const InputDecoration(
                      labelText: 'Değerlendirme Yorumu',
                      border: OutlineInputBorder(),
                      hintText: 'Detaylı geri bildirim yazın...',
                    ),
                    maxLines: 3,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addGrade,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('Puanlama Ekle', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Puanlama listesi
          const Text(
            'Mevcut Puanlamalar',
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
                      child: Text(
                        '${grade['score']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(grade['studentName']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          grade['assignmentTitle'],
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(grade['comment']),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'Kriter: ${grade['criteria']}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Tarih: ${grade['gradedAt']}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
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

  // Öğrenci Grupları Tab'ı
  Widget _buildGroupsTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '👥 Öğrenci Grupları',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Grup oluşturma formu
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Yeni Grup Oluştur',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _groupNameController,
                    decoration: const InputDecoration(
                      labelText: 'Grup Adı',
                      border: OutlineInputBorder(),
                      hintText: 'Örn: Matematik Grubu',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _groupDescriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Grup Açıklaması',
                      border: OutlineInputBorder(),
                      hintText: 'Grup hakkında kısa açıklama',
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _groupSubjectController,
                    decoration: const InputDecoration(
                      labelText: 'Ders',
                      border: OutlineInputBorder(),
                      hintText: 'Örn: Matematik, Fizik, Kimya',
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addGroup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Grup Oluştur'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Grup listesi
          const Text(
            'Mevcut Gruplar',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          
          Expanded(
            child: ListView.builder(
              itemCount: _groups.length,
              itemBuilder: (context, index) {
                final group = _groups[index];
                final groupStudents = _students.where((student) => student['groupId'] == group['id']).toList();
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text(
                        group['name'][0],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(group['name']),
                    subtitle: Text('${group['subject']} - ${groupStudents.length} öğrenci'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Açıklama: ${group['description']}'),
                            const SizedBox(height: 10),
                            Text('Oluşturulma: ${group['createdAt']}'),
                            const SizedBox(height: 15),
                            const Text(
                              'Grup Üyeleri:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            if (groupStudents.isNotEmpty)
                              ...groupStudents.map((student) => 
                                Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Colors.blue,
                                        child: Text(
                                          student['name'][0],
                                          style: const TextStyle(color: Colors.white, fontSize: 12),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(student['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
                                            Text(student['email'], style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle, color: Colors.red, size: 20),
                                        onPressed: () => _removeStudentFromGroup(student['id'], group['id']),
                                        tooltip: 'Gruptan Çıkar',
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else
                              const Text('Henüz öğrenci eklenmemiş', style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () => _addStudentToGroup(group['id']),
                                    icon: const Icon(Icons.person_add),
                                    label: const Text('Öğrenci Ekle'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () => _deleteGroup(group['id']),
                                    icon: const Icon(Icons.delete),
                                    label: const Text('Grubu Sil'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Öğrenci Yönetimi Tab'ı
  Widget _buildStudentsTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '👥 Öğrenci Yönetimi',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Öğrenci ekleme formu
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Yeni Öğrenci Ekle',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _studentNameController,
                    decoration: const InputDecoration(
                      labelText: 'Öğrenci Adı',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _studentEmailController,
                    decoration: const InputDecoration(
                      labelText: 'E-posta',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addStudent,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Öğrenci Ekle'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Öğrenci listesi
          const Text(
            'Mevcut Öğrenciler',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          
          Expanded(
            child: ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(student['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(student['email']),
                        Text('Grup: ${student['group']}'),
                        Text('Şifre: ${student['password']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.copy, color: Colors.blue),
                          onPressed: () => _copyStudentCredentials(student),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteStudent(student['id']),
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

  // Gelen Sorular Tab'ı
  Widget _buildQuestionsTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '❓ Gelen Sorular',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          Expanded(
            child: ListView.builder(
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                final question = _questions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: ExpansionTile(
                    leading: Icon(
                      question['answered'] ? Icons.check_circle : Icons.question_answer,
                      color: question['answered'] ? Colors.green : Colors.red,
                    ),
                    title: Text(
                      '${question['student']} - ${question['subject']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Tarih: ${question['date']}${question['answered'] ? ' - Cevaplandı' : ''}',
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
                              'Soru:',
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
                            if (question['photoCount'] > 0) ...[
                              Text(
                                'Eklenen Fotoğraflar (${question['photoCount']} adet):',
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
                                  itemCount: question['photoCount'],
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
                            
                            // Cevap alanı
                            if (!question['answered']) ...[
                              Text(
                                'Cevap Ver:',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _questionAnswerController,
                                decoration: const InputDecoration(
                                  labelText: 'Cevabınızı yazın...',
                                  border: OutlineInputBorder(),
                                  hintText: 'Öğrencinin sorusuna detaylı cevap verin',
                                ),
                                maxLines: 3,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  if (_questionAnswerController.text.isNotEmpty) {
                                    _answerQuestion(question['id'], _questionAnswerController.text);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Cevabı Gönder'),
                              ),
                            ] else ...[
                              // Mevcut cevap
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
                                      'Cevabınız:',
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
        ],
      ),
    );
  }

  // Takvim & Ders Programı Tab'ı
  Widget _buildCalendarTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📅 Takvim & Ders Programı',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Ders ekleme formu
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Yeni Ders Ekle',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _lessonTitleController,
                    decoration: const InputDecoration(
                      labelText: 'Ders Başlığı',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Öğrenci seçimi
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Öğrenci Seç',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    value: _selectedStudentId,
                    items: _students.map((student) {
                      return DropdownMenuItem<String>(
                        value: student['id'].toString(),
                        child: Text(student['name']),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedStudentId = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _lessonDateController,
                          decoration: const InputDecoration(
                            labelText: 'Tarih',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () => _selectDate(context, _lessonDateController),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextField(
                          controller: _lessonTimeController,
                          decoration: const InputDecoration(
                            labelText: 'Saat',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.access_time),
                          ),
                          readOnly: true,
                          onTap: () => _selectTime(context, _lessonTimeController),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _lessonDurationController,
                    decoration: const InputDecoration(
                      labelText: 'Süre (dakika)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addLesson,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Ders Ekle'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Ders listesi
          const Text(
            'Mevcut Dersler',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          
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
                        Text('Öğrenci: ${lesson['studentName']}'),
                        Text('Tarih: ${lesson['date']}'),
                        Text('Saat: ${lesson['time']}'),
                        Text('Süre: ${lesson['duration']} dakika'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteLesson(lesson['id']),
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

  // Tarih seçimi
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      controller.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  // Saat seçimi
  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.text = "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
    }
  }

  // Duyuru ekleme
  void _addAnnouncement() {
    if (_announcementTitleController.text.isNotEmpty && 
        _announcementContentController.text.isNotEmpty &&
        _announcementDateController.text.isNotEmpty &&
        _announcementTimeController.text.isNotEmpty) {
      setState(() {
        _announcements.add({
          'id': DateTime.now().millisecondsSinceEpoch,
          'title': _announcementTitleController.text,
          'content': _announcementContentController.text,
          'date': _announcementDateController.text,
          'time': _announcementTimeController.text,
        });
        _announcementTitleController.clear();
        _announcementContentController.clear();
        _announcementDateController.clear();
        _announcementTimeController.clear();
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Duyuru eklendi!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // Duyuru silme
  void _deleteAnnouncement(int id) {
    setState(() {
      _announcements.removeWhere((announcement) => announcement['id'] == id);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Duyuru silindi!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Ödev ekleme
    void _addAssignment() {
    if (_assignmentTitleController.text.isNotEmpty && 
        _assignmentContentController.text.isNotEmpty && 
        _assignmentDueDateController.text.isNotEmpty &&
        _selectedAssignmentType != null) {
      
      String? studentName;
      String? groupName;
      int? groupId;
      
      if (_selectedAssignmentType == 'individual') {
        if (_selectedStudentId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Lütfen bir öğrenci seçin!'),
              backgroundColor: Colors.orange,
            ),
          );
          return;
        }
        final student = _students.firstWhere((s) => s['id'].toString() == _selectedStudentId);
        studentName = student['name'];
      } else if (_selectedAssignmentType == 'group') {
        if (_selectedGroupId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Lütfen bir grup seçin!'),
              backgroundColor: Colors.orange,
            ),
          );
          return;
        }
        final group = _groups.firstWhere((g) => g['id'].toString() == _selectedGroupId);
        groupName = group['name'];
        groupId = group['id'];
      }
      
      setState(() {
        _assignments.add({
          'id': DateTime.now().millisecondsSinceEpoch,
          'title': _assignmentTitleController.text,
          'content': _assignmentContentController.text,
          'dueDate': _assignmentDueDateController.text,
          'student': studentName,
          'type': _selectedAssignmentType,
          'groupId': groupId,
          'groupName': groupName
        });
        
        // Formu temizle
        _assignmentTitleController.clear();
        _assignmentContentController.clear();
        _assignmentDueDateController.clear();
        _selectedAssignmentType = null;
        _selectedStudentId = null;
        _selectedGroupId = null;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_selectedAssignmentType == 'group' ? 'Grup' : 'Bireysel'} ödev eklendi!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen tüm alanları doldurun ve ödev türünü seçin!'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  // Öğrenci ekleme
  void _addStudent() {
    if (_studentNameController.text.isNotEmpty && 
        _studentEmailController.text.isNotEmpty) {
      final randomPassword = _generateRandomPassword();
      setState(() {
        _students.add({
          'id': DateTime.now().millisecondsSinceEpoch,
          'name': _studentNameController.text,
          'email': _studentEmailController.text,
          'group': 'Genel Grup',
          'groupId': null, // Yeni öğrenci genel gruba ait değil
          'password': randomPassword,
        });
        _studentNameController.clear();
        _studentEmailController.clear();
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Öğrenci eklendi! Şifre: $randomPassword'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // Rastgele şifre oluşturma
  String _generateRandomPassword() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(Iterable.generate(6, (_) => chars.codeUnitAt(DateTime.now().millisecondsSinceEpoch % chars.length)));
  }

  // Öğrenci bilgilerini kopyalama
  void _copyStudentCredentials(Map<String, dynamic> student) {
    final credentials = 'Ad: ${student['name']}\nE-posta: ${student['email']}\nŞifre: ${student['password']}';
    // Burada clipboard'a kopyalama işlemi yapılabilir
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bilgiler kopyalandı:\n$credentials'),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Öğrenci silme
  void _deleteStudent(int id) {
    setState(() {
      _students.removeWhere((student) => student['id'] == id);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Öğrenci silindi!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Ders ekleme
  void _addLesson() {
    if (_lessonTitleController.text.isNotEmpty && 
        _lessonDateController.text.isNotEmpty &&
        _lessonTimeController.text.isNotEmpty &&
        _lessonDurationController.text.isNotEmpty &&
        _selectedStudentId != null) {
      
      // Seçilen öğrencinin adını bul
      final selectedStudent = _students.firstWhere(
        (student) => student['id'].toString() == _selectedStudentId,
        orElse: () => {'name': 'Bilinmeyen Öğrenci'},
      );
      
      setState(() {
        _lessons.add({
          'id': DateTime.now().millisecondsSinceEpoch,
          'title': _lessonTitleController.text,
          'studentId': int.parse(_selectedStudentId!),
          'studentName': selectedStudent['name'],
          'date': _lessonDateController.text,
          'time': _lessonTimeController.text,
          'duration': _lessonDurationController.text,
        });
        _lessonTitleController.clear();
        _lessonDateController.clear();
        _lessonTimeController.clear();
        _lessonDurationController.clear();
        _selectedStudentId = null; // Öğrenci seçimini sıfırla
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ders eklendi!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen tüm alanları doldurun ve öğrenci seçin!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Ders silme
  void _deleteLesson(int id) {
    setState(() {
      _lessons.removeWhere((lesson) => lesson['id'] == id);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ders silindi!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Grup ekleme
  void _addGroup() {
    if (_groupNameController.text.isNotEmpty && 
        _groupDescriptionController.text.isNotEmpty && 
        _groupSubjectController.text.isNotEmpty) {
      setState(() {
        _groups.add({
          'id': DateTime.now().millisecondsSinceEpoch,
          'name': _groupNameController.text,
          'description': _groupDescriptionController.text,
          'subject': _groupSubjectController.text,
          'studentCount': 0,
          'createdAt': DateTime.now().toString().split(' ')[0],
        });
        
        // Formu temizle
        _groupNameController.clear();
        _groupDescriptionController.clear();
        _groupSubjectController.clear();
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Grup oluşturuldu!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen tüm alanları doldurun!'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  // Gruba öğrenci ekleme
  void _addStudentToGroup(int groupId) {
    // Bu fonksiyon bir dialog açarak öğrenci seçimi yapacak
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Gruba Öğrenci Ekle'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _students.length,
            itemBuilder: (context, index) {
              final student = _students[index];
              final isInGroup = student['groupId'] == groupId;
              final isInOtherGroup = student['groupId'] != null && student['groupId'] != groupId;
              
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: isInGroup ? Colors.green : (isInOtherGroup ? Colors.orange : Colors.grey),
                  child: Text(
                    student['name'][0],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(student['name']),
                subtitle: Text(
                  isInGroup ? 'Bu grupta' : (isInOtherGroup ? 'Başka grupta' : 'Grup yok')
                ),
                trailing: isInGroup 
                  ? const Icon(Icons.check, color: Colors.green)
                  : (isInOtherGroup 
                    ? const Icon(Icons.warning, color: Colors.orange)
                    : IconButton(
                        icon: const Icon(Icons.add, color: Colors.blue),
                        onPressed: () {
                          setState(() {
                            student['groupId'] = groupId;
                            student['group'] = _groups.firstWhere((g) => g['id'] == groupId)['name'];
                          });
                          
                          // Grup öğrenci sayısını güncelle
                          final group = _groups.firstWhere((g) => g['id'] == groupId);
                          group['studentCount'] = _students.where((s) => s['groupId'] == groupId).length;
                          
                          Navigator.pop(context);
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${student['name']} gruba eklendi!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      )),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  // Gruptan öğrenci çıkarma
  void _removeStudentFromGroup(int studentId, int groupId) {
    setState(() {
      final student = _students.firstWhere((s) => s['id'] == studentId);
      student['groupId'] = null;
      student['group'] = 'Genel Grup';
      
      // Grup öğrenci sayısını güncelle
      final group = _groups.firstWhere((g) => g['id'] == groupId);
      group['studentCount'] = _students.where((s) => s['groupId'] == groupId).length;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Öğrenci gruptan çıkarıldı!'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  // Grup silme
  void _deleteGroup(int groupId) {
    // Gruptaki öğrencileri genel gruba taşı
    setState(() {
      for (var student in _students) {
        if (student['groupId'] == groupId) {
          student['groupId'] = null;
          student['group'] = 'Genel Grup';
        }
      }
      
      // Grubu sil
      _groups.removeWhere((group) => group['id'] == groupId);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Grup silindi ve öğrenciler genel gruba taşındı!'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  // Puanlama ekleme
  void _addGrade() {
    if (_selectedStudentId != null && 
        _gradeScoreController.text.isNotEmpty && 
        _gradeCriteriaController.text.isNotEmpty && 
        _gradeCommentController.text.isNotEmpty) {
      
      final score = int.tryParse(_gradeScoreController.text);
      if (score == null || score < 0 || score > 100) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Puan 0-100 arasında olmalıdır!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      final student = _students.firstWhere((s) => s['id'].toString() == _selectedStudentId);
      
      setState(() {
        _grades.add({
          'id': DateTime.now().millisecondsSinceEpoch,
          'studentId': int.parse(_selectedStudentId!),
          'studentName': student['name'],
          'assignmentId': null,
          'assignmentTitle': 'Genel Değerlendirme',
          'score': score,
          'maxScore': 100,
          'comment': _gradeCommentController.text,
          'criteria': _gradeCriteriaController.text,
          'gradedAt': DateTime.now().toString().split(' ')[0],
          'teacher': 'Ahmet Hoca', // Bu öğretmenin adı olacak
        });
        
        // Formu temizle
        _gradeScoreController.clear();
        _gradeCommentController.clear();
        _gradeCriteriaController.clear();
        _selectedStudentId = null;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${student['name']} için puanlama eklendi!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen tüm alanları doldurun!'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  void dispose() {
    _announcementTitleController.dispose();
    _announcementContentController.dispose();
    _announcementDateController.dispose();
    _announcementTimeController.dispose();
    _assignmentTitleController.dispose();
    _assignmentContentController.dispose();
    _assignmentDueDateController.dispose();
    _studentNameController.dispose();
    _studentEmailController.dispose();
    _lessonTitleController.dispose();
    _lessonDateController.dispose();
    _lessonTimeController.dispose();
    _lessonDurationController.dispose();
    _groupNameController.dispose();
    _groupDescriptionController.dispose();
    _groupSubjectController.dispose();
    _gradeScoreController.dispose();
    _gradeCommentController.dispose();
    _gradeCriteriaController.dispose();
    _questionAnswerController.dispose();
    super.dispose();
  }
}
