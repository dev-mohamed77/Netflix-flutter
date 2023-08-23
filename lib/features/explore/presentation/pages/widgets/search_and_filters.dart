import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/extensions/color_extensions.dart';
import 'package:netflix/features/explore/presentation/manager/providers.dart';

import '../../../../../core/components/text_form_field_custom.dart';
import '../../../../../core/manager/color/colors_manager.dart';

class SearchAndFilterSection extends StatefulWidget {
  const SearchAndFilterSection({
    super.key,
  });

  @override
  State<SearchAndFilterSection> createState() => _SearchAndFilterSectionState();
}

class _SearchAndFilterSectionState extends State<SearchAndFilterSection> {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, _) {
        return Row(
          children: [
            Expanded(
              child: TextFormFieldCustom(
                hintText: "Search",
                controller: searchController,
                hintColor: context.secondaryColor,
                validator: (value) {
                  return null;
                },
                onChanged: (value) {
                  if (value.isEmpty) {
                    ref.read(getMoviesUseCaseProvider.notifier).getMovies();
                  } else {
                    ref
                        .read(getMoviesUseCaseProvider.notifier)
                        .getSearchMovies(search: value);
                  }
                },
                prefixIcon: Icons.search,
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {},
              child: Container(
                width: 53,
                height: 53,
                decoration: BoxDecoration(
                  color: Colors.red.shade100.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.sort_sharp,
                  color: AppColorsManager.grey,
                  size: 35,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        );
      },
    );
  }
}
