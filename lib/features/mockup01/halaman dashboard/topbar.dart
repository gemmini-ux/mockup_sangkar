import 'package:flutter/material.dart';

class Topbar extends StatelessWidget {
  const Topbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      margin: const EdgeInsets.fromLTRB(24, 20, 24, 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xff0B1424),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.cyan.withValues(alpha: .15)),
      ),
      child: Row(
        children: [
          /// SEARCH
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xff111C30),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),

                  const Icon(Icons.search, color: Colors.white54),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText:
                            "Cari template, desain, pelanggan, pesanan...",
                        hintStyle: TextStyle(color: Colors.white38),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "CTRL + K",
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 24),

          /// DATE
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "24 Juli 2025",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Kamis",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),

          const SizedBox(width: 25),

          _status(),

          const SizedBox(width: 25),

          _icon(Icons.notifications_none_outlined),

          const SizedBox(width: 10),

          _icon(Icons.mail_outline),

          const SizedBox(width: 10),

          _icon(Icons.dark_mode_outlined),

          const SizedBox(width: 20),

          Container(width: 1, height: 36, color: Colors.white12),

          const SizedBox(width: 20),

          const CircleAvatar(
            radius: 22,
            backgroundColor: Colors.cyanAccent,
            child: Icon(Icons.person, color: Colors.black),
          ),

          const SizedBox(width: 12),

          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Admin Produksi",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Administrator",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _icon(IconData icon) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xff111C30),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: Colors.white70),
    );
  }

  static Widget _status() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          CircleAvatar(radius: 4, backgroundColor: Colors.greenAccent),
          SizedBox(width: 8),
          Text(
            "Database Online",
            style: TextStyle(color: Colors.greenAccent, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
