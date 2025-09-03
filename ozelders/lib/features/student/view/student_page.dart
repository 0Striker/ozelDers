import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  int _selectedIndex = 0;
  
  // Mock duyurular (öğretmen dashboard'dan gelecek)
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
    {
      'id': 3,
      'title': 'Yeni Duyuru',
      'content': 'Bu hafta sonu ek ders yapılacak.',
      'date': '2024-01-13',
      'time': '10:00',
      'teacher': 'Mehmet Hoca'
    },
  ];

  // Mock gelen sorular
  final List<Map<String, dynamic>> _questions = [
    {
      'id': 1,
      'subject': 'Matematik',
      'question': 'Türev konusunda yardıma ihtiyacım var.',
      'date': '2024-01-15',
      'status': 'Bekliyor'
    },
    {
      'id': 2,
      'subject': 'Fizik',
      'question': 'Newton yasaları hakkında sorum var.',
      'date': '2024-01-14',
      'status': 'Cevaplandı'
    },
    {
      'id': 3,
      'subject': 'Kimya',
      'question': 'Organik bileşikler konusunda yardım.',
      'date': '2024-01-13',
      'status': 'Bekliyor'
    },
  ];

  // Mock ders programı
  final List<Map<String, dynamic>> _schedule = [
    {
      'day': 'Pazartesi',
      'lessons': [
        {'time': '09:00', 'subject': 'Matematik', 'teacher': 'Ahmet Hoca'},
        {'time': '10:30', 'subject': 'Fizik', 'teacher': 'Ayşe Hoca'},
        {'time': '14:00', 'subject': 'Kimya', 'teacher': 'Mehmet Hoca'},
      ]
    },
    {
      'day': 'Salı',
      'lessons': [
        {'time': '09:00', 'subject': 'Biyoloji', 'teacher': 'Fatma Hoca'},
        {'time': '10:30', 'subject': 'Matematik', 'teacher': 'Ahmet Hoca'},
        {'time': '14:00', 'subject': 'Fizik', 'teacher': 'Ayşe Hoca'},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğrenci Paneli'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.go('/'),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          _buildAnnouncementsTab(),
          _buildQuestionsTab(),
          _buildScheduleTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: 'Duyurular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Sorularım',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Ders Programı',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hoş geldin kartı
          Card(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.green, Colors.lightGreen],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hoş Geldin! 👋',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Bugün 3 dersin var. Duyuruları ve ödevlerini kontrol etmeyi unutma!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Hızlı istatistikler
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Bugünkü Ders',
                  '3',
                  Icons.book,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Bekleyen Soru',
                  '2',
                  Icons.question_answer,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Yeni Duyuru',
                  '1',
                  Icons.announcement,
                  Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Son duyurular
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📢 Son Duyurular',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._announcements.take(2).map((announcement) => 
                    _buildAnnouncementCard(announcement)
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => setState(() => _selectedIndex = 1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Tüm Duyuruları Gör'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _announcements.length,
      itemBuilder: (context, index) {
        final announcement = _announcements[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        announcement['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        announcement['teacher'],
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(announcement['content']),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${announcement['date']} ${announcement['time']}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    Icon(
                      Icons.announcement,
                      color: Colors.orange[400],
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuestionsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _questions.length,
      itemBuilder: (context, index) {
        final question = _questions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: question['status'] == 'Bekliyor' 
                ? Colors.orange 
                : Colors.green,
              child: Icon(
                question['status'] == 'Bekliyor' 
                  ? Icons.schedule 
                  : Icons.check,
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
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: question['status'] == 'Bekliyor' 
                  ? Colors.orange.withOpacity(0.1)
                  : Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                question['status'],
                style: TextStyle(
                  color: question['status'] == 'Bekliyor' 
                    ? Colors.orange[700]
                    : Colors.green[700],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildScheduleTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _schedule.length,
      itemBuilder: (context, index) {
        final day = _schedule[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day['day'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),
                ...day['lessons'].map<Widget>((lesson) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          lesson['time'],
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          lesson['subject'],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Text(
                        lesson['teacher'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementCard(Map<String, dynamic> announcement) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  announcement['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                '${announcement['date']} ${announcement['time']}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(announcement['content']),
        ],
      ),
    );
  }
}

