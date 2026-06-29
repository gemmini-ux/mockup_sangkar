// ============================================================
// SANGKAR DECAL PRODUCTION — MODEL CLASSES
// Semua entitas data untuk aplikasi produksi decal sangkar burung
// ============================================================

// ─────────────────────────────────────────────────────────────
// 1. PELANGGAN (Customer)
// ─────────────────────────────────────────────────────────────
class Pelanggan {
  final String id;
  final String nama;
  final String telepon;
  final String kota;
  final String email;
  final int totalPesanan;
  final String totalBelanja;
  final String bergabungSejak;

  const Pelanggan({
    required this.id,
    required this.nama,
    required this.telepon,
    required this.kota,
    required this.email,
    required this.totalPesanan,
    required this.totalBelanja,
    required this.bergabungSejak,
  });
}

// ─────────────────────────────────────────────────────────────
// 2. SANGKAR (Cage — jenis & spesifikasi)
// ─────────────────────────────────────────────────────────────
class JenisSangkar {
  final String id;
  final String nama;         // Murai Batu Borneo, Lovebird Oval, dll.
  final String bentuk;       // Bulat, Oval, Hexagon, Kotak, Octagon
  final String jenisBurung;  // Murai, Lovebird, Kacer, Kenari, dll.
  final String ukuranTotal;  // misal "60 x 45 cm (T x D)"
  final List<BagianSangkar> bagian;

  const JenisSangkar({
    required this.id,
    required this.nama,
    required this.bentuk,
    required this.jenisBurung,
    required this.ukuranTotal,
    required this.bagian,
  });
}

// ─────────────────────────────────────────────────────────────
// 3. BAGIAN SANGKAR (Cage Parts — area yang akan dipasang decal)
// ─────────────────────────────────────────────────────────────
class BagianSangkar {
  final String kode;        // B-KBH, B-BDN, B-KKI, dll.
  final String nama;        // Kubah, Badan Atas, Badan Tengah, Kaki, dll.
  final String ukuran;      // "30 x 20 cm" atau "Keliling 94 cm x T 15 cm"
  final String bentukArea;  // Silinder, Datar, Lengkung
  final bool perluDecal;

  const BagianSangkar({
    required this.kode,
    required this.nama,
    required this.ukuran,
    required this.bentukArea,
    required this.perluDecal,
  });
}

// ─────────────────────────────────────────────────────────────
// 4. DESAIN DECAL (Design Library)
// ─────────────────────────────────────────────────────────────
class DesainDecal {
  final String id;
  final String nama;
  final String kategori;     // Batik, Ornamen, Alam, Geometris, Kaligrafi
  final String motif;        // Parang, Kawung, Mega Mendung, dll.
  final String ukuran;       // "30 x 20 cm"
  final String format;       // SVG, PNG, PDF
  final String resolusi;     // "300 dpi"
  final String desainer;
  final String tanggalBuat;
  final String status;       // Aktif, Arsip, Draft
  final String? imageUrl;    // Opsional untuk URL Gambar AI / File

  const DesainDecal({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.motif,
    required this.ukuran,
    required this.format,
    required this.resolusi,
    required this.desainer,
    required this.tanggalBuat,
    required this.status,
    this.imageUrl,
  });
}

// ─────────────────────────────────────────────────────────────
// 5. TEMPLATE SANGKAR (Preset Kombinasi Sangkar + Decal)
// ─────────────────────────────────────────────────────────────
class TemplateSangkar {
  final String id;
  final String nama;
  final String jenisSangkarId;
  final List<String> desainDecalIds; // list desain per bagian
  final String thumbnail;
  final String harga;
  final int popularitas;
  final String status; // Aktif, Draft
  final String dimensi;
  final int layers;
  final String versi;
  final String dibuatOleh;
  final String tanggalDibuat;
  final String kategori;
  final Map<String, int>? komponen;

  const TemplateSangkar({
    required this.id,
    required this.nama,
    required this.jenisSangkarId,
    required this.desainDecalIds,
    required this.thumbnail,
    required this.harga,
    required this.popularitas,
    required this.status,
    this.dimensi = '3200 x 4500 px',
    this.layers = 24,
    this.versi = '1.0',
    this.dibuatOleh = 'Andi Setiawan',
    this.tanggalDibuat = '22 Mei 2024',
    this.kategori = 'Premium',
    this.komponen,
  });
}// ─────────────────────────────────────────────────────────────
// 6. PESANAN (Order)
// ─────────────────────────────────────────────────────────────
class Pesanan {
  final String id;
  final String kode;              // SGK-001
  final String pelangganId;
  final String pelangganNama;
  final String jenisSangkar;     // Nama sangkar yang dipesan
  final String bentukSangkar;
  final String motifDecal;       // Motif yang diminta pelanggan
  final List<String> bagianDecal; // Bagian yang diberi decal
  final int qty;
  final String ukuranKhusus;    // Jika ada custom size
  final String catatan;
  final String deadline;
  final String statusProduksi;  // Desain, Printing, Cutting, Laminasi, QC, Packing, Selesai
  final String statusPembayaran; // Lunas, DP, Belum
  final String totalHarga;
  final String tanggalPesan;

