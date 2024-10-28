import 'package:cinequest/src/common/entities/user_details.dart';
import 'package:cinequest/src/external/services/storage/in_memory_store.dart';

class UserDetailsStreamService {
  final _userDetailsState = InMemoryStore<UserDetails?>(null);

  Stream<UserDetails?> userDetailsStateChanges() => _userDetailsState.stream;

  UserDetails? get currentUserDetails => _userDetailsState.value;

  void updateUserDetails(UserDetails newUserDetails) {
    _userDetailsState.value = newUserDetails;
  }

  void dispose() {
    _userDetailsState.close();
  }
}
