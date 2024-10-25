part of '../account_setup_page.dart';

mixin _PageMixin on State<_Page> {
  late TextEditingController _usernameTextEditingController;
  late TextEditingController _nameTextEditingController;
  late TextEditingController _surnameTextEditingController;
  late TextEditingController _bioTextEditingController;
  final GlobalKey<FormState> _usernameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _fullNameCodeFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _bioFormKey = GlobalKey<FormState>();

  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _usernameTextEditingController = TextEditingController();
    _nameTextEditingController = TextEditingController();
    _surnameTextEditingController = TextEditingController();
    _bioTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameTextEditingController.dispose();
    _nameTextEditingController.dispose();
    _surnameTextEditingController.dispose();
    _bioTextEditingController.dispose();
  }

  void _next(File? profilePhoto) {
    final currentPage = _pageController.page;
    if (currentPage == 0) {
      if (!_usernameFormKey.currentState!.validate()) {
        return;
      }
    } else if (currentPage == 1) {
      if (!_fullNameCodeFormKey.currentState!.validate()) {
        return;
      }
    } else if (currentPage == 2) {
      FocusScope.of(context).unfocus();
      if (!_bioFormKey.currentState!.validate()) {
        return;
      }
    } else if (currentPage == 3) {
      if (profilePhoto == null) {
        return;
      }
      context.read<ButtonBloc>().add(
            ButtonEvent.execute(
              useCase: sl<SetupAccountUseCase>(),
              params: SetupAccountParams(
                file: profilePhoto,
                userDetailsParams: UserDetailsParams(
                  username: _usernameTextEditingController.text.trim(),
                  name: _nameTextEditingController.text.trim(),
                  surname: _surnameTextEditingController.text.trim(),
                  bio: _bioTextEditingController.text.trim(),
                  profilePhoto: '',
                ),
              ),
            ),
          );
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _listener(BuildContext context, ButtonState state) {
    state.whenOrNull(
      success: () => context.read<AppBloc>().add(const AppEvent.started()),
      failure: (failure) => ToastUtil.showToastError(context, failure.message),
    );
  }

  void _back() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _changePhoto() {
    BottomSheetUtil.showTakeImageBottomSheet(context).then(
      (profilePhoto) {
        if (!mounted) return;
        context.read<AccountSetupBloc>().add(
              AccountSetupEvent.profilePhotoChanged(profilePhoto: profilePhoto),
            );
      },
    );
  }

  void _changePage(int value) {
    context
        .read<AccountSetupBloc>()
        .add(AccountSetupEvent.pageChanged(index: value));
  }

  void _changeUsername(String value) {
    context.read<AccountSetupBloc>().add(
          AccountSetupEvent.usernameChanged(username: value),
        );
  }

  void _changeSurname(String value) {
    context.read<AccountSetupBloc>().add(
          AccountSetupEvent.surnameChanged(surname: value),
        );
  }

  void _changeBio(String value) {
    context
        .read<AccountSetupBloc>()
        .add(AccountSetupEvent.bioChanged(bio: value));
  }
}
