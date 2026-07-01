import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup01/data/dummy_db.dart';
import 'package:mocupsangkar/features/mockup01/models/sangkar_models.dart';

class SangkarController extends GetxController {
  final cages = <JenisSangkar>[].obs;
  final templates = <TemplateSangkar>[].obs;

  @override
  void onInit() {
    super.onInit();
    cages.addAll(DummyDb.jenisSangkar);
    templates.addAll(DummyDb.template);
  }

  void addCage(JenisSangkar cage) {
    cages.add(cage);
  }

  void addTemplate(TemplateSangkar template) {
    templates.insert(0, template);
  }
}
