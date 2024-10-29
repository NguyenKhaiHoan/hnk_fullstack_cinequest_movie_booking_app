part of '../select_location_page.dart';

mixin _PageMixin on State<_Page> {
  late TextEditingController _searchTextEditingController;

  @override
  void initState() {
    super.initState();
    _searchTextEditingController = TextEditingController();
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
}
