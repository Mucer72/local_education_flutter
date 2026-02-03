class ApiEndpoint {
  static const String domain =
      'https://asia-southeast1-localedu-f7829.cloudfunctions.net';

  // Authorization
  static const String authLogin = '$domain/login';
  static const String authGetProfile = '$domain/api/users/getProfile';
  static const String authRegister = '$domain/api/users/register';

  //Course
  static String getCourse({String keyword = ""}) {
    if (keyword.isEmpty) {
      return '$domain/api/courses';
    }
    return "$domain/api/courses?Keyword=$keyword";
  }

  static String getCourseBySlug(String slug) {
    return '$domain/api/courses/bySlug/$slug';
  }

  // Tour
  static String getTour({String keyword = ""}) {
    if (keyword.isEmpty) {
      return "$domain/api/tours";
    }
    return "$domain/api/tours?Keyword=$keyword";
  }

  static String getTourBySlug(String slug) {
    return '$domain/api/tours/bySlug/$slug';
  }

  // Lesson
  static String getLessonsBySlug(String slug) {
    return '$domain/api/lessons/getLessons/$slug';
  }

  // Slides

  static String getSlideByLessonID(String lessonID) {
    return '$domain/api/slides/list/$lessonID';
  }
}
