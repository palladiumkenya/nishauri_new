class SurveyState {
  final String questionText;
  final List<String> answerOptions;
  final bool isQuestionRequired;
  final int questionType;
  final bool isLoading;
  final String errorMessage;

  SurveyState({
    required this.questionText,
    required this.answerOptions,
    required this.isQuestionRequired,
    required this.questionType,
    required this.isLoading,
    required this.errorMessage,
  });

  // Initial state when starting the survey
  factory SurveyState.initial() {
    return SurveyState(
      questionText: '',
      answerOptions: [],
      isQuestionRequired: false,
      questionType: 0,
      isLoading: false,
      errorMessage: '',
    );
  }

  // A method to create a new copy of SurveyState with updated values
  SurveyState copyWith({
    String? questionText,
    List<String>? answerOptions,
    bool? isQuestionRequired,
    int? questionType,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SurveyState(
      questionText: questionText ?? this.questionText,
      answerOptions: answerOptions ?? this.answerOptions,
      isQuestionRequired: isQuestionRequired ?? this.isQuestionRequired,
      questionType: questionType ?? this.questionType,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
