import '../../domain/models/dua_models.dart';
import '../../domain/models/quran_models.dart';
import '../../domain/models/ritual_models.dart';

/// Offline-first repository for Holy Qur'an Surahs, Reciters, Duas & Athkar,
/// Live Haramain streams, and Ritual / Hajj / Manasik learning content.
class ContentRepository {
  List<Reciter> get reciters => const [
        Reciter(
          id: 'sudais',
          nameEn: 'Abdulrahman Al-Sudais',
          nameAr: 'عبدالرحمن السديس',
          titleEn: 'The Complete Qur’an by Abdulrahman Al-Sudais',
          style: 'Imam of Al-Masjid Al-Haram • Murattal',
          surahCount: 114,
          accentHex: 0xFF0E4D3B,
        ),
        Reciter(
          id: 'hudhaifi',
          nameEn: 'Ali Al-Hudhaifi',
          nameAr: 'علي الحذيفي',
          titleEn: 'The Complete Qur’an by Ali Al-Hudhaifi',
          style: 'Imam of Al-Masjid An-Nabawi • Classical',
          surahCount: 114,
          accentHex: 0xFF7B5E3B,
        ),
        Reciter(
          id: 'muaiqly',
          nameEn: 'Maher Al-Muaiqly',
          nameAr: 'ماهر المعيقلي',
          titleEn: 'The Complete Qur’an by Maher Al-Muaiqly',
          style: 'Imam of Al-Masjid Al-Haram • Melodic',
          surahCount: 114,
          accentHex: 0xFF227862,
        ),
        Reciter(
          id: 'qasim',
          nameEn: 'Abdulmohsen Al-Qasim',
          nameAr: 'عبدالمحسن القاسم',
          titleEn: 'The Complete Qur’an by Abdulmohsen Al-Qasim',
          style: 'Imam of Al-Masjid An-Nabawi • Calm',
          surahCount: 114,
          accentHex: 0xFF8B6936,
        ),
      ];

  List<Surah> get surahs => const [
        Surah(
          number: 1,
          nameArabic: 'الفاتحة',
          nameEnglish: 'Al-Fatihah',
          meaningEnglish: 'The Opening',
          revelationPlace: 'Makkah',
          ayahCount: 7,
          juzNumber: 1,
          ayahs: [
            Ayah(
              surahNumber: 1,
              ayahNumber: 1,
              arabicText: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
              translationEn:
                  'In the name of Allah, the Most Compassionate, Most Merciful.',
              transliteration: 'Bismillahir-Rahmanir-Rahim',
              tafsirNote: 'Every righteous action begins by seeking Allah’s mercy.',
            ),
            Ayah(
              surahNumber: 1,
              ayahNumber: 2,
              arabicText: 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
              translationEn: 'All praise is for Allah—Lord of all worlds,',
              transliteration: 'Al-hamdu lillahi Rabbil-‘alamin',
              tafsirNote: 'Gratitude belongs wholly to the Sustainer of creation.',
            ),
            Ayah(
              surahNumber: 1,
              ayahNumber: 3,
              arabicText: 'الرَّحْمَٰنِ الرَّحِيمِ',
              translationEn: 'the Most Compassionate, Most Merciful,',
              transliteration: 'Ar-Rahmanir-Rahim',
              tafsirNote: 'Mercy encompasses both universal care and believer grace.',
            ),
            Ayah(
              surahNumber: 1,
              ayahNumber: 4,
              arabicText: 'مَالِكِ يَوْمِ الدِّينِ',
              translationEn: 'Master of the Day of Judgment.',
              transliteration: 'Maliki yawmid-din',
              tafsirNote: 'Reminder of accountability and ultimate justice.',
            ),
            Ayah(
              surahNumber: 1,
              ayahNumber: 5,
              arabicText: 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
              translationEn: 'You alone we worship and You alone we ask for help.',
              transliteration: 'Iyyaka na‘budu wa iyyaka nasta‘in',
              tafsirNote: 'Sincere devotion coupled with humble reliance.',
            ),
            Ayah(
              surahNumber: 1,
              ayahNumber: 6,
              arabicText: 'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
              translationEn: 'Guide us along the Straight Path,',
              transliteration: 'Ihdinas-siratal-mustaqim',
              tafsirNote: 'The believer’s daily plea for steadfast clarity.',
            ),
            Ayah(
              surahNumber: 1,
              ayahNumber: 7,
              arabicText:
                  'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
              translationEn:
                  'the Path of those You have blessed—not those You are displeased with, or those who are astray.',
              transliteration:
                  'Siratal-ladhina an‘amta ‘alayhim ghayril-maghdubi ‘alayhim wa lad-dallin',
              tafsirNote: 'Walk in the footsteps of prophets and the righteous.',
            ),
          ],
        ),
        Surah(
          number: 31,
          nameArabic: 'لقمان',
          nameEnglish: 'Luqman',
          meaningEnglish: 'Luqman the Wise',
          revelationPlace: 'Makkah',
          ayahCount: 34,
          juzNumber: 21,
          ayahs: [
            Ayah(
              surahNumber: 31,
              ayahNumber: 13,
              arabicText:
                  'وَإِذْ قَالَ لُقْمَانُ لِابْنِهِ وَهُوَ يَعِظُهُ يَا بُنَيَّ لَا تُشْرِكْ بِاللَّهِ ۖ إِنَّ الشِّرْكَ لَظُلْمٌ عَظِيمٌ',
              translationEn:
                  'And remember when Luqman said to his son, while advising him, "O my dear son! Never associate anything with Allah in worship, for associating others with Him is truly the worst of all wrongs."',
              transliteration:
                  'Wa idh qala Luqmanu libnihi wa huwa ya‘idhuhu ya bunayya la tushrik billah...',
              tafsirNote: 'Wisdom starts with pure Tawhid and gentle parenting.',
            ),
            Ayah(
              surahNumber: 31,
              ayahNumber: 17,
              arabicText:
                  'يَا بُنَيَّ أَقِمِ الصَّلَاةَ وَأْمُرْ بِالْمَعْرُوفِ وَانْهَ عَنِ الْمُنكَرِ وَاصْبِرْ عَلَىٰ مَا أَصَابَكَ',
              translationEn:
                  '"O my dear son! Establish prayer, encourage what is good and forbid what is evil, and endure patiently whatever befalls you."',
              transliteration:
                  'Ya bunayya aqimis-salata wa’mur bil-ma‘rufi wanha ‘anil-munkari wasbir ‘ala ma asabak.',
              tafsirNote: 'Prayer, moral courage, and patience anchor a believer.',
            ),
          ],
        ),
        Surah(
          number: 67,
          nameArabic: 'الملك',
          nameEnglish: 'Al-Mulk',
          meaningEnglish: 'The Sovereignty',
          revelationPlace: 'Makkah',
          ayahCount: 30,
          juzNumber: 29,
          ayahs: [
            Ayah(
              surahNumber: 67,
              ayahNumber: 1,
              arabicText:
                  'تَبَارَكَ الَّذِي بِيَدِهِ الْمُلْكُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
              translationEn:
                  'Blessed is the One in Whose Hands rests all authority. And He is Most Capable of everything.',
              transliteration:
                  'Tabarakal-ladhi biyadihil-mulku wa huwa ‘ala kulli shay’in qadir.',
              tafsirNote: 'Nightly recitation brings comfort and protection.',
            ),
            Ayah(
              surahNumber: 67,
              ayahNumber: 2,
              arabicText:
                  'الَّذِي خَلَقَ الْمَوْتَ وَالْحَيَاةَ لِيَبْلُوَكُمْ أَيُّكُمْ أَحْسَنُ عَمَلًا',
              translationEn:
                  'He is the One Who created death and life in order to test which of you is best in deeds.',
              transliteration:
                  'Alladhi khalaqal-mawta wal-hayata liyabluwakum ayyukum ahsanu ‘amala.',
              tafsirNote: 'Quality of sincerity in deeds outweighs mere quantity.',
            ),
          ],
        ),
        Surah(
          number: 93,
          nameArabic: 'الضحى',
          nameEnglish: 'Ad-Duha',
          meaningEnglish: 'The Morning Brightness',
          revelationPlace: 'Makkah',
          ayahCount: 11,
          juzNumber: 30,
          ayahs: [
            Ayah(
              surahNumber: 93,
              ayahNumber: 1,
              arabicText: 'وَالضُّحَىٰ',
              translationEn: 'By the morning sunlight,',
              transliteration: 'Wad-duha',
              tafsirNote: 'Allah swears by the hopeful light of morning.',
            ),
            Ayah(
              surahNumber: 93,
              ayahNumber: 2,
              arabicText: 'وَاللَّيْلِ إِذَا سَجَىٰ',
              translationEn: 'and the night when it falls still!',
              transliteration: 'Wal-layli idha saja',
              tafsirNote: 'Seasons of stillness precede renewal.',
            ),
            Ayah(
              surahNumber: 93,
              ayahNumber: 3,
              arabicText: 'مَا وَدَّعَكَ رَبُّكَ وَمَا قَلَىٰ',
              translationEn:
                  'Your Lord ˹O Prophet˺ has not abandoned you, nor has He become hateful ˹of you˺.',
              transliteration: 'Ma wadda‘aka Rabbuka wa ma qala',
              tafsirNote: 'Direct reassurance to the grieving heart.',
            ),
            Ayah(
              surahNumber: 93,
              ayahNumber: 4,
              arabicText: 'وَلَلْآخِرَةُ خَيْرٌ لَّكَ مِنَ الْأُولَىٰ',
              translationEn:
                  'And the next life is certainly far better for you than this one.',
              transliteration: 'Wa lal-akhiratu khayrul-laka minal-ula',
              tafsirNote: 'Every next stage of faith rises higher than the last.',
            ),
            Ayah(
              surahNumber: 93,
              ayahNumber: 5,
              arabicText: 'وَلَسَوْفَ يُعْطِيكَ رَبُّكَ فَتَرْضَىٰ',
              translationEn:
                  'And ˹surely˺ your Lord will give so much to you that you will be pleased.',
              transliteration: 'Wa lasawfa yu‘tika Rabbuka fatarda',
              tafsirNote: 'Promise of boundless divine generosity.',
            ),
          ],
        ),
        Surah(
          number: 112,
          nameArabic: 'الإخلاص',
          nameEnglish: 'Al-Ikhlas',
          meaningEnglish: 'Sincerity',
          revelationPlace: 'Makkah',
          ayahCount: 4,
          juzNumber: 30,
          ayahs: [
            Ayah(
              surahNumber: 112,
              ayahNumber: 1,
              arabicText: 'قُلْ هُوَ اللَّهُ أَحَدٌ',
              translationEn: 'Say, "He is Allah—One and Indivisible;',
              transliteration: 'Qul Huwallahu Ahad',
              tafsirNote: 'Pure declaration of Allah’s absolute oneness.',
            ),
            Ayah(
              surahNumber: 112,
              ayahNumber: 2,
              arabicText: 'اللَّهُ الصَّمَدُ',
              translationEn: 'Allah—the Sustainer needed by all.',
              transliteration: 'Allahus-Samad',
              tafsirNote: 'All creation depends upon Him; He depends on none.',
            ),
            Ayah(
              surahNumber: 112,
              ayahNumber: 3,
              arabicText: 'لَمْ يَلِدْ وَلَمْ يُولَدْ',
              translationEn: 'He has never had offspring, nor was He born.',
              transliteration: 'Lam yalid wa lam yulad',
              tafsirNote: 'Transcendent above human lineage or limits.',
            ),
            Ayah(
              surahNumber: 112,
              ayahNumber: 4,
              arabicText: 'وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ',
              translationEn: 'And there is none comparable to Him."',
              transliteration: 'Wa lam yakul-lahu kufuwan ahad',
              tafsirNote: 'Equal in reward to a third of the Qur’an.',
            ),
          ],
        ),
      ];