  const Pesanan({
    required this.id,
    required this.kode,
    required this.pelangganId,
    required this.pelangganNama,
    required this.jenisSangkar,
    required this.bentukSangkar,
    required this.motifDecal,
    required this.bagianDecal,
    required this.qty,
    required this.ukuranKhusus,
    required this.catatan,
    required this.deadline,
    required this.statusProduksi,
    required this.statusPembayaran,
    required this.totalHarga,
    required this.tanggalPesan,
  });
}

// ─────────────────────────────────────────────────────────────
// 7. JOB PRODUKSI (Production Job — per tahap)
// ─────────────────────────────────────────────────────────────
class JobProduksi {
  final String id;
  final String pesananId;
  final String pesananKode;
  final String tahap;          // Printing, Cutting, Laminasi, QC, Packing
  final String mesin;          // Epson L1800, Cutting Plotter, Manual
  final String operator;
  final String jamMulai;
  final String jamSelesai;
  final String status;         // Antri, Berjalan, Selesai, Ditunda
  final String catatan;

  const JobProduksi({
    required this.id,
    required this.pesananId,
    required this.pesananKode,
    required this.tahap,
    required this.mesin,
    required this.operator,
    required this.jamMulai,
    required this.jamSelesai,
    required this.status,
    required this.catatan,
  });
}

// ─────────────────────────────────────────────────────────────
// 8. STOK MATERIAL (Inventory)
// ─────────────────────────────────────────────────────────────
class StokMaterial {
  final String id;
  final String nama;
  final String kategori;   // Vinyl, Tinta, Laminasi, Perlengkapan
  final String satuan;
  final int stokSaat;
  final int stokMinimum;
  final String hargaSatuan;
  final String pemasok;
  final String tanggalUpdate;

  String get levelStok {
    if (stokSaat == 0) return 'Habis';
    if (stokSaat < stokMinimum) return 'Menipis';
    return 'Cukup';
  }

  const StokMaterial({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.satuan,
    required this.stokSaat,
    required this.stokMinimum,
    required this.hargaSatuan,
    required this.pemasok,
    required this.tanggalUpdate,
  });
}

// ─────────────────────────────────────────────────────────────
// 9. QC RECORD
// ─────────────────────────────────────────────────────────────
class QcRecord {
  final String id;
  final String pesananId;
  final String pesananKode;
  final String inspektor;
  final String tanggal;
  final bool kualitasCetak;
  final bool presisiPotongan;
  final bool tampilanAkhir;
  final bool kerapianPenempelan;
  final String hasil;    // Lulus, Revisi, Tolak
  final String catatan;

  const QcRecord({
    required this.id,
    required this.pesananId,
    required this.pesananKode,
    required this.inspektor,
    required this.tanggal,
    required this.kualitasCetak,
    required this.presisiPotongan,
    required this.tampilanAkhir,
    required this.kerapianPenempelan,
    required this.hasil,
    required this.catatan,
  });
}

// ─────────────────────────────────────────────────────────────
// 10. AKTIVITAS (Activity Log)
// ─────────────────────────────────────────────────────────────
class Aktivitas {
  final String id;
  final String judul;
  final String oleh;
  final String waktu;
  final String tipe; // tambah, cetak, potong, qc, ekspor, packing

  const Aktivitas({
    required this.id,
    required this.judul,
    required this.oleh,
    required this.waktu,
    required this.tipe,
  });
}

// ─────────────────────────────────────────────────────────────
// 11. JADWAL PRODUKSI (Schedule)
// ─────────────────────────────────────────────────────────────
class JadwalProduksi {
  final String id;
  final String waktu;
  final String judul;
  final String lokasi; // Mesin, Tim, Ruangan
  final String tipe;   // printing, cutting, laminasi, qc, packing

  const JadwalProduksi({
    required this.id,
    required this.waktu,
    required this.judul,
    required this.lokasi,
    required this.tipe,
  });
}

// ─────────────────────────────────────────────────────────────
// 12. NOTIFIKASI
// ─────────────────────────────────────────────────────────────
class Notifikasi {
  final String id;
  final String judul;
  final String subjek;
  final String waktu;
  final String tipe;  // sukses, info, peringatan, error
  final bool sudahDibaca;

  const Notifikasi({
    required this.id,
    required this.judul,
    required this.subjek,
    required this.waktu,
    required this.tipe,
    required this.sudahDibaca,
  });
}

// ─────────────────────────────────────────────────────────────
// 13. PENGIRIMAN (Shipping)
// ─────────────────────────────────────────────────────────────
class Pengiriman {
  final String id;
  final String pesananId;
  final String pesananKode;
  final String kurir;
  final String nomorResi;
  final String alamatTujuan;
  final String tanggalKirim;
  final String estimasiTiba;
  final String status; // Diproses, Dikirim, Tiba, Selesai

  const Pengiriman({
    required this.id,
    required this.pesananId,
    required this.pesananKode,
    required this.kurir,
    required this.nomorResi,
    required this.alamatTujuan,
    required this.tanggalKirim,
    required this.estimasiTiba,
    required this.status,
  });
}

