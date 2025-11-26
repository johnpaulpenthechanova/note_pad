@echo off
REM Run Flutter web app on Chrome without --no-sandbox flag
flutter run -d chrome --dart-define=FLUTTER_WEB_USE_SKIA=false
pause