  Surah getSurahByNumber(int number) {
    return surahs.firstWhere(
      (s) => s.number == number,
      orElse: () => surahs.first,
    );
  }

  List<DuaCategory> get duaCategories => const [
        DuaCategory(
          id: 'morning_evening',
          titleEn: 'Morning & Evening Athkar',
          titleAr: 'أذكار الصباح والمساء',
          subtitleEn: 'Daily shield of remembrance & gratitude',
          iconName: 'wb_twilight',
          accentHex: 0xFF0E4D3B,
        ),
        DuaCategory(
          id: 'tawaf_sai',
          titleEn: 'Umrah, Tawaf & Sa‘i',
          titleAr: 'أدعية العمرة والطواف والسعي',
          subtitleEn: 'Supplications at the House of Allah',
          iconName: 'mosque',
          accentHex: 0xFFC99A3B,
        ),
        DuaCategory(
          id: 'rawdah',
          titleEn: 'Visiting Madinah & Al-Rawdah',
          titleAr: 'أدعية المدينة والروضة',
          subtitleEn: 'Salawat & heartfelt prayers in the Prophet’s Mosque',
          iconName: 'volunteer_activism',
          accentHex: 0xFF217865,
        ),
        DuaCategory(
          id: 'travel',
          titleEn: 'Travel & Safar',
          titleAr: 'أدعية السفر والركوب',
          subtitleEn: 'Blessings for departure, arrival & safe return',
          iconName: 'flight_takeoff',
          accentHex: 0xFF8B6936,
        ),
        DuaCategory(
          id: 'distress',
          titleEn: 'Ease, Healing & Istighfar',
          titleAr: 'الفرج والشفاء والاستغفار',
          subtitleEn: 'Prophetic duas for tranquility and forgiveness',
          iconName: 'spa',
          accentHex: 0xFF6B4C3B,
        ),
      ];

