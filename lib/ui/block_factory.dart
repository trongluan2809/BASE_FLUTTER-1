import 'package:base_flutter_project/ui/login/login_bloc.dart';

import 'base/base_bloc.dart';
import 'dashboard/tab_category/tab_category_bloc.dart';
import 'dashboard/tab_home/tab_home_bloc.dart';
import 'dashboard/tab_info/tab_info_bloc.dart';
import 'splash/splash_bloc.dart';

class BlocFactory {
  B createModelClass<B extends BaseBloc>(Type type) {
    switch (type) {
      case SplashBloc:
        return SplashBloc() as B;
      case LoginBloc:
        return LoginBloc() as B;
      case TabHomeBloc:
        return TabHomeBloc() as B;
      case TabCategoryBloc:
        return TabCategoryBloc() as B;
      case TabInfoBloc:
        return TabInfoBloc() as B;
      default:
        throw "Unknown block class: $type";
    }
  }
}
