import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderState());

  void updateIndex(int index) {
    emit(SliderState(currentIndex: index));
  }
}