  List<DuaItem> getDuasForCategory(String categoryId) {
    return allDuas.where((d) => d.categoryId == categoryId).toList();
  }

  List<DuaItem> get allDuas => const [
        DuaItem(
          id: 'dua_morning_1',
          categoryId: 'morning_evening',
          titleEn: 'Sayyid al-Istighfar (Master Supplication)',
          titleAr: 'سيد الاستغفار',
          arabicText:
              'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَٰهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَىٰ عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ',
          transliteration:
              'Allahumma Anta Rabbi la ilaha illa Anta, khalaqtani wa ana ‘abduka, wa ana ‘ala ‘ahdika wa wa‘dika mastata‘tu...',
          translationEn:
              'O Allah, You are my Lord, none has the right to be worshipped except You. You created me and I am Your servant, and I abide by Your covenant and promise as best I can.',
          reference: 'Sahih al-Bukhari 6306',
          targetCount: 1,
        ),
        DuaItem(
          id: 'dua_morning_2',
          categoryId: 'morning_evening',
          titleEn: 'Protection & Sufficiency',
          titleAr: 'حسبي الله',
          arabicText:
              'حَسْبِيَ اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ',
          transliteration:
              'HasbiyAllahu la ilaha illa Huwa, ‘alayhi tawakkaltu wa Huwa Rabbul-‘Arshil-‘Adhim.',
          translationEn:
              'Allah is sufficient for me; there is none worthy of worship but Him. Upon Him I rely, and He is the Lord of the Mighty Throne.',
          reference: 'Abu Dawud 5081',
          targetCount: 7,
        ),
        DuaItem(
          id: 'dua_tawaf_1',
          categoryId: 'tawaf_sai',
          titleEn: 'Between Yemeni Corner & Black Stone',
          titleAr: 'بين الركن اليماني والحجر الأسود',
          arabicText:
              'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
          transliteration:
              'Rabbana atina fid-dunya hasanatan wa fil-akhirati hasanatan wa qina ‘adhaban-nar.',
          translationEn:
              'Our Lord, give us in this world that which is good and in the Hereafter that which is good, and protect us from the punishment of the Fire.',
          reference: 'Surah Al-Baqarah 2:201 • Abu Dawud',
          targetCount: 7,
        ),
        DuaItem(
          id: 'dua_tawaf_2',
          categoryId: 'tawaf_sai',
          titleEn: 'At Safa & Marwah',
          titleAr: 'عند الصفا والمروة',
          arabicText:
              'لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
          transliteration:
              'La ilaha illAllahu wahdahu la sharika lah, lahul-mulku wa lahul-hamdu wa Huwa ‘ala kulli shay’in qadir.',
          translationEn:
              'None has the right to be worshipped except Allah alone without partner. To Him belongs all sovereignty and praise, and He is over all things omnipotent.',
          reference: 'Sahih Muslim 1218',
          targetCount: 3,
        ),
        DuaItem(
          id: 'dua_rawdah_1',
          categoryId: 'rawdah',
          titleEn: 'Entering the Mosque',
          titleAr: 'دعاء دخول المسجد',
          arabicText: 'اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ',
          transliteration: 'Allahummaf-tah li abwaba rahmatik.',
          translationEn: 'O Allah, open for me the gates of Your mercy.',
          reference: 'Sahih Muslim 713',
          targetCount: 1,
        ),
        DuaItem(
          id: 'dua_rawdah_2',
          categoryId: 'rawdah',
          titleEn: 'Salawat upon the Prophet ﷺ',
          titleAr: 'الصلاة على النبي ﷺ',
          arabicText:
              'اللَّهُمَّ صَلِّ عَلَىٰ مُحَمَّدٍ وَعَلَىٰ آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَىٰ إِبْرَاهِيمَ وَعَلَىٰ آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ',
          transliteration:
              'Allahumma salli ‘ala Muhammadin wa ‘ala ali Muhammad, kama sallayta ‘ala Ibrahima wa ‘ala ali Ibrahim, innaka Hamidun Majid.',
          translationEn:
              'O Allah, send grace and peace upon Muhammad and his family as You sent grace upon Ibrahim and his family. Indeed You are Praiseworthy, Glorious.',
          reference: 'Sahih al-Bukhari 3370',
          targetCount: 10,
        ),
        DuaItem(
          id: 'dua_travel_1',
          categoryId: 'travel',
          titleEn: 'Setting Out on a Journey',
          titleAr: 'دعاء السفر',
          arabicText:
              'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَٰذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ وَإِنَّا إِلَىٰ رَبِّنَا لَمُنقَلِبُونَ',
          transliteration:
              'Subhanal-ladhi sakh-khara lana hadha wa ma kunna lahu muqrinin, wa inna ila Rabbina lamunqalibun.',
          translationEn:
              'Glory be to Him who has subjected this for us while we could never have controlled it ourselves, and surely to our Lord we shall return.',
          reference: 'Sahih Muslim 1342',
          targetCount: 1,
        ),
        DuaItem(
          id: 'dua_distress_1',
          categoryId: 'distress',
          titleEn: 'Seeking Relief & Steadfastness',
          titleAr: 'دعاء الكرب وتيسير الأمور',
          arabicText:
              'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ أَصْلِحْ لِي شَأْنِي كُلَّهُ وَلَا تَكِلْنِي إِلَىٰ نَفْسِي طَرْفَةَ عَيْنٍ',
          transliteration:
              'Ya Hayyu ya Qayyum, birahmatika astaghith, aslih li sha’ni kullahu wa la takilni ila nafsi tarfata ‘ayn.',
          translationEn:
              'O Ever-Living, O Sustainer, in Your mercy I seek relief. Rectify all of my affairs and do not leave me to myself even for the blink of an eye.',
          reference: 'Al-Mustadrak • Sahih al-Jami',
          targetCount: 3,
        ),
      ];

  List<LiveStreamChannel> get liveChannels => const [
        LiveStreamChannel(
          id: 'makkah_live',
          titleEn: 'Al-Masjid Al-Haram Live & Jumu‘ah Sermon',
          titleAr: 'بث مباشر من المسجد الحرام وخطبة الجمعة',
          mosqueName: 'Makkah Al-Mukarramah',
          isLive: true,
          khutbahSummary:
              'Friday Sermon: Steadfastness upon mercy, unity of hearts, and serving guests of Al-Rahman with humility.',
          audioFallbackDuration: '28:15 Audio & Transcript Ready',
          reciterOrImam: 'Sheikh Dr. Abdulrahman Al-Sudais',
          accentHex: 0xFF176650,
        ),
        LiveStreamChannel(
          id: 'madinah_live',
          titleEn: "Al-Masjid An-Nabawi Live Broadcast",
          titleAr: 'بث مباشر من المسجد النبوي',
          mosqueName: 'Madinah Al-Munawwarah',
          isLive: true,
          khutbahSummary:
              'Live courtyard & Green Dome atmosphere with continuous Qur’an recitation and prayer call audio.',
          audioFallbackDuration: 'Live Audio Channel Ready',
          reciterOrImam: 'Sheikh Dr. Ali Al-Hudhaifi',
          accentHex: 0xFF1F7A60,
        ),
      ];

  List<RitualArticle> get ritualArticles => const [
        RitualArticle(
          id: 'prohibitions_ihram',
          topic: 'Rituals',
          titleEn: 'Prohibitions of Ihram Explained Simply',
          titleAr: 'محظورات الإحرام',
          speakerOrAuthor: 'Sheikh Saad Al-Khathlan',
          durationOrReadTime: '6 min read • Audio',
          mediaKind: 'audio',
          summary:
              'A clear, compassionate breakdown of what is restricted while in Ihram, unintentional mistakes, and practical rulings for pilgrims.',
          keyPoints: [
            'Avoid applying perfume or scented soap after entering Ihram.',
            'Men refrain from stitched/tailored garments and head coverings; women keep normal modest dress without niqab/gloves.',
            'Unintentional acts made out of forgetfulness carry no sin.',
          ],
        ),
        RitualArticle(
          id: 'stoning_jamarat',
          topic: 'Rituals',
          titleEn: 'Stoning the Jamarat: Timing & Etiquette',
          titleAr: 'رمي الجمرات وآدابه',
          speakerOrAuthor: 'Sheikh Saad Al-Khathlan',
          durationOrReadTime: '8 min video summary',
          mediaKind: 'video',
          summary:
              'Practical guidance on pebble collection in Muzdalifah, Jamarat Bridge pathways, and peaceful sunnah timing during Eid and Tashreeq.',
          keyPoints: [
            'Collect seven small chickpea-sized pebbles for Jamarat al-Aqabah.',
            'Say Allahu Akbar with each pebble thrown calmly without pushing.',
            'Pause for dua facing Qibla after the Small and Medium pillars.',
          ],
        ),
        RitualArticle(
          id: 'overview_hajj',
          topic: 'Hajj',
          titleEn: 'An Overview of the Hajj Journey',
          titleAr: 'نظرة شاملة على رحلة الحج',
          speakerOrAuthor: 'Duya Scholarly Desk',
          durationOrReadTime: '7 min read',
          mediaKind: 'article',
          summary:
              'Understand the three types of Hajj (Tamattu‘, Qiran, Ifrad) and the day-by-day arc from 8th to 13th Dhu al-Hijjah.',
          keyPoints: [
            'Day of Tarwiyah (8th): Enter Ihram and settle in Mina.',
            'Day of Arafah (9th): Stand in supplication from Dhuhr until sunset.',
            'Day of Nahr (10th) & Tashreeq (11–13th): Stoning, sacrifice, Tawaf al-Ifadah.',
          ],
        ),
        RitualArticle(
          id: 'conditions_hajj',
          topic: 'Hajj',
          titleEn: 'Conditions & Readiness for Hajj',
          titleAr: 'شروط الحج والاستطاعة',
          speakerOrAuthor: 'Duya Scholarly Desk',
          durationOrReadTime: '5 min read',
          mediaKind: 'article',
          summary:
              'Physical, financial, and spiritual prerequisites that make Hajj obligatory and accepted (Mabrur).',
          keyPoints: [
            'Sincere intention solely for Allah without ostentation.',
            'Lawful provision covering travel and family dependents back home.',
            'Settling debts and seeking reconciliation before departure.',
          ],
        ),
        RitualArticle(
          id: 'manasik_series',
          topic: 'Manasik',
          titleEn: 'Manasik: Days of Tashreeq & Farewell Tawaf',
          titleAr: 'أيام التشريق وطواف الوداع',
          speakerOrAuthor: 'Sheikh Abdulsalam Al-Shuwaier',
          durationOrReadTime: '12 min audio',
          mediaKind: 'audio',
          summary:
              'How to maximize dhikr during the days of Mina and conclude your pilgrimage with Tawaf al-Wada‘.',
          keyPoints: [
            'Engage frequently in Takbir, Tahlil, and gratitude after every prayer.',
            'Perform Tawaf al-Wada‘ as your final act before departing Makkah.',
          ],
        ),
        RitualArticle(
          id: 'short_reflection_1',
          topic: 'Reflections',
          titleEn: 'Pause & Reflect: The Unity of White Garments',
          titleAr: 'تأملات: وحدة الإحرام',
          speakerOrAuthor: 'Duya Reflections',
          durationOrReadTime: '3 min reflection',
          mediaKind: 'article',
          summary:
              'Standing shoulder-to-shoulder at the Kaaba reminds the heart that worldly status dissolves before the Creator.',
          keyPoints: [
            'Carry the humility of Ihram back into everyday patience and kindness.',
          ],
        ),
      ];
}
