// ============================================================
// TOPBAR RESPONSIVE — Menyesuaikan ukuran layar
// Desktop : search + status + ikon + avatar (full)
// Tablet  : search singkat + ikon + avatar
// Mobile  : judul + hamburger + avatar
// ============================================================
import 'package:flutter/material.dart';

class TopbarResponsive extends StatelessWidget {
  final VoidCallback? onHamburgerTap;

  const TopbarResponsive({super.key, this.onHamburgerTap});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;

    if (w >= 1024) return _TopbarDesktop();
    if (w >= 600) return _TopbarTablet();
    return _TopbarMobile(onHamburgerTap: onHamburgerTap);
  }
}

// ── Desktop ───────────────────────────────────────────────────
class _TopbarDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final bool showFullAvatar = w >= 1220;
    final bool showStatusDb = w >= 1100;
    final bool showDate = w >= 980;

    return Container(
      height: 82,
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: _dekor(),
      child: Row(
        children: [
          // Search
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF111C30),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.search, color: Colors.white38, size: 20),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white, fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Cari template, desain, pesanan...',
                        hintStyle: TextStyle(color: Colors.white30, fontSize: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (w >= 1080)
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'CTRL+K',
                        style: TextStyle(color: Colors.white38, fontSize: 10),
                      ),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 20),

          // Tanggal
          if (showDate) ...[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _tanggalHariIni(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(
                  _hariIni(),
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
            const SizedBox(width: 20),
          ],

          // Status DB
          if (showStatusDb) ...[
            const _StatusChip(),
            const SizedBox(width: 16),
          ],

          _IkonBulat(Icons.notifications_none_outlined, badge: true),
          const SizedBox(width: 8),
          _IkonBulat(Icons.mail_outline),
          const SizedBox(width: 8),
          _IkonBulat(Icons.dark_mode_outlined),

          const SizedBox(width: 16),
          Container(width: 1, height: 36, color: Colors.white12),
          const SizedBox(width: 16),

          _AvatarUser(showLabel: showFullAvatar),
        ],
      ),
    );
  }
}

// ── Tablet ────────────────────────────────────────────────────
class _TopbarTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: _dekor(),
      child: Row(
        children: [
          // Search mini
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF111C30),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 12),
                  Icon(Icons.search, color: Colors.white38, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      decoration: InputDecoration(
                        hintText: 'Cari...',
                        hintStyle: TextStyle(color: Colors.white30),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 12),
          _StatusChip(compact: true),
          const SizedBox(width: 12),
          _IkonBulat(Icons.notifications_none_outlined, badge: true),
          const SizedBox(width: 8),
          _AvatarUser(showLabel: false),
        ],
      ),
    );
  }
}

// ── Mobile ────────────────────────────────────────────────────
class _TopbarMobile extends StatelessWidget {
  final VoidCallback? onHamburgerTap;
  const _TopbarMobile({this.onHamburgerTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF0B1424),
        border: Border(bottom: BorderSide(color: Color(0xFF16253C))),
      ),
      child: Row(
        children: [
          // Hamburger
          InkWell(
            onTap: onHamburgerTap,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF111C30),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.menu_rounded, color: Colors.cyanAccent, size: 20),
            ),
          ),

          const SizedBox(width: 12),

          // Judul
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Sangkar Studio Decal',
                style: TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),

          const Spacer(),

          _IkonBulat(Icons.search, size: 38),
          const SizedBox(width: 8),
          _IkonBulat(Icons.notifications_none_outlined, badge: true, size: 38),
          const SizedBox(width: 8),
          _AvatarUser(showLabel: false, radius: 18),
        ],
      ),
    );
  }
}

// ── Komponen kecil ────────────────────────────────────────────
class _StatusChip extends StatelessWidget {
  final bool compact;
  const _StatusChip({this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 10 : 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.greenAccent.withValues(alpha: .2)),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 7),
          Text(
            compact ? 'Online' : 'Database Online',
            style: const TextStyle(color: Colors.greenAccent, fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _IkonBulat extends StatelessWidget {
  final IconData icon;
  final bool badge;
  final double size;

  const _IkonBulat(this.icon, {this.badge = false, this.size = 44});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color(0xFF111C30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white60, size: size * .44),
        ),
        if (badge)
          Positioned(
            right: 4,
            top: 4,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
            ),
          ),
      ],
    );
  }
}

class _AvatarUser extends StatelessWidget {
  final bool showLabel;
  final double radius;

  const _AvatarUser({required this.showLabel, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: Colors.cyanAccent,
          child: Icon(Icons.person, color: Colors.black, size: radius),
        ),
        if (showLabel) ...[
          const SizedBox(width: 10),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admin Produksi',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                'Administrator',
                style: TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

BoxDecoration _dekor() => BoxDecoration(
  color: const Color(0xFF0B1424),
  borderRadius: BorderRadius.circular(18),
  border: Border.all(color: Colors.cyan.withValues(alpha: .15)),
);

// Util tanggal
String _tanggalHariIni() {
  final now = DateTime.now();
  final bulan = [
    '', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
  ];
  return '${now.day} ${bulan[now.month]} ${now.year}';
}

String _hariIni() {
  final hari = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
  return hari[DateTime.now().weekday % 7];
}

