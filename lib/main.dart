import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'providers/theme_manager.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';
import 'config/app_config.dart';
import 'utils/responsive.dart'; // إضافة الاستيراد المفقود

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try { await dotenv.load(fileName: ".env"); } catch (e) { debugPrint('⚠️ .env file not found'); }
  try {
    await Supabase.initialize(url: AppConfig.supabaseUrl, anonKey: AppConfig.supabaseAnonKey);
    debugPrint('✅ Supabase initialized');
  } catch (e) { debugPrint('❌ Supabase init failed: $e'); }
  runApp(ChangeNotifierProvider(create: (_) => ThemeManager(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(builder: (context, themeManager, child) {
      return MaterialApp(
        title: 'Flex Yemen',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeManager.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: Builder(builder: (context) { 
          Responsive.init(context); // الآن تم استيرادها بشكل صحيح
          return const SplashScreen(); 
        }),
      );
    });
  }
}
