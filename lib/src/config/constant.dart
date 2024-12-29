import 'enum.dart';

const kBaseApiUrl = 'https://reqres.in/api';

const kTableTask = 'tasks';

const kSharedPrefLoginCredentialKey = 'login_credential';
const kSharedPrefOnboardingKey = 'onboarding';
const kSharedPrefNotificationKey = 'notification';
const kSharedPrefThemeKey = 'theme';

const List<TaskStatus> kTaskStatus = [
  TaskStatus.pending,
  TaskStatus.completed,
  TaskStatus.progress
];
