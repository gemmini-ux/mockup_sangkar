import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup01/data/dummy_db.dart';
import 'package:mocupsangkar/features/mockup01/models/sangkar_models.dart';

class OrderController extends GetxController {
  // Reactive list of orders
  final RxList<Pesanan> orders = <Pesanan>[].obs;
  
  // Reactive list of QC records
  final RxList<QcRecord> qcRecords = <QcRecord>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load initial data from DummyDb
    orders.assignAll(DummyDb.pesanan);
    qcRecords.assignAll(DummyDb.qcRecords);
  }

  // Add new order
  void addOrder(Pesanan order) {
    orders.add(order);
  }

  // Delete order
  void deleteOrder(String id) {
    orders.removeWhere((o) => o.id == id);
  }

  // Update order production status
  void updateProductionStatus(String id, String status) {
    final index = orders.indexWhere((o) => o.id == id);
    if (index != -1) {
      final old = orders[index];
      orders[index] = Pesanan(
        id: old.id,
        kode: old.kode,
        pelangganId: old.pelangganId,
        pelangganNama: old.pelangganNama,
        jenisSangkar: old.jenisSangkar,
        bentukSangkar: old.bentukSangkar,
        motifDecal: old.motifDecal,
        bagianDecal: old.bagianDecal,
        qty: old.qty,
        ukuranKhusus: old.ukuranKhusus,
        catatan: old.catatan,
        deadline: old.deadline,
        statusProduksi: status,
        statusPembayaran: old.statusPembayaran,
        totalHarga: old.totalHarga,
        tanggalPesan: old.tanggalPesan,
      );
    }
  }

  // Add or update QC record
  void addOrUpdateQcRecord(QcRecord record) {
    final index = qcRecords.indexWhere((r) => r.pesananId == record.pesananId);
    if (index != -1) {
      qcRecords[index] = record;
    } else {
      qcRecords.add(record);
    }
  }

  // Get dynamic statistics for dashboard
  int get totalDesigns => orders.length;
  int get totalSelesai => orders.where((o) => o.statusProduksi == 'Selesai').length;
  int get totalDalamProses => orders.where((o) => o.statusProduksi == 'Printing' || o.statusProduksi == 'Cutting' || o.statusProduksi == 'Laminasi').length;
  int get totalRevisi => qcRecords.where((r) => r.hasil == 'Revisi').length; // simple logic for revision status
  int get totalArsip => orders.where((o) => o.statusProduksi == 'Selesai').length; // dummy mapping
}

