import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup01/data/dummy_db.dart';
import 'package:mocupsangkar/features/mockup01/models/sangkar_models.dart';

class StockController extends GetxController {
  // Reactive list of stock items
  final RxList<StokMaterial> stockItems = <StokMaterial>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load initial stock items from DummyDb
    stockItems.assignAll(DummyDb.stokMaterial);
  }

  // Adjust stock quantity (add or subtract)
  void adjustStock(String id, int amount) {
    final index = stockItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      final old = stockItems[index];
      final newQty = old.stokSaat + amount;
      stockItems[index] = StokMaterial(
        id: old.id,
        nama: old.nama,
        kategori: old.kategori,
        satuan: old.satuan,
        stokSaat: newQty < 0 ? 0 : newQty,
        stokMinimum: old.stokMinimum,
        hargaSatuan: old.hargaSatuan,
        pemasok: old.pemasok,
        tanggalUpdate: DateTime.now().toLocal().toString().substring(0, 19),
      );
    }
  }
}

