import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategorySelector extends StatelessWidget {
  final String selected;
  final Function(String) onSelected;

  const CategorySelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = ['Surah', 'Hafalan',];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:
            categories.map((category) {
              final isSelected = selected == category;
              return GestureDetector(
                onTap: () => onSelected(category),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xff437988) : Color(0xffECF6F5),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 5), // Geser ke bawah
                          blurRadius: 10, // Bayangan lebih lembut // Menyebar sedikit
                        ),
                      ],
                    ),
                    child: Text(
                      category,
                      style: GoogleFonts.poppins(
                        color: isSelected ? Color(0xffffffff) : Color(0xff437988),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
