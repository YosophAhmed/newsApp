abstract class NewsStates {}

class IntialNewsState extends NewsStates{}

class BottomNavBarState extends NewsStates{}

class GetBusinessNewsLoadingState extends NewsStates{}

class GetBusinessNewsSuccessState extends NewsStates{}

class GetBusinessNewsErrorsState extends NewsStates{
  final String error;
  GetBusinessNewsErrorsState(this.error);
}

class GetSportsNewsLoadingState extends NewsStates{}

class GetSportsNewsSuccessState extends NewsStates{}

class GetSportsNewsErrorsState extends NewsStates{
  final String error;
  GetSportsNewsErrorsState(this.error);
}

class GetScienceNewsLoadingState extends NewsStates{}

class GetScienceNewsSuccessState extends NewsStates{}

class GetScienceNewsErrorsState extends NewsStates{
  final String error;
  GetScienceNewsErrorsState(this.error);
}