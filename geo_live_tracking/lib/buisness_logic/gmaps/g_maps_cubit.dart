import 'package:bloc/bloc.dart';
import 'package:geo_live_tracking/data_layer/maps_api.dart';
import 'package:geo_live_tracking/models/auto_complete_model.dart';
import 'package:meta/meta.dart';

part 'g_maps_state.dart';

class GMapsCubit extends Cubit<GMapState> {
  GMapsCubit() : super(GMapState(selectedString: "",predictions: [],error: false,errorMsg: ""));

  void getAutoComplete(String input) async{
    final response = await MapsApi().getAutoComplete(input);
    if(response is AutoCompleteModel){
      emit(state.copyWith(predictions: response.predictions,error: false,errorMsg: "",selectedString: input));
  }else{
    emit(state.copyWith(error: true,errorMsg: "Something went wrong"));
  }
  }

  void clear(){
    emit(state.copyWith(selectedString: "",predictions: [],error: false,errorMsg: "",completed: false));
  }

  void submit(String place){
    emit(state.copyWith(selectedString: place));
  }
  void confirm(){
    emit(state.copyWith(completed: true));
  }
}
