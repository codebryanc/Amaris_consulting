import 'package:amaris_consulting/bll/wallet/wallet_bll.dart';
import 'package:bloc/bloc.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial()) {
    on<DoGetWallet>(_onDoGetWallet);
  }

  // [Methods]
  Future<void> _onDoGetWallet(DoGetWallet event, Emitter<WelcomeState> emit) async {
    double currentValue = WalletBll().getWalletValue();

    emit(WalletLoaded(currentValue));
  }
}