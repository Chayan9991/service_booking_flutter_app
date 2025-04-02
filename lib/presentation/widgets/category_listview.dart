import 'package:flutter/material.dart';
import 'package:service_booking_app/core/common/services_list.dart';
import 'package:service_booking_app/data/model/category_model.dart';

class CategoryListView extends StatefulWidget {
  final Function(CategoryModel) onCategorySelected; // Callback function

  const CategoryListView({super.key, required this.onCategorySelected});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;

          // First item: "All Services" option
          if (index == 0) {
            return _buildCategoryItem(
              context,
              isSelected: isSelected,
              icon: Icons.list,
              label: "All Services",
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                widget.onCategorySelected(
                  CategoryModel(
                    categoryId: 0,
                    category: "All Services",
                    icon: "",
                    basePrice: "",
                    details: "",
                  ),
                );
                //  context.read<MainCubit>().loadAllService();
              },
            );
          }

          // Fetch category from list (convert Map to Category object)
          final category = CategoryModel.fromMap(categories[index - 1]);

          return _buildCategoryItem(
            context,
            isSelected: isSelected,
            iconPath: category.icon,
            label: category.category,
            basePrice: category.basePrice,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onCategorySelected(category);
            },
          );
        },
      ),
    );
  }

  // Helper function to build category items
  Widget _buildCategoryItem(
    BuildContext context, {
    required bool isSelected,
    IconData? icon,
    String? iconPath,
    required String label,
    String? basePrice,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: isSelected ? 4 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 120,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                      : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(icon, size: 40, color: Colors.black)
                else if (iconPath != null)
                  Image.asset(
                    iconPath,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(height: 5),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                if (basePrice != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    "Starts From ₹$basePrice",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
