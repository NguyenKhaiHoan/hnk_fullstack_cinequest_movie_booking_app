part of '../search_movie_page.dart';

mixin _PageMixin on State<_Page> {
  late TextEditingController _searchTextEditingController;
  late double _startRating;
  late double _endRating;

  @override
  void initState() {
    super.initState();
    _searchTextEditingController = TextEditingController();
    _startRating = 1;
    _endRating = 10;
  }

  @override
  void dispose() {
    super.dispose();
    _searchTextEditingController.dispose();
  }

  void _searchCity(String value) {
    context.read<SearchLocationBloc>().add(
          SearchLocationEvent.searched(
            cityName: _searchTextEditingController.text.trim(),
          ),
        );
  }

  void _onChangedRating(RangeValues values) {
    setState(() {
      _startRating = values.start;
      _endRating = values.end;
    });
  }

  void _onChangeStartRating(RangeValues values) {
    setState(() {
      _startRating = values.start.roundToDouble();
    });
  }

  void _onChangeEndRating(RangeValues values) {
    setState(() {
      _endRating = values.end.roundToDouble();
    });
  }

  final _pageController = PageController();

  void _next() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _back() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
