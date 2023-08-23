import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/features/explore/presentation/manager/providers.dart';
import 'package:netflix/features/explore/presentation/pages/widgets/categories_section.dart';
import 'package:netflix/features/explore/presentation/pages/widgets/explore_grid_view.dart';

import 'package:netflix/features/explore/presentation/pages/widgets/search_and_filters.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        VerticalSpacer(40),
        SearchAndFilterSection(),
        VerticalSpacer(10),
        CategoriesSection(),
        VerticalSpacer(10),
        Expanded(
          child: Column(
            children: [
              ExploreGridView(),
              NoMoreItems(),
            ],
          ),
        ),
      ],
    );
  }
}

class NoMoreItems extends ConsumerWidget {
  const NoMoreItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getMoviesUseCaseProvider);

    final noMoreItems = ref.read(getMoviesUseCaseProvider.notifier).noMoreItem;
    return state.maybeWhen(
      orElse: () => const SizedBox.shrink(),
      data: (data) {
        return noMoreItems
            ? const Padding(
                padding: EdgeInsets.only(bottom: 20, top: 20),
                child: Text(
                  "No More Items Found!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
      skipLoadingOnReload: true,
    );
  }
}
