part of 'g_maps_cubit.dart';

class GMapState{
   GMapState({this.selectedString,this.error,this.errorMsg,this.predictions,this.completed});
  final String? selectedString;
  final List<Predictions>? predictions;
  final bool? error;
  final String? errorMsg;
  final bool? completed;


  GMapState copyWith({String? selectedString,List<Predictions>? predictions,bool? error,String? errorMsg,bool? completed}){
    return GMapState(
      selectedString: selectedString ?? this.selectedString,
      predictions: predictions ?? this.predictions,
      error: error ?? this.error,
      errorMsg: errorMsg ?? this.errorMsg,
      completed: completed ?? this.completed
    );
  }
}