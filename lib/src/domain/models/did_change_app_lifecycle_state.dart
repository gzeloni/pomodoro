// @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.inactive &&
  //       isStarted == true &&
  //       _hasANotification == false) {
  //     _hasANotification = true;
  //     _showProgressNotification();
  //   } else if (state == AppLifecycleState.detached) {
  //     if (isStarted == true) {
  //       resetTimer();
  //     }
  //   }
  //   super.didChangeAppLifecycleState(state);
  // }