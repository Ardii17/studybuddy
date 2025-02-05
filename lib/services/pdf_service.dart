import 'package:app/object/pdf_model.dart';

class PdfService {
  static final PdfService _instance = PdfService._internal();
  factory PdfService() => _instance;
  PdfService._internal();

  List<PdfModel> _pdfFiles = [];

  void addPdf(PdfModel pdf) {
    _pdfFiles.add(pdf);
  }

  List<PdfModel> getAllPdfs() {
    return _pdfFiles;
  }

  void removePdf(PdfModel pdf) {
    _pdfFiles.remove(pdf);
  }
}