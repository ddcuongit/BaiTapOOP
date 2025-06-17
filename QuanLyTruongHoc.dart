import 'dart:io';

class Person {
  String id;
  String name;
  int age;
  String gender;

  Person(this.id, this.name, this.age, this.gender);
}

// -------------------- Student --------------------
class Student extends Person {
  String grade;
  double score;

  Student(String id, String name, int age, String gender, this.grade, this.score)
      : super(id, name, age, gender);

  void display() {
    print('SV: $name | ID: $id | Tuổi: $age | Giới tính: $gender | Lớp: $grade | Điểm: $score');
  }
}

// -------------------- Teacher --------------------
class Teacher extends Person {
  String subject;
  double salary;

  Teacher(String id, String name, int age, String gender, this.subject, this.salary)
      : super(id, name, age, gender);

  void display() {
    print('GV: $name | ID: $id | Tuổi: $age | Giới tính: $gender | Môn: $subject | Lương: $salary');
  }
}

// -------------------- Classroom --------------------
class Classroom {
  String id;
  String name;
  List<Student> students = [];
  Teacher? teacher;

  Classroom(this.id, this.name);

  void addStudent(Student student) {
    students.add(student);
  }

  void assignTeacher(Teacher t) {
    teacher = t;
  }

  void display() {
    print('\n🔷 Lớp học: $name (ID: $id)');
    if (teacher != null) {
      print('👨‍🏫 Giáo viên phụ trách: ${teacher!.name} - Môn: ${teacher!.subject}');
    } else {
      print('⚠️ Chưa có giáo viên phụ trách.');
    }
    print('👨‍🎓 Danh sách học sinh:');
    if (students.isEmpty) {
      print('📭 Không có học sinh nào.');
    } else {
      for (var s in students) {
        s.display();
      }
    }
  }

  void showAverageScores() {
    print('\n📊 Điểm trung bình học sinh lớp $name:');
    for (var s in students) {
      print('${s.name} - Điểm: ${s.score}');
    }
  }
}

// -------------------- Main & Danh sách --------------------
List<Student> allStudents = [];
List<Teacher> allTeachers = [];
List<Classroom> allClasses = [];

void main() {
  while (true) {
    print('\n===== MENU QUẢN LÝ TRƯỜNG HỌC =====');
    print('1. Thêm học sinh');
    print('2. Thêm giáo viên');
    print('3. Tạo lớp học');
    print('4. Gán học sinh vào lớp');
    print('5. Gán giáo viên vào lớp');
    print('6. Hiển thị thông tin lớp học');
    print('7. Thoát');
    stdout.write('Chọn chức năng (1-7): ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addStudent();
        break;
      case '2':
        addTeacher();
        break;
      case '3':
        createClassroom();
        break;
      case '4':
        assignStudentToClass();
        break;
      case '5':
        assignTeacherToClass();
        break;
      case '6':
        displayClassrooms();
        break;
      case '7':
        print('🔚 Kết thúc chương trình.');
        return;
      default:
        print('❌ Lựa chọn không hợp lệ!');
    }
  }
}

// ================== Chức năng ==================
void addStudent() {
  stdout.write('ID: ');
  String id = stdin.readLineSync()!;
  stdout.write('Họ tên: ');
  String name = stdin.readLineSync()!;
  int age = getInt('Tuổi: ');
  stdout.write('Giới tính: ');
  String gender = stdin.readLineSync()!;
  stdout.write('Lớp: ');
  String grade = stdin.readLineSync()!;
  double score = getDouble('Điểm: ');

  allStudents.add(Student(id, name, age, gender, grade, score));
  print('✅ Thêm học sinh thành công.');
}

void addTeacher() {
  stdout.write('ID: ');
  String id = stdin.readLineSync()!;
  stdout.write('Họ tên: ');
  String name = stdin.readLineSync()!;
  int age = getInt('Tuổi: ');
  stdout.write('Giới tính: ');
  String gender = stdin.readLineSync()!;
  stdout.write('Môn dạy: ');
  String subject = stdin.readLineSync()!;
  double salary = getDouble('Lương: ');

  allTeachers.add(Teacher(id, name, age, gender, subject, salary));
  print('✅ Thêm giáo viên thành công.');
}

void createClassroom() {
  stdout.write('ID lớp: ');
  String id = stdin.readLineSync()!;
  stdout.write('Tên lớp: ');
  String name = stdin.readLineSync()!;
  allClasses.add(Classroom(id, name));
  print('✅ Tạo lớp học thành công.');
}

void assignStudentToClass() {
  if (allStudents.isEmpty || allClasses.isEmpty) {
    print('⚠️ Hãy thêm học sinh và lớp học trước.');
    return;
  }

  stdout.write('Nhập ID lớp: ');
  String classId = stdin.readLineSync()!;
  var classroom = allClasses.firstWhere((c) => c.id == classId, orElse: () => null);
  if (classroom == null) {
    print('❌ Không tìm thấy lớp.');
    return;
  }

  stdout.write('Nhập ID học sinh: ');
  String studentId = stdin.readLineSync()!;
  var student = allStudents.firstWhere((s) => s.id == studentId, orElse: () => null);
  if (student == null) {
    print('❌ Không tìm thấy học sinh.');
    return;
  }

  classroom.addStudent(student);
  print('✅ Đã thêm học sinh vào lớp.');
}

void assignTeacherToClass() {
  if (allTeachers.isEmpty || allClasses.isEmpty) {
    print('⚠️ Hãy thêm giáo viên và lớp học trước.');
    return;
  }

  stdout.write('Nhập ID lớp: ');
  String classId = stdin.readLineSync()!;
  var classroom = allClasses.firstWhere((c) => c.id == classId, orElse: () => null);
  if (classroom == null) {
    print('❌ Không tìm thấy lớp.');
    return;
  }

  stdout.write('Nhập ID giáo viên: ');
  String teacherId = stdin.readLineSync()!;
  var teacher = allTeachers.firstWhere((t) => t.id == teacherId, orElse: () => null);
  if (teacher == null) {
    print('❌ Không tìm thấy giáo viên.');
    return;
  }

  classroom.assignTeacher(teacher);
  print('✅ Đã gán giáo viên vào lớp.');
}

void displayClassrooms() {
  if (allClasses.isEmpty) {
    print('📭 Chưa có lớp học nào.');
    return;
  }

  for (var c in allClasses) {
    c.display();
    c.showAverageScores();
  }
}

// ================== Hàm nhập an toàn ==================
int getInt(String prompt) {
  while (true) {
    stdout.write(prompt);
    int? val = int.tryParse(stdin.readLineSync()!);
    if (val != null) return val;
    print('❌ Vui lòng nhập số nguyên hợp lệ!');
  }
}

double getDouble(String prompt) {
  while (true) {
    stdout.write(prompt);
    double? val = double.tryParse(stdin.readLineSync()!);
    if (val != null) return val;
    print('❌ Vui lòng nhập số hợp lệ!');
  }
}
