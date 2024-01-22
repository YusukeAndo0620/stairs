import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'carousel_provider.g.dart';

class CarouselDisplayModel {
  const CarouselDisplayModel({
    required this.isReady,
    required this.maxPage,
    required this.pageController,
  });

  final bool isReady;
  final int maxPage;
  final PageController pageController;

  CarouselDisplayModel copyWith({
    bool? isReady,
    int? maxPage,
    PageController? pageController,
  }) =>
      CarouselDisplayModel(
        isReady: isReady ?? this.isReady,
        maxPage: maxPage ?? this.maxPage,
        pageController: pageController ?? this.pageController,
      );

  int get currentPage {
    if (pageController.positions.isEmpty || pageController.page == null) {
      return 0;
    } else if (pageController.page!.toInt() >= maxPage) {
      return maxPage == 0 ? 0 : maxPage - 1;
    }
    return pageController.page!.toInt();
  }
}

@riverpod
class Carousel extends _$Carousel {
  @override
  CarouselDisplayModel build() => CarouselDisplayModel(
        isReady: true,
        maxPage: 0,
        pageController: PageController(initialPage: 0, viewportFraction: 0.8),
      );

  void init({required int maxPage}) {
    state = CarouselDisplayModel(
      isReady: true,
      maxPage: maxPage,
      pageController: state.pageController,
    );
  }

  void updatePageIndex({required int pageIndex}) {
    state = state.copyWith(
      pageController:
          PageController(initialPage: pageIndex, viewportFraction: 0.8),
    );
  }

  void setReady() async {
    state = state.copyWith(isReady: true);
  }

  void moveNextPage() {
    if (state.pageController.positions.isEmpty) return;
    if (state.pageController.page!.toInt() + 1 <= state.maxPage &&
        state.isReady) {
      state = state.copyWith(isReady: false);

      state.pageController.animateToPage(
        state.pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      setReady();
    }
  }

  void movePreviousPage() {
    if (state.pageController.positions.isEmpty && !state.isReady) return;
    state = state.copyWith(isReady: false);

    state.pageController.animateToPage(
      state.pageController.page!.toInt() - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    setReady();
  }

  void moveLastPage() {
    if (state.pageController.positions.isEmpty) return;
    if (state.pageController.page!.toInt() != state.maxPage && state.isReady) {
      state = state.copyWith(isReady: false);

      state.pageController.animateToPage(
        state.maxPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
      setReady();
    }
  }
}
