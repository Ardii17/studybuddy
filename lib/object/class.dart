class Class {
  int? id;
  String teacher;
  String time;
  String namaClass;
  String deskripsi;
  String hari;

  Class({
    this.id,
    required this.teacher,
    required this.time,
    required this.namaClass,
    required this.deskripsi,
    required this.hari
  });

  String toString(){
    return 'ID: $id, Teacher: $teacher, Class name: $namaClass, Day: $hari, Description: $deskripsi, Time: $time';
  }

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      namaClass: json['nama_class'],
      deskripsi: json['deskripsi'],
      hari: json['hari'],
      time: json['time'],
      teacher: json['teacher']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_class': namaClass,
      'deskripsi': deskripsi,
      'hari': hari,
      'teacher' : teacher,
      'time' : time
    };
  }
}
