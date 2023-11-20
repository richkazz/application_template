import 'package:app_ui/app_ui.dart';
import 'package:domain/domain.dart';

extension FormSubmissionStateExtensions on FormSubmissionStateEnum {
  bool get isInitial => this == FormSubmissionStateEnum.initial;
  bool get isInProgress => this == FormSubmissionStateEnum.inProgress;
  bool get isNetworkFailure {
    var check = this == FormSubmissionStateEnum.networkFailure;
    if (check) {
      AppNotify.dismissNotify();
    }
    return check;
  }

  bool get isServerFailure {
    var check = this == FormSubmissionStateEnum.serverFailure;
    if (check) {
      AppNotify.dismissNotify();
    }
    return check;
  }

  bool get isSuccessful {
    var check = this == FormSubmissionStateEnum.successful;
    if (check) {
      AppNotify.dismissNotify();
    }
    return check;
  }

  bool get isError {
    var check = this == FormSubmissionStateEnum.error;
    if (check) {
      AppNotify.dismissNotify();
    }
    return check;
  }

  bool get isAuthenticationError {
    var check = this == FormSubmissionStateEnum.authenticationError;
    if (check) {
      AppNotify.dismissNotify();
    }
    return check;
  }
}
