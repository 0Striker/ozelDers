import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class TeacherStudentsPage extends StatefulWidget {
  const TeacherStudentsPage({super.key});

  @override
  State<TeacherStudentsPage> createState() => _TeacherStudentsPageState();
}

class _TeacherStudentsPageState extends State<TeacherStudentsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _searchController = TextEditingController();
  
  List<Map<String, dynamic>> _students = [];
  List<Map<String, dynamic>> _filteredStudents = [];
  String? _newStudentPassword;
  String? _newStudentName;

  @override
  void initState() {
    super.initState();
    _loadMockStudents();
    _filteredStudents = _students;
  }

  void _loadMockStudents() {
    _students = [
      {
        'id': '1',
        'name': 'Ahmet Yılmaz',
        'password': 'pass123',
        'grade': 85,
        'subject': 'Matematik',
        'lastLesson': '2024-01-15',
      },
      {
        'id': '2',
        'name': 'Ayşe Demir',
        'password': 'pass456',
        'grade': 92,
        'subject': 'Fizik',
        'lastLesson': '2024-01-14',
      },
      {
        'id': '3',
        'name': 'Mehmet Kaya',
        'password': 'pass789',
        'grade': 78,
        'subject': 'Kimya',
        'lastLesson': '2024-01-13',
      },
      {
        'id': '4',
        'name': 'Fatma Özkan',
        'password': 'pass101',
        'grade': 88,
        'subject': 'Biyoloji',
        'lastLesson': '2024-01-12',
      },
    ];
  }

  String _generateRandomPassword() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(8, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  void _addStudent() {
    if (_formKey.currentState!.validate()) {
      final newPassword = _generateRandomPassword();
      final newStudent = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': _nameController.text,
        'password': newPassword,
        'grade': 0,
        'subject': 'Genel',
        'lastLesson': DateTime.now().toString().split(' ')[0],
      };

      setState(() {
        _students.add(newStudent);
        _filteredStudents = _students;
        _newStudentPassword = newPassword;
        _newStudentName = _nameController.text;
        _nameController.clear();
      });

      // Yeni öğrenci bilgilerini göster
      _showNewStudentInfo();
    }
  }

  void _showNewStudentInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yeni Öğrenci Oluşturuldu'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Öğrenci Adı: $_newStudentName'),
            const SizedBox(height: 8),
            Text('Şifre: $_newStudentPassword'),
            const SizedBox(height: 16),
            const Text('Bu bilgileri kopyalayabilirsiniz.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tamam'),
          ),
          ElevatedButton(
            onPressed: () {
              final info = 'Öğrenci Adı: $_newStudentName\nŞifre: $_newStudentPassword';
              Clipboard.setData(ClipboardData(text: info));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bilgiler kopyalandı!')),
              );
              Navigator.pop(context);
            },
            child: const Text('Kopyala'),
          ),
        ],
      ),
    );
  }

  void _updateGrade(String studentId, double newGrade) {
    setState(() {
      final studentIndex = _students.indexWhere((s) => s['id'] == studentId);
      if (studentIndex != -1) {
        _students[studentIndex]['grade'] = newGrade;
        _filteredStudents = _students;
      }
    });
  }

  void _filterStudents(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredStudents = _students;
      } else {
        _filteredStudents = _students
            .where((student) =>
                student['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğrenci Yönetimi'),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/teacher/dashboard'),
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
        child: Column(
          children: [
            // Arama ve Öğrenci Ekleme
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Arama
                  TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Öğrenci Ara',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _filterStudents,
                  ),
                  const SizedBox(height: 16),
                  
                  // Yeni Öğrenci Ekleme
                  Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Öğrenci Adı',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Öğrenci adı gerekli';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: _addStudent,
                          icon: const Icon(Icons.add),
                          label: const Text('Oluştur'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Öğrenci Listesi
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.people, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Öğrenciler',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredStudents.length,
                        itemBuilder: (context, index) {
                          final student = _filteredStudents[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Text(
                                  student['name'][0].toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(student['name']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Ders: ${student['subject']}'),
                                  Text('Son Ders: ${student['lastLesson']}'),
                                  Row(
                                    children: [
                                      const Text('Puan: '),
                                      Text(
                                        '${student['grade']}',
                                        style: TextStyle(
                                          color: student['grade'] >= 80 
                                              ? Colors.green 
                                              : student['grade'] >= 60 
                                                  ? Colors.orange 
                                                  : Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'grade',
                                    child: Row(
                                      children: [
                                        Icon(Icons.grade),
                                        SizedBox(width: 8),
                                        Text('Puan Ver'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'copy',
                                    child: Row(
                                      children: [
                                        Icon(Icons.copy),
                                        SizedBox(width: 8),
                                        Text('Bilgileri Kopyala'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text('Sil', style: TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ],
                                onSelected: (value) {
                                  switch (value) {
                                    case 'grade':
                                      _showGradeDialog(student);
                                      break;
                                    case 'copy':
                                      final info = 'Öğrenci: ${student['name']}\nŞifre: ${student['password']}';
                                      Clipboard.setData(ClipboardData(text: info));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Bilgiler kopyalandı!')),
                                      );
                                      break;
                                    case 'delete':
                                      _deleteStudent(student['id']);
                                      break;
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showGradeDialog(Map<String, dynamic> student) {
    final gradeController = TextEditingController(text: student['grade'].toString());
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${student['name']} için Puan Ver'),
        content: TextField(
          controller: gradeController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Puan (0-100)',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              final grade = double.tryParse(gradeController.text);
              if (grade != null && grade >= 0 && grade <= 100) {
                _updateGrade(student['id'], grade);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Geçerli bir puan girin (0-100)')),
                );
              }
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  void _deleteStudent(String studentId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Öğrenciyi Sil'),
        content: const Text('Bu öğrenciyi silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _students.removeWhere((s) => s['id'] == studentId);
                _filteredStudents = _students;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}

