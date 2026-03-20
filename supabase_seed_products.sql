-- حذف المنتجات القديمة (اختياري)
-- DELETE FROM products;

-- إضافة منتجات إلكترونيات
INSERT INTO products (id, title, description, price, currency, images, category, sub_category, seller_id, in_stock, rating, review_count, created_at, is_featured) VALUES
(gen_random_uuid(), 'آيفون 15 برو ماكس', 'هاتف آيفون 15 برو ماكس - شاشة 6.7 بوصة، كاميرا 48 ميجابكسل، شريحة A17 Pro', 450000, 'YER', ARRAY['https://picsum.photos/id/1/400/400', 'https://picsum.photos/id/2/400/400'], 'إلكترونيات', 'هواتف', (SELECT id FROM profiles LIMIT 1), true, 4.8, 125, NOW(), true),
(gen_random_uuid(), 'سامسونج S24 الترا', 'هاتف سامسونج جالاكسي S24 الترا - شاشة 6.8 بوصة، كاميرا 200 ميجابكسل، قلم S Pen', 380000, 'YER', ARRAY['https://picsum.photos/id/3/400/400', 'https://picsum.photos/id/4/400/400'], 'إلكترونيات', 'هواتف', (SELECT id FROM profiles LIMIT 1), true, 4.7, 98, NOW(), true),
(gen_random_uuid(), 'ماك بوك برو M3', 'لابتوب ماك بوك برو بشريحة M3، 16 جيجا رام، 512 جيجا SSD', 1800000, 'YER', ARRAY['https://picsum.photos/id/5/400/400'], 'إلكترونيات', 'لابتوب', (SELECT id FROM profiles LIMIT 1), true, 4.9, 67, NOW(), false),
(gen_random_uuid(), 'آيباد برو 12.9', 'آيباد برو بشاشة 12.9 بوصة Liquid Retina XDR، شريحة M2', 350000, 'YER', ARRAY['https://picsum.photos/id/6/400/400'], 'إلكترونيات', 'تابلت', (SELECT id FROM profiles LIMIT 1), true, 4.6, 45, NOW(), false),
(gen_random_uuid(), 'ساعة أبل الترا 2', 'ساعة أبل الترا 2 - Titanium Case، GPS + Cellular', 95000, 'YER', ARRAY['https://picsum.photos/id/7/400/400'], 'إلكترونيات', 'ساعات ذكية', (SELECT id FROM profiles LIMIT 1), true, 4.5, 78, NOW(), false),
(gen_random_uuid(), 'سماعات ايربودز برو 2', 'سماعات لاسلكية مع إلغاء الضوضاء النشط، عمر بطارية 30 ساعة', 45000, 'YER', ARRAY['https://picsum.photos/id/8/400/400'], 'إلكترونيات', 'سماعات', (SELECT id FROM profiles LIMIT 1), true, 4.7, 112, NOW(), false),

-- منتجات سيارات
(gen_random_uuid(), 'تويوتا كامري 2024', 'سيارة تويوتا كامري 2024 - مكيف أوتوماتيك، كاميرا خلفية، نظام ملاحة', 8500000, 'YER', ARRAY['https://picsum.photos/id/9/400/400'], 'سيارات', 'سيارات للبيع', (SELECT id FROM profiles LIMIT 1), true, 4.6, 34, NOW(), true),
(gen_random_uuid(), 'هيونداي النترا 2023', 'سيارة هيونداي النترا 2023 - موفرة للوقود، ضمان 5 سنوات', 5500000, 'YER', ARRAY['https://picsum.photos/id/10/400/400'], 'سيارات', 'سيارات للبيع', (SELECT id FROM profiles LIMIT 1), true, 4.4, 23, NOW(), false),
(gen_random_uuid(), 'شاص 2024', 'شاص جيب 2024 - دفع رباعي، جلد، كاميرا خلفية', 12500000, 'YER', ARRAY['https://picsum.photos/id/11/400/400'], 'سيارات', 'سيارات للبيع', (SELECT id FROM profiles LIMIT 1), true, 4.8, 56, NOW(), true),

-- منتجات عقارات
(gen_random_uuid(), 'شقة في حدة - صنعاء', 'شقة 3 غرف نوم، 2 حمام، صالة كبيرة، موقع مميز في حدة', 35000000, 'YER', ARRAY['https://picsum.photos/id/12/400/400', 'https://picsum.photos/id/13/400/400'], 'عقارات', 'شقق للبيع', (SELECT id FROM profiles LIMIT 1), true, 4.5, 12, NOW(), true),
(gen_random_uuid(), 'فيلا في المكلا', 'فيلا فاخرة 5 غرف، حديقة كبيرة، مسبح، إطلالة بحرية', 65000000, 'YER', ARRAY['https://picsum.photos/id/14/400/400'], 'عقارات', 'فلل', (SELECT id FROM profiles LIMIT 1), true, 4.9, 8, NOW(), false),

-- منتجات أثاث
(gen_random_uuid(), 'غرفة نوم كاملة', 'غرفة نوم خشب زان - سرير 160 سم، دولاب، تسريحة، كومودينو', 650000, 'YER', ARRAY['https://picsum.photos/id/15/400/400'], 'أثاث', 'غرف نوم', (SELECT id FROM profiles LIMIT 1), true, 4.3, 45, NOW(), false),
(gen_random_uuid(), 'مجلس عربي فاخر', 'مجلس عربي كامل - جلسات أرضية، طاولات، ستائر', 450000, 'YER', ARRAY['https://picsum.photos/id/16/400/400'], 'أثاث', 'مجالس', (SELECT id FROM profiles LIMIT 1), true, 4.7, 32, NOW(), false),

-- منتجات ملابس
(gen_random_uuid(), 'ثوب رجالي يمني', 'ثوب يمني تقليدي - قطن 100%، مقاسات مختلفة', 15000, 'YER', ARRAY['https://picsum.photos/id/17/400/400'], 'ملابس', 'رجالي', (SELECT id FROM profiles LIMIT 1), true, 4.6, 78, NOW(), false),
(gen_random_uuid(), 'عباية نسائية فاخرة', 'عباية سوداء بتطريز ذهبي، خامات عالية الجودة', 25000, 'YER', ARRAY['https://picsum.photos/id/18/400/400'], 'ملابس', 'نسائي', (SELECT id FROM profiles LIMIT 1), true, 4.8, 56, NOW(), false),

-- منتجات مطاعم
(gen_random_uuid(), 'وجبة مندي دجاج', 'مندي دجاج مع أرز بسمتي، صلصة، سلطة (تكفي 4 أشخاص)', 8000, 'YER', ARRAY['https://picsum.photos/id/19/400/400'], 'مطاعم', 'وجبات رئيسية', (SELECT id FROM profiles LIMIT 1), true, 4.9, 234, NOW(), true),
(gen_random_uuid(), 'وجبة زربيان لحم', 'زربيان لحم مع أرز، مكسرات، زبيب (تكفي 4 أشخاص)', 12000, 'YER', ARRAY['https://picsum.photos/id/20/400/400'], 'مطاعم', 'وجبات رئيسية', (SELECT id FROM profiles LIMIT 1), true, 4.7, 189, NOW(), false),

-- منتجات خدمات
(gen_random_uuid(), 'صيانة مكيفات', 'خدمة صيانة وتبريد مكيفات - فحص وتعبئة غاز وتنظيف', 5000, 'YER', ARRAY['https://picsum.photos/id/21/400/400'], 'خدمات', 'صيانة', (SELECT id FROM profiles LIMIT 1), true, 4.5, 45, NOW(), false),
(gen_random_uuid(), 'تنظيف منازل', 'خدمة تنظيف منازل شاملة - 4 عمال + معدات', 8000, 'YER', ARRAY['https://picsum.photos/id/22/400/400'], 'خدمات', 'تنظيف', (SELECT id FROM profiles LIMIT 1), true, 4.3, 67, NOW(), false),

-- منتجات ألعاب
(gen_random_uuid(), 'بلاي ستيشن 5', 'جهاز بلاي ستيشن 5 - نسخة ديجيتال + يد تحكم DualSense', 250000, 'YER', ARRAY['https://picsum.photos/id/23/400/400'], 'ألعاب', 'أجهزة ألعاب', (SELECT id FROM profiles LIMIT 1), true, 4.9, 156, NOW(), true);

-- عرض عدد المنتجات المضافة
SELECT COUNT(*) AS products_added FROM products;
