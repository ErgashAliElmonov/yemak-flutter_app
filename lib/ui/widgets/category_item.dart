import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yemak_app/store/category_store.dart';

class CategoryItem extends StatelessWidget {
  final category;
  const CategoryItem({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:
            context.read<CategoryStore>().activeId == category.id
                ? Color(0xFFffdd59)
                : Colors.transparent,
      ),

      padding: EdgeInsets.only(top: 4, bottom: 4, right: 15, left: 15),
      child: TextButton(
        onPressed: () {
          final categoryStore = Provider.of<CategoryStore>(
            context,
            listen: false,
          );
          categoryStore.setActiveId(category.id, context);
        },
        style: TextButton.styleFrom(
          overlayColor: Colors.transparent,
          padding: EdgeInsets.all(0),
        ),
        child: Text(
          category.title,
          style: TextStyle(
            color:
                context.read<CategoryStore>().activeId == category.id
                    ? Colors.black
                    : const Color.fromARGB(255, 113, 118, 121),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
