# Flex Yemen - منصة التجارة الإلكترونية اليمنية

تطبيق Flex Yemen هو سوق إلكتروني يمني متكامل يجمع بين البيع والشراء، الخدمات المالية، التواصل الفوري، والمزيد.

## الميزات الرئيسية

- **نظام مصادقة كامل**: تسجيل الدخول، إنشاء حساب، استعادة كلمة المرور
- **محفظة إلكترونية متعددة العملات**: ريال يمني، ريال سعودي، دولار أمريكي
- **نظام إعلانات متكامل**: إضافة، عرض، بحث، فلترة
- **نظام مزادات**: مزادات حية مع عداد زمني
- **دردشة فورية**: تواصل بين المشترين والبائعين
- **نظام تقييمات**: تقييم المنتجات والبائعين
- **إشعارات**: إشعارات فورية للطلبات والرسائل
- **خرائط**: عرض المنتجات على الخريطة

## هيكل المشروع

```
lib/
├── main.dart                    # نقطة الدخول الرئيسية
├── models/                      # نماذج البيانات
│   ├── user_model.dart
│   ├── product_model.dart
│   ├── wallet_model.dart
│   ├── rating_model.dart
│   └── message_model.dart
├── providers/                   # إدارة الحالة
│   └── theme_manager.dart
├── services/                    # الخدمات
│   ├── supabase_service.dart
│   ├── location_service.dart
│   └── cache/
│       └── local_storage_service.dart
├── theme/                       # الثيم والتصميم
│   └── app_theme.dart
├── utils/                       # أدوات مساعدة
│   └── responsive.dart
├── widgets/                     # ويدجات مشتركة
│   ├── custom_app_bar.dart
│   ├── custom_button.dart
│   ├── custom_text_field.dart
│   ├── ad_card.dart
│   ├── loading_widget.dart
│   └── empty_state.dart
└── screens/                     # الشاشات
    ├── splash_screen.dart
    ├── login_screen.dart
    ├── register_screen.dart
    ├── main_navigation.dart
    ├── home_screen.dart
    ├── profile_screen.dart
    ├── wallet/
    │   ├── wallet_screen.dart
    │   ├── deposit_screen.dart
    │   ├── withdraw_screen.dart
    │   ├── transfer_screen.dart
    │   └── ... (22 صفحة)
    ├── settings/
    │   ├── settings_screen.dart
    │   └── ... (8 صفحات)
    └── seller/
        └── seller_dashboard.dart
```

## التقنيات المستخدمة

- **Flutter 3.22+**
- **Dart 3.0+**
- **Supabase**: قاعدة البيانات والمصادقة
- **Provider**: إدارة الحالة
- **Hive**: التخزين المحلي
- **flutter_animate**: الرسوم المتحركة
- **carousel_slider**: السلايدر
- **cached_network_image**: تحميل الصور

## التثبيت

1. استنساخ المستودع:
```bash
git clone https://github.com/almwld/Flexy.git
cd Flexy
```

2. تثبيت الاعتماديات:
```bash
flutter pub get
```

3. إعداد ملف `.env`:
```
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
MAP_API_KEY=your-map-key
```

4. تشغيل التطبيق:
```bash
flutter run
```

## البناء

### APK
```bash
flutter build apk --release
```

### App Bundle
```bash
flutter build appbundle --release
```

## المساهمة

نرحب بمساهماتكم! يرجى اتباع الخطوات التالية:

1. عمل Fork للمستودع
2. إنشاء فرع جديد (`git checkout -b feature/amazing-feature`)
3. عمل Commit للتغييرات (`git commit -m 'Add amazing feature'`)
4. رفع الفرع (`git push origin feature/amazing-feature`)
5. فتح Pull Request

## الترخيص

هذا المشروع مرخص تحت رخصة MIT.

## التواصل

- البريد الإلكتروني: support@flexyemen.com
- واتساب: 777-123-456
- تليجرام: @flexyemen

---

**Flex Yemen - منصة التجارة الإلكترونية اليمنية الأولى**
