class BlocState{
  dynamic data;

  BlocState(this.data);

  factory BlocState.init() => BlocState(null);

  BlocState copy() => BlocState(data);

  void updateParams(dynamic data){
    if (data != null) this.data = data;
  }
}