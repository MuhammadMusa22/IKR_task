import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'goats_count_state.dart';

class GoatsCountCubit extends Cubit<int> {
  GoatsCountCubit() : super(-1);

  calculateTotalGoats(int years) {
    List<int> goatsByAge = [1];
    int newBorns;

    for (int year = 1; year <= years; year++) {
      newBorns = 0;
      for (int age = 2; age < goatsByAge.length; age++) {
        newBorns += goatsByAge[age];
      }
      goatsByAge.insert(0, newBorns);
      goatsByAge.add(0);
    }

    int totalGoats = goatsByAge.reduce((a, b) => a + b);
    emit(totalGoats);
  }
}
