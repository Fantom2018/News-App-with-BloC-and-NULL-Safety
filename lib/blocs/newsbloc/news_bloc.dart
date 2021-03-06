import 'package:news_app_wit_bloc/blocs/newsbloc/news_events.dart';
import 'package:news_app_wit_bloc/blocs/newsbloc/news_states.dart';
import 'package:news_app_wit_bloc/models/article_model.dart';
import 'package:news_app_wit_bloc/repositipies/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NewsBloc extends Bloc<NewsEvents, NewsStates> {
  NewsRepository newsRepositoty;
  NewsBloc({required NewsStates initialState, required this.newsRepositoty})
      : super(initialState) {
    add(StartEvent());
  }

  @override
  Stream<NewsStates> mapEventToState(NewsEvents event) async* {
    if (event is StartEvent) {
      try {
        List<ArticleModel> _articleList = [];
        yield NewLoadingState();
        _articleList = await newsRepositoty.fetchNews();
        yield NewsLoadedState(articleList: _articleList);
      } catch (e) {
        yield NewsErrorState(errorMessage: ("Error"));
      }
    }
  }
}