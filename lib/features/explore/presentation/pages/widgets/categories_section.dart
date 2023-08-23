import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/manager/dailog/dialog_custom.dart';
import 'package:netflix/features/categories/presentation/manager/providers.dart';
import 'package:netflix/features/categories/presentation/pages/widgets/categories_loading_shimmer.dart';
import 'package:netflix/features/explore/presentation/manager/categories_select_providers.dart';
import '../../../../../core/manager/color/colors_manager.dart';

class CategoriesSection extends ConsumerWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(getCategoriesUseCaseProvider);
    final selectedCategories = ref.watch(selectedCategoriesProvider);

    ref.listen(getCategoriesUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        error: (error, stackTrace) {
          DialogCustom.showSnackBar(context, message: error.toString());
        },
      );
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: categories.maybeWhen(
        data: (data) {
          return SizedBox(
            height: 50,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: data!.length,
              itemBuilder: (context, index) {
                final isSelected = selectedCategories.contains(data[index].id);
                return FilterChip(
                  label: Text(data[index].name),
                  selected: isSelected,
                  onSelected: (value) {
                    ref.read(selectedCategoriesProvider.notifier).state = value
                        ? [...selectedCategories, data[index].id]
                        : selectedCategories
                            .where((element) => element != data[index].id)
                            .toList();
                  },
                  selectedColor: isSelected
                      ? Colors.red.shade300
                      : AppColorsManager.accentColor,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? AppColorsManager.white
                        : AppColorsManager.red,
                    fontWeight: FontWeight.bold,
                  ),
                  checkmarkColor: AppColorsManager.white,
                  side: BorderSide(
                    color: isSelected
                        ? Colors.red.shade300
                        : AppColorsManager.accentColor,
                    width: 1.4,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 7,
                );
              },
            ),
          );
        },
        loading: () => const CategoriesLoadingShimmer(),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}
