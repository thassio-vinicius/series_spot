abstract class APIs {
  static const String shows = "/shows";
  static String episodes(int id) => "/shows/$id/episodes";
  static const String searchShows = "search/shows";
}
