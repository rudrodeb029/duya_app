import '../../domain/models/challenge_models.dart';

/// Complete 160-question Knowledge Challenge bank (20 questions for each of the
/// 8 Duya Doors), all centered on Duya's spiritual & pilgrimage purpose.
///
/// [ChallengeRepository] rotates each door's question daily across its 20
/// entries so every day surfaces a fresh question per door.
const List<QuizQuestion> challengeQuestionBank = [
  ..._prophetQuestions,
  ..._quranQuestions,
  ..._makkahQuestions,
  ..._madinahQuestions,
  ..._umrahQuestions,
  ..._hajjQuestions,
  ..._prayerQuestions,
  ..._duasQuestions,
];

const List<QuizQuestion> _prophetQuestions = [
  QuizQuestion(
    id: 'q_prophet_01',
    doorId: 'prophet',
    questionEn:
        'Which title did the people of Makkah famously give Prophet Muhammad ﷺ even before prophethood?',
    optionsEn: ['Al-Sadiq Al-Amin', 'Al-Faruq', 'Dhun-Nurayn', 'Sayfullah'],
    correctIndex: 0,
    explanationEn:
        'He ﷺ was universally trusted as Al-Sadiq Al-Amin (The Truthful, The Trustworthy).',
    reference: 'Seerah Ibn Hisham',
  ),
  QuizQuestion(
    id: 'q_prophet_02',
    doorId: 'prophet',
    questionEn:
        'In which Islamic lunar month was Prophet Muhammad ﷺ born in Makkah?',
    optionsEn: ['Muharram', 'Rabi‘ al-Awwal', 'Rajab', 'Shawwal'],
    correctIndex: 1,
    explanationEn:
        'Historical consensus places the blessed birth of the Prophet ﷺ in the month of Rabi‘ al-Awwal.',
    reference: 'Al-Raheeq Al-Makhtum',
  ),
  QuizQuestion(
    id: 'q_prophet_03',
    doorId: 'prophet',
    questionEn:
        'Who was the noble foster mother from Banu Sa‘d who nursed the Prophet ﷺ in early childhood?',
    optionsEn: ['Umm Ayman', 'Fatimah bint Asad', 'Halimah al-Sa‘diyyah', 'Thuwaybah'],
    correctIndex: 2,
    explanationEn:
        'Halimah al-Sa‘diyyah cared for the young Prophet ﷺ in the desert of Banu Sa‘d, witnessing many blessings.',
    reference: 'Seerah Ibn Hisham',
  ),
  QuizQuestion(
    id: 'q_prophet_04',
    doorId: 'prophet',
    questionEn:
        'At what age did Prophet Muhammad ﷺ receive the first Qur’anic revelation in Cave Hira?',
    optionsEn: ['33 years old', '40 years old', '45 years old', '50 years old'],
    correctIndex: 1,
    explanationEn:
        'Prophethood began at age 40 when Angel Jibril brought the opening verses of Surah Al-‘Alaq.',
    reference: 'Sahih al-Bukhari 3',
  ),
  QuizQuestion(
    id: 'q_prophet_05',
    doorId: 'prophet',
    questionEn:
        'Upon which mountain overlooking Makkah is Cave Hira (Ghar Hira) located?',
    optionsEn: ['Jabal al-Nour', 'Jabal Uhud', 'Jabal Thawr', 'Jabal Arafah'],
    correctIndex: 0,
    explanationEn:
        'Ghar Hira sits near the summit of Jabal al-Nour (Mountain of Light), northeast of the Kaaba.',
    reference: 'Makkah Heritage Atlas',
  ),
  QuizQuestion(
    id: 'q_prophet_06',
    doorId: 'prophet',
    questionEn:
        'Which companion’s house near Safa served as the discreet early learning center in Makkah?',
    optionsEn: ['Dar al-Nadwah', 'Bayt al-Hikmah', 'Dar Abu Talib', 'Dar al-Arqam'],
    correctIndex: 3,
    explanationEn:
        'Dar al-Arqam ibn Abi al-Arqam hosted early Muslims to recite revelation and learn Salah peacefully.',
    reference: 'Al-Tabaqat al-Kubra',
  ),
  QuizQuestion(
    id: 'q_prophet_07',
    doorId: 'prophet',
    questionEn:
        'Inside which cave south of Makkah did the Prophet ﷺ and Abu Bakr shelter during the Hijrah?',
    optionsEn: ['Cave Hira', 'Cave Thawr', 'Cave al-Kahf', 'Cave Safa'],
    correctIndex: 1,
    explanationEn:
        'For three nights during the Hijrah to Madinah, Allah protected them inside Cave Thawr (Surah 9:40).',
    reference: 'Surah At-Tawbah 9:40',
  ),
  QuizQuestion(
    id: 'q_prophet_08',
    doorId: 'prophet',
    questionEn:
        'What was the name of the Prophet’s ﷺ camel that knelt where Al-Masjid an-Nabawi was built?',
    optionsEn: ['Al-Adba', 'Ya‘fur', 'Al-Qaswa', 'Duldul'],
    correctIndex: 2,
    explanationEn:
        'Guided by Allah’s decree, Al-Qaswa knelt in the open date-drying courtyard of Sahl and Suhayl in Madinah.',
    reference: 'Sahih al-Bukhari 3906',
  ),
  QuizQuestion(
    id: 'q_prophet_09',
    doorId: 'prophet',
    questionEn:
        'Which Ansar companion’s home warmly hosted the Prophet ﷺ right after his arrival in Madinah?',
    optionsEn: [
      'Abu Ayyub al-Ansari',
      'Sa‘d ibn Mu‘adh',
      'Mus‘ab ibn Umayr',
      'Salman al-Farsi',
    ],
    correctIndex: 0,
    explanationEn:
        'Abu Ayyub al-Ansari hosted the Prophet ﷺ for roughly seven months until Al-Masjid an-Nabawi was built.',
    reference: 'Sahih Muslim 2053',
  ),
  QuizQuestion(
    id: 'q_prophet_10',
    doorId: 'prophet',
    questionEn:
        'Between which two groups did the Prophet ﷺ establish the historic bond of brotherhood in Madinah?',
    optionsEn: [
      'Quraysh and Thaqif',
      'Aws and Khazraj only',
      'Tabuk and Khaybar tribes',
      'Muhajirun and Ansar',
    ],
    correctIndex: 3,
    explanationEn:
        'Every emigrant from Makkah (Muhajir) was paired in spiritual brotherhood with a host in Madinah (Ansar).',
    reference: 'Sahih al-Bukhari 2049',
  ),
  QuizQuestion(
    id: 'q_prophet_11',
    doorId: 'prophet',
    questionEn:
        'Who was the first person to believe in Prophet Muhammad’s ﷺ message and console him after Hira?',
    optionsEn: [
      'Ali ibn Abi Talib',
      'Khadijah bint Khuwaylid',
      'Zayd ibn Harithah',
      'Fatimah al-Zahra',
    ],
    correctIndex: 1,
    explanationEn:
        'Sayyidah Khadijah (RA) comforted the Prophet ﷺ immediately and stood beside him through every hardship.',
    reference: 'Sahih al-Bukhari 3',
  ),
  QuizQuestion(
    id: 'q_prophet_12',
    doorId: 'prophet',
    questionEn:
        'Which Makkah elder named him Muhammad, wishing his grandson be praised in heaven and earth?',
    optionsEn: ['Abdul-Muttalib', 'Abu Talib', 'Al-Abbas', 'Hamzah'],
    correctIndex: 0,
    explanationEn:
        'His grandfather Abdul-Muttalib carried him to the Kaaba and named him Muhammad (“The Praised One”).',
    reference: 'Seerah Ibn Hisham',
  ),
  QuizQuestion(
    id: 'q_prophet_13',
    doorId: 'prophet',
    questionEn:
        'Which landmark 6 AH agreement paved the way for peaceful pilgrimage and widespread embrace of Islam?',
    optionsEn: [
      'Pledge of Aqabah',
      'Battle of Badr',
      'Treaty of Hudaybiyyah',
      'Expedition of Tabuk',
    ],
    correctIndex: 2,
    explanationEn:
        'Surah Al-Fath calls Hudaybiyyah a “Clear Victory” because peace allowed Islam to spread peacefully.',
    reference: 'Sahih al-Bukhari 2731',
  ),
  QuizQuestion(
    id: 'q_prophet_14',
    doorId: 'prophet',
    questionEn:
        'In which Gregorian year did the Hijrah to Madinah—marking Year 1 AH—take place?',
    optionsEn: ['610 CE', '622 CE', '630 CE', '632 CE'],
    correctIndex: 1,
    explanationEn:
        'The migration from Makkah to Madinah occurred in 622 CE, establishing the Islamic Hijri era.',
    reference: 'Sahih al-Bukhari 3934',
  ),
  QuizQuestion(
    id: 'q_prophet_15',
    doorId: 'prophet',
    questionEn:
        'In which Hijri year did the peaceful Conquest of Makkah (Fath Makkah) occur?',
    optionsEn: ['5 AH', '6 AH', '8 AH', '10 AH'],
    correctIndex: 2,
    explanationEn:
        'In Ramadan 8 AH, the Prophet ﷺ entered Makkah with humility and pardoned its people.',
    reference: 'Sahih al-Bukhari 4280',
  ),
  QuizQuestion(
    id: 'q_prophet_16',
    doorId: 'prophet',
    questionEn:
        'How many times did Prophet Muhammad ﷺ perform Hajj after migrating to Madinah?',
    optionsEn: [
      'Once (Hajjat al-Wada‘)',
      'Twice',
      'Three times',
      'Seven times',
    ],
    correctIndex: 0,
    explanationEn:
        'He ﷺ performed one Farewell Hajj in 10 AH, teaching the entire ummah its rites step by step.',
    reference: 'Sahih Muslim 1218',
  ),
  QuizQuestion(
    id: 'q_prophet_17',
    doorId: 'prophet',
    questionEn:
        'How many times did Prophet Muhammad ﷺ perform Umrah after the Hijrah?',
    optionsEn: ['Once', 'Twice', 'Three times', 'Four times'],
    correctIndex: 3,
    explanationEn:
        'Authentic reports mention four Umrahs: Hudaybiyyah, Umrat al-Qada, Ji‘ranah, and the Umrah alongside his Hajj.',
    reference: 'Sahih al-Bukhari 1775',
  ),
  QuizQuestion(
    id: 'q_prophet_18',
    doorId: 'prophet',
    questionEn:
        'During the Farewell Sermon at Arafah, what two weighty anchors did the Prophet ﷺ remind believers to hold fast to?',
    optionsEn: [
      'Wealth and lineage',
      'The Book of Allah and his Prophetic guidance',
      'Fasting Monday and Thursday',
      'Building forts and walls',
    ],
    correctIndex: 1,
    explanationEn:
        'He ﷺ affirmed the Qur’an and his Sunnah as the clear source of guidance so believers never go astray.',
    reference: 'Sahih Muslim 1218',
  ),
  QuizQuestion(
    id: 'q_prophet_19',
    doorId: 'prophet',
    questionEn:
        'Who beautifully summarized Prophet Muhammad’s ﷺ daily conduct by saying, “His character was the Qur’an”?',
    optionsEn: [
      'Abu Bakr al-Siddiq',
      'Umar ibn al-Khattab',
      'Aishah bint Abi Bakr',
      'Anas ibn Malik',
    ],
    correctIndex: 2,
    explanationEn:
        'Mother of the Believers Aishah (RA) taught that his ﷺ character embodied every mercy and ethic of the Qur’an.',
    reference: 'Sahih Muslim 746',
  ),
  QuizQuestion(
    id: 'q_prophet_20',
    doorId: 'prophet',
    questionEn:
        'What spiritual greeting is especially multiplied on Fridays and when visiting Madinah?',
    optionsEn: [
      'Sending Salawat upon the Prophet ﷺ',
      'Silent fasting only',
      'Reciting poetry',
      'Sleeping at noon',
    ],
    correctIndex: 0,
    explanationEn:
        'Allah commands believers in Surah Al-Ahzab (33:56) to send blessings and peace (Salawat) upon the Prophet ﷺ.',
    reference: 'Surah Al-Ahzab 33:56',
  ),
];

const List<QuizQuestion> _quranQuestions = [
  QuizQuestion(
    id: 'q_quran_01',
    doorId: 'quran',
    questionEn:
        'Which surah of the Qur’an affirms Mount Safa and Mount Marwah among the symbols (Sha‘a’ir) of Allah during Umrah and Hajj?',
    optionsEn: [
      'Surah Al-Baqarah',
      'Surah Al-Isra',
      'Surah Al-Hujurat',
      'Surah Luqman',
    ],
    correctIndex: 0,
    explanationEn:
        'Surah Al-Baqarah (2:158) honors Al-Safa and Al-Marwah as symbols of Allah visited by pilgrims performing Sa‘i.',
    reference: 'Surah Al-Baqarah 2:158',
  ),
  QuizQuestion(
    id: 'q_quran_02',
    doorId: 'quran',
    questionEn: 'How many total Surahs (chapters) comprise the Noble Qur’an?',
    optionsEn: ['99 Surahs', '110 Surahs', '114 Surahs', '120 Surahs'],
    correctIndex: 2,
    explanationEn:
        'The Noble Qur’an contains 114 Surahs beginning with Al-Fatihah and concluding with An-Nas.',
    reference: 'Qur’an Mushaf Standard',
  ),
  QuizQuestion(
    id: 'q_quran_03',
    doorId: 'quran',
    questionEn:
        'Which Surah—called Umm al-Kitab—is recited in every unit (rak‘ah) of daily Salah?',
    optionsEn: [
      'Surah Al-Fatihah',
      'Surah Al-Ikhlas',
      'Surah Al-Asr',
      'Surah Al-Kafirun',
    ],
    correctIndex: 0,
    explanationEn:
        'No prayer is complete without Surah Al-Fatihah, the seven oft-repeated verses of praise and supplication.',
    reference: 'Sahih al-Bukhari 756',
  ),
  QuizQuestion(
    id: 'q_quran_04',
    doorId: 'quran',
    questionEn:
        'Which Surah of the Qur’an is dedicated by name to the fifth pillar of Islam, the Pilgrimage?',
    optionsEn: ['Surah Al-Umrah', 'Surah Al-Hajj', 'Surah Al-Hijr', 'Surah Al-Balad'],
    correctIndex: 1,
    explanationEn:
        'Surah Al-Hajj (Chapter 22) recalls Allah’s call to Ibrahim (AS) to proclaim Hajj so pilgrims arrive from every distant pass.',
    reference: 'Surah Al-Hajj 22:27',
  ),
  QuizQuestion(
    id: 'q_quran_05',
    doorId: 'quran',
    questionEn:
        'Which greatest verse of the Qur’an—recited after every obligatory prayer—is in Surah Al-Baqarah (2:255)?',
    optionsEn: ['Ayat al-Nur', 'Ayat al-Dayn', 'Ayat al-Birr', 'Ayat al-Kursi'],
    correctIndex: 3,
    explanationEn:
        'Reciting Ayat al-Kursi after each obligatory prayer is a treasured Sunnah taught by the Prophet ﷺ.',
    reference: 'Sunan al-Nasa’i al-Kubra 9928',
  ),
  QuizQuestion(
    id: 'q_quran_06',
    doorId: 'quran',
    questionEn: 'Which is the shortest Surah in the Noble Qur’an (three verses)?',
    optionsEn: ['Surah Al-Asr', 'Surah Al-Kawthar', 'Surah An-Nasr', 'Surah Al-Ikhlas'],
    correctIndex: 1,
    explanationEn:
        'Surah Al-Kawthar (Chapter 108) promises the Prophet ﷺ Al-Kawthar, the abundant river of Paradise.',
    reference: 'Surah Al-Kawthar 108:1–3',
  ),
  QuizQuestion(
    id: 'q_quran_07',
    doorId: 'quran',
    questionEn: 'Which is the longest Surah in the Noble Qur’an (286 verses)?',
    optionsEn: [
      'Surah Al-Baqarah',
      'Surah Al-Imran',
      'Surah An-Nisa',
      'Surah Al-A‘raf',
    ],
    correctIndex: 0,
    explanationEn:
        'Surah Al-Baqarah spans 286 verses, covering prayer, fasting, Hajj laws, charity, and steadfast faith.',
    reference: 'Surah Al-Baqarah 2',
  ),
  QuizQuestion(
    id: 'q_quran_08',
    doorId: 'quran',
    questionEn: 'What was the very first command revealed in Surah Al-‘Alaq?',
    optionsEn: ['Pray (Salli)', 'Fast (Sum)', 'Read (Iqra)', 'Give (Ati)'],
    correctIndex: 2,
    explanationEn:
        'The opening word “Iqra!” (Read in the name of your Lord) elevated sacred knowledge (Ilm) at the heart of Islam.',
    reference: 'Surah Al-‘Alaq 96:1',
  ),
  QuizQuestion(
    id: 'q_quran_09',
    doorId: 'quran',
    questionEn:
        'Upon which blessed night of Ramadan did the revelation of the Qur’an begin?',
    optionsEn: [
      'Laylat al-Miraj',
      'Laylat al-Qadr',
      'Day of Ashura',
      'Mid-Sha‘ban',
    ],
    correctIndex: 1,
    explanationEn:
        'Surah Al-Qadr states that the Night of Decree is better than a thousand months of worship.',
    reference: 'Surah Al-Qadr 97:1–3',
  ),
  QuizQuestion(
    id: 'q_quran_10',
    doorId: 'quran',
    questionEn:
        'Reciting which Surah every Friday illuminates the believer with light between the two Fridays?',
    optionsEn: ['Surah Al-Kahf', 'Surah Al-Mulk', 'Surah Ar-Rahman', 'Surah Al-Waqi‘ah'],
    correctIndex: 0,
    explanationEn:
        'Weekly Friday recitation of Surah Al-Kahf is a beloved Sunnah featured in Duya’s Content Hub.',
    reference: 'Al-Mustadrak al-Hakim 3392',
  ),
  QuizQuestion(
    id: 'q_quran_11',
    doorId: 'quran',
    questionEn:
        'Which noble angel delivered Allah’s revelation of the Qur’an to Prophet Muhammad ﷺ?',
    optionsEn: ['Angel Mikail', 'Angel Israfil', 'Angel Malik', 'Angel Jibril'],
    correctIndex: 3,
    explanationEn:
        'Ruh al-Amin (Angel Jibril) descended with the Qur’an upon the Prophet’s ﷺ heart in clear Arabic.',
    reference: 'Surah Ash-Shu‘ara 26:193–195',
  ),
  QuizQuestion(
    id: 'q_quran_12',
    doorId: 'quran',
    questionEn: 'Which Surah in the Qur’an does NOT begin with Bismillah al-Rahman al-Rahim?',
    optionsEn: ['Surah Al-Anfal', 'Surah At-Tawbah', 'Surah Yunus', 'Surah Muhammad'],
    correctIndex: 1,
    explanationEn:
        'Surah At-Tawbah (Chapter 9) uniquely opens directly without Bismillah at its start.',
    reference: 'Qur’an Chapter 9',
  ),
  QuizQuestion(
    id: 'q_quran_13',
    doorId: 'quran',
    questionEn:
        'Which Surah contains two mentions of Bismillah al-Rahman al-Rahim—at the start and in Prophet Sulayman’s letter?',
    optionsEn: ['Surah An-Naml', 'Surah An-Nahl', 'Surah Saba', 'Surah Al-Anbiya'],
    correctIndex: 0,
    explanationEn:
        'Surah An-Naml (27:30) quotes Sulayman’s (AS) letter beginning “In the name of Allah, Most Compassionate, Most Merciful.”',
    reference: 'Surah An-Naml 27:30',
  ),
  QuizQuestion(
    id: 'q_quran_14',
    doorId: 'quran',
    questionEn:
        'Which Prophet raised the foundations of the Kaaba with his son Isma‘il (AS) while praying in Surah Al-Baqarah?',
    optionsEn: [
      'Prophet Musa (AS)',
      'Prophet Nuh (AS)',
      'Prophet Ibrahim (AS)',
      'Prophet Isa (AS)',
    ],
    correctIndex: 2,
    explanationEn:
        'Surah Al-Baqarah (2:127) records Ibrahim and Isma‘il raising the House while supplicating: “Our Lord, accept from us!”',
    reference: 'Surah Al-Baqarah 2:127',
  ),
  QuizQuestion(
    id: 'q_quran_15',
    doorId: 'quran',
    questionEn:
        'According to Sahih Hadith, which Surah equals one-third of the Qur’an in spiritual reward?',
    optionsEn: [
      'Surah Al-Kafirun',
      'Surah Al-Ikhlas',
      'Surah Al-Zalzalah',
      'Surah Al-Masad',
    ],
    correctIndex: 1,
    explanationEn:
        'Surah Al-Ikhlas affirms the pure Oneness (Tawhid) of Allah, carrying the reward of one-third of the Qur’an.',
    reference: 'Sahih al-Bukhari 5013',
  ),
  QuizQuestion(
    id: 'q_quran_16',
    doorId: 'quran',
    questionEn: 'Which Surah closes the Qur’an as Chapter 114?',
    optionsEn: ['Surah Al-Falaq', 'Surah Al-Ikhlas', 'Surah Al-Masad', 'Surah An-Nas'],
    correctIndex: 3,
    explanationEn:
        'Surah An-Nas (Chapter 114) closes the Mushaf with a prayer seeking refuge in the Lord of humankind.',
    reference: 'Surah An-Nas 114',
  ),
  QuizQuestion(
    id: 'q_quran_17',
    doorId: 'quran',
    questionEn:
        'Which two final protective Surahs are known together as Al-Mu‘awwidhatayn?',
    optionsEn: [
      'Al-Falaq & An-Nas',
      'Al-Ikhlas & Al-Kafirun',
      'Al-Fil & Quraysh',
      'Al-Qadr & Al-Bayyinah',
    ],
    correctIndex: 0,
    explanationEn:
        'The Prophet ﷺ recited Al-Falaq and An-Nas (alongside Al-Ikhlas) every night before sleep and after every prayer.',
    reference: 'Sahih al-Bukhari 5017',
  ),
  QuizQuestion(
    id: 'q_quran_18',
    doorId: 'quran',
    questionEn:
        'Into how many equal reading sections (Juz’) is the Qur’an divided for a 30-day Khatmah plan?',
    optionsEn: ['10 Juz’', '20 Juz’', '30 Juz’', '40 Juz’'],
    correctIndex: 2,
    explanationEn:
        'The 30 Juz’ divisions help readers comfortably complete the entire Qur’an in a lunar month like Ramadan.',
    reference: 'Qur’an Reading Tradition',
  ),
  QuizQuestion(
    id: 'q_quran_19',
    doorId: 'quran',
    questionEn:
        'Which 30-verse Surah did the Prophet ﷺ recommend reciting every night as an intercessor and protector?',
    optionsEn: ['Surah Qaf', 'Surah Al-Mulk', 'Surah Al-Muzzammil', 'Surah Nuh'],
    correctIndex: 1,
    explanationEn:
        'Surah Al-Mulk (Chapter 67) consists of 30 verses and intercedes for its constant companion.',
    reference: 'Sunan al-Tirmidhi 2891',
  ),
  QuizQuestion(
    id: 'q_quran_20',
    doorId: 'quran',
    questionEn:
        'In Surah Al-Baqarah (2:197), what is described as the very best provision (Zad) for any pilgrim journeying to Hajj?',
    optionsEn: [
      'Gold coins',
      'Silk garments',
      'Fear-awareness of Allah (Taqwa)',
      'Fast mounts',
    ],
    correctIndex: 2,
    explanationEn:
        'Allah reminds pilgrims: “Take provisions, and indeed the best provision is Taqwa (God-consciousness).”',
    reference: 'Surah Al-Baqarah 2:197',
  ),
];

const List<QuizQuestion> _makkahQuestions = [
  QuizQuestion(
    id: 'q_makkah_01',
    doorId: 'makkah',
    questionEn:
        'Inside Al-Masjid al-Haram, which corner of the Holy Kaaba marks the start and end of each Tawaf circuit?',
    optionsEn: [
      'Al-Hajar al-Aswad (Black Stone)',
      'Rukn al-Yamani',
      'Bab al-Safa',
      'Maqam Ibrahim',
    ],
    correctIndex: 0,
    explanationEn:
        'Pilgrims begin and complete each of the seven anti-clockwise Tawaf circuits aligned with Al-Hajar al-Aswad.',
    reference: 'Sahih al-Bukhari 1603',
  ),
  QuizQuestion(
    id: 'q_makkah_02',
    doorId: 'makkah',
    questionEn: 'How many anti-clockwise circuits around the Kaaba constitute one complete Tawaf?',
    optionsEn: ['3 circuits', '5 circuits', '7 circuits', '9 circuits'],
    correctIndex: 2,
    explanationEn:
        'Every Tawaf—whether for Umrah, Hajj, or voluntary worship—consists of seven complete circuits.',
    reference: 'Sahih al-Bukhari 1617',
  ),
  QuizQuestion(
    id: 'q_makkah_03',
    doorId: 'makkah',
    questionEn:
        'Behind which historic landmark inside Al-Masjid al-Haram is it Sunnah to pray two rak‘ahs immediately after Tawaf?',
    optionsEn: ['Zamzam well', 'Maqam Ibrahim', 'Mount Marwah', 'Bab al-Umrah'],
    correctIndex: 1,
    explanationEn:
        'Fulfilling Surah Al-Baqarah (2:125), pilgrims pray two units behind Maqam Ibrahim facing the Kaaba.',
    reference: 'Surah Al-Baqarah 2:125',
  ),
  QuizQuestion(
    id: 'q_makkah_04',
    doorId: 'makkah',
    questionEn:
        'During Tawaf, pilgrims walk around the outside of the semi-circular low wall adjoining the Kaaba because it was once part of the House. What is it called?',
    optionsEn: [
      'Hijr Ismail (Al-Hatim)',
      'Al-Multazam',
      'Shadhirwan',
      'Rukn al-Shami',
    ],
    correctIndex: 0,
    explanationEn:
        'Walking outside Hijr Ismail (Al-Hatim) ensures your Tawaf completely encompasses the original foundation of the Kaaba.',
    reference: 'Sahih al-Bukhari 1584',
  ),
  QuizQuestion(
    id: 'q_makkah_05',
    doorId: 'makkah',
    questionEn:
        'What is the golden rainwater spout atop the Kaaba roof overlooking Hijr Ismail called?',
    optionsEn: [
      'Mizab al-Haram',
      'Al-Rukn',
      'Al-Shadhirwan',
      'Mizab al-Rahmah',
    ],
    correctIndex: 3,
    explanationEn:
        'Mizab al-Rahmah (“Spout of Mercy”) channels rainwater from the Kaaba roof into the area of Hijr Ismail.',
    reference: 'Al-Haram Architectural Heritage',
  ),
  QuizQuestion(
    id: 'q_makkah_06',
    doorId: 'makkah',
    questionEn:
        'What is the traditional black cloth embroidered with golden Qur’anic calligraphy draping the Kaaba?',
    optionsEn: ['Izar', 'Kiswah', 'Rida', 'Riqab'],
    correctIndex: 1,
    explanationEn:
        'The Kiswah is woven in Makkah with pure silk and gold-plated silver thread bearing sacred verses.',
    reference: 'King Abdulaziz Complex for Holy Kaaba Kiswah',
  ),
  QuizQuestion(
    id: 'q_makkah_07',
    doorId: 'makkah',
    questionEn:
        'Which blessed water source near the Kaaba miraculously sprang forth for Hajar and infant Isma‘il (AS)?',
    optionsEn: [
      'Ayn Zubaydah',
      'Al-Kawthar',
      'Well of Zamzam',
      'Spring of Arafah',
    ],
    correctIndex: 2,
    explanationEn:
        'Zamzam continues to flow abundantly inside Al-Masjid al-Haram millennia later, quenching millions of pilgrims.',
    reference: 'Sahih al-Bukhari 3364',
  ),
  QuizQuestion(
    id: 'q_makkah_08',
    doorId: 'makkah',
    questionEn:
        'Whose faithful perseverance while searching for water for her infant is honored by every pilgrim during Sa‘i?',
    optionsEn: [
      'Sayyidah Hajar',
      'Sayyidah Sarah',
      'Sayyidah Maryam',
      'Sayyidah Asiyah',
    ],
    correctIndex: 0,
    explanationEn:
        'Sayyidah Hajar’s trust in Allah while running seven times between Safa and Marwah became a timeless pillar of pilgrimage.',
    reference: 'Sahih al-Bukhari 3364',
  ),
  QuizQuestion(
    id: 'q_makkah_09',
    doorId: 'makkah',
    questionEn:
        'Which Kaaba corner just before the Black Stone did the Prophet ﷺ touch gently as he passed in Tawaf?',
    optionsEn: [
      'Iraqi Corner',
      'Levantine Corner',
      'Rukn al-Yamani (Yemeni Corner)',
      'Marwah Gate',
    ],
    correctIndex: 2,
    explanationEn:
        'Between Rukn al-Yamani and the Black Stone, it is Sunnah to recite “Rabbana atina fid-dunya hasanah...”',
    reference: 'Sunan Abi Dawud 1892',
  ),
  QuizQuestion(
    id: 'q_makkah_10',
    doorId: 'makkah',
    questionEn:
        'What is the cherished section of the Kaaba wall lying directly between the Black Stone and the Kaaba Door?',
    optionsEn: ['Al-Hatim', 'Al-Multazam', 'Al-Mataf', 'Al-Mas‘a'],
    correctIndex: 1,
    explanationEn:
        'Al-Multazam is a place where the Prophet ﷺ pressed against the wall in heartfelt supplication.',
    reference: 'Sunan Abi Dawud 1899',
  ),
  QuizQuestion(
    id: 'q_makkah_11',
    doorId: 'makkah',
    questionEn:
        'By what ancient name does Surah Al-Imran (3:96) call Makkah when describing the first House of worship?',
    optionsEn: ['Quds', 'Yathrib', 'Sham', 'Bakkah'],
    correctIndex: 3,
    explanationEn:
        'Surah Al-Imran (3:96) states: “The first House [of worship] appointed for humankind was that at Bakkah, blessed and guidance for the worlds.”',
    reference: 'Surah Al-Imran 3:96',
  ),
  QuizQuestion(
    id: 'q_makkah_12',
    doorId: 'makkah',
    questionEn: 'At which hill do pilgrims begin the very first lap of Sa‘i?',
    optionsEn: ['Mount Safa', 'Mount Marwah', 'Mount Uhud', 'Mount Mina'],
    correctIndex: 0,
    explanationEn:
        'Allah begins with Safa in Surah 2:158 (“Indeed, al-Safa and al-Marwah are among the symbols of Allah”), so pilgrims start at Safa.',
    reference: 'Sahih Muslim 1218',
  ),
  QuizQuestion(
    id: 'q_makkah_13',
    doorId: 'makkah',
    questionEn: 'At which hill does the 7th and final lap of Sa‘i conclude?',
    optionsEn: ['Mount Safa', 'Jabal al-Nour', 'Mount Marwah', 'Arafah'],
    correctIndex: 2,
    explanationEn:
        'Counting Safa→Marwah as lap 1 and Marwah→Safa as lap 2, lap 7 naturally finishes at Mount Marwah.',
    reference: 'Sahih Muslim 1218',
  ),
  QuizQuestion(
    id: 'q_makkah_14',
    doorId: 'makkah',
    questionEn:
        'While circling the Kaaba in Tawaf, which side of your body always faces the Holy Kaaba?',
    optionsEn: [
      'Your right side',
      'Your left side (anti-clockwise)',
      'Your back',
      'Either direction alternates each lap',
    ],
    correctIndex: 1,
    explanationEn:
        'Pilgrims walk anti-clockwise keeping the Holy Kaaba to their left throughout all seven circuits.',
    reference: 'Umrah & Hajj Ritual Guide',
  ),
  QuizQuestion(
    id: 'q_makkah_15',
    doorId: 'makkah',
    questionEn:
        'What is the cooled marble open courtyard surrounding the Holy Kaaba called?',
    optionsEn: ['Al-Mataf', 'Al-Mas‘a', 'Jamarat', 'Riyad al-Jannah'],
    correctIndex: 0,
    explanationEn:
        'Al-Mataf is the central circumambulation floor engineered with heat-reflecting white marble around the Kaaba.',
    reference: 'Al-Masjid al-Haram Guide',
  ),
  QuizQuestion(
    id: 'q_makkah_16',
    doorId: 'makkah',
    questionEn:
        'What is the multi-level covered corridor linking Mount Safa and Mount Marwah called?',
    optionsEn: ['Al-Mataf', 'Al-Multazam', 'Bab al-Salam', 'Al-Mas‘a'],
    correctIndex: 3,
    explanationEn:
        'Al-Mas‘a houses ground and upper lanes as well as accessible electric carts for elderly or mobility-assisted pilgrims.',
    reference: 'Al-Masjid al-Haram Guide',
  ),
  QuizQuestion(
    id: 'q_makkah_17',
    doorId: 'makkah',
    questionEn:
        'Which historic Makkan family has faithfully held the custody and key (Sidanah) of the Kaaba since the Conquest of Makkah?',
    optionsEn: ['Banu Hashim', 'Banu Shaybah', 'Banu Umayyah', 'Banu Thaqif'],
    correctIndex: 1,
    explanationEn:
        'The Prophet ﷺ entrusted the Kaaba’s key permanently to Uthman ibn Talhah and Banu Shaybah.',
    reference: 'Sunan Abi Dawud / Al-Siyar',
  ),
  QuizQuestion(
    id: 'q_makkah_18',
    doorId: 'makkah',
    questionEn:
        'What special reverence applies inside the designated Al-Haram boundary surrounding Makkah?',
    optionsEn: [
      'Only residents may enter',
      'Only noon prayers are held',
      'Harming wild game or uprooting native trees is prohibited',
      'Zamzam cannot be carried inside',
    ],
    correctIndex: 2,
    explanationEn:
        'Allah made Makkah a sanctuary of peace (Balad al-Amin) where people, wildlife, and flora are protected.',
    reference: 'Sahih al-Bukhari 1834',
  ),
  QuizQuestion(
    id: 'q_makkah_19',
    doorId: 'makkah',
    questionEn:
        'What do the glowing green overhead lights along part of Al-Mas‘a remind male pilgrims to do?',
    optionsEn: [
      'Jog briskly (Raml / Harwalah) between the two green markers',
      'Stop and sit down',
      'Drink Zamzam immediately',
      'Remove sandals',
    ],
    correctIndex: 0,
    explanationEn:
        'The green lights mark the valley section where Sayyidah Hajar hastened as she checked on baby Isma‘il (AS).',
    reference: 'Umrah Sa‘i Etiquette',
  ),
  QuizQuestion(
    id: 'q_makkah_20',
    doorId: 'makkah',
    questionEn:
        'Why do pilgrims lift the right shoulder out of their upper cloth (Idtiba‘) only during Tawaf al-Qudum/Umrah?',
    optionsEn: [
      'For coolness only',
      'To honor the green flags',
      'Mandatory throughout Hajj',
      'A Sunnah displaying vigor around the Kaaba (covered again for Salah)',
    ],
    correctIndex: 3,
    explanationEn:
        'Men uncover the right shoulder during the Umrah Tawaf (Idtiba‘), then cover both shoulders again before praying at Maqam Ibrahim.',
    reference: 'Sunan Abi Dawud 1884',
  ),
];

const List<QuizQuestion> _madinahQuestions = [
  QuizQuestion(
    id: 'q_madinah_01',
    doorId: 'madinah',
    questionEn:
        'Which blessed area inside Al-Masjid an-Nabawi did the Prophet ﷺ call “one of the gardens of Paradise”?',
    optionsEn: [
      'Al-Rawdah al-Sharifah',
      'Courtyard of Quba',
      'Valley of Al-Aqiq',
      'Mount Uhud',
    ],
    correctIndex: 0,
    explanationEn:
        'Al-Rawdah al-Sharifah lies between the Prophet’s ﷺ Chamber and his Minbar, welcoming pilgrims with scheduled Rawdah permits.',
    reference: 'Sahih al-Bukhari 1196',
  ),
  QuizQuestion(
    id: 'q_madinah_02',
    doorId: 'madinah',
    questionEn:
        'Which mosque was the very first established by the Prophet ﷺ upon arriving near Madinah?',
    optionsEn: [
      'Masjid Al-Qiblatayn',
      'Masjid Al-Ghamamah',
      'Masjid Quba',
      'Masjid Al-Khayf',
    ],
    correctIndex: 2,
    explanationEn:
        'Masjid Quba was founded on the outskirts of Madinah when the Prophet ﷺ arrived from Makkah.',
    reference: 'Sunan al-Tirmidhi 324',
  ),
  QuizQuestion(
    id: 'q_madinah_03',
    doorId: 'madinah',
    questionEn:
        'According to Hadith, purifying at home and praying two rak‘ahs in Masjid Quba equals the reward of what?',
    optionsEn: [
      'One month of fasting',
      'Performing an Umrah',
      'Charity of a camel',
      'Visiting seven cities',
    ],
    correctIndex: 1,
    explanationEn:
        'The Prophet ﷺ promised: “Whoever purifies himself in his home then prays in Masjid Quba receives a reward like that of an Umrah.”',
    reference: 'Sunan Ibn Majah 1412',
  ),
  QuizQuestion(
    id: 'q_madinah_04',
    doorId: 'madinah',
    questionEn:
        'What was the historical name of Madinah before it became Al-Madinah al-Munawwarah?',
    optionsEn: ['Taif', 'Khaybar', 'Tabuk', 'Yathrib'],
    correctIndex: 3,
    explanationEn:
        'Upon his migration, the Prophet ﷺ preferred the name Madinah (and Taybah, “The Pure/Good City”) over Yathrib.',
    reference: 'Sahih al-Bukhari 1871',
  ),
  QuizQuestion(
    id: 'q_madinah_05',
    doorId: 'madinah',
    questionEn:
        'Which famous landmark crowns the southeastern roof above the Sacred Chamber in Madinah?',
    optionsEn: [
      'Bab al-Baqi Arch',
      'The Green Dome (Al-Qubbah al-Khadra)',
      'Clock Tower Crescent',
      'Minaret of Quba',
    ],
    correctIndex: 1,
    explanationEn:
        'The Green Dome marks the resting place of Prophet Muhammad ﷺ alongside Abu Bakr and Umar (RA).',
    reference: 'Madinah Architectural Heritage',
  ),
  QuizQuestion(
    id: 'q_madinah_06',
    doorId: 'madinah',
    questionEn:
        'In which Madinah mosque was the congregation commanded mid-prayer to turn toward the Kaaba in Makkah?',
    optionsEn: [
      'Masjid al-Qiblatayn',
      'Masjid al-Jumu‘ah',
      'Masjid Abu Bakr',
      'Masjid al-Ijabah',
    ],
    correctIndex: 0,
    explanationEn:
        'Masjid al-Qiblatayn (“Mosque of the Two Qiblahs”) commemorates Surah Al-Baqarah (2:144) turning prayers toward Makkah.',
    reference: 'Surah Al-Baqarah 2:144',
  ),
  QuizQuestion(
    id: 'q_madinah_07',
    doorId: 'madinah',
    questionEn:
        'Which historic cemetery lies directly beside the eastern side of Al-Masjid an-Nabawi?',
    optionsEn: [
      'Jannat al-Mu‘alla',
      'Maqbarat Mina',
      'Jannat al-Baqi',
      'Shuhada Uhud',
    ],
    correctIndex: 2,
    explanationEn:
        'Jannat al-Baqi is the resting place of many Companions and members of the Prophet’s ﷺ noble family.',
    reference: 'Sahih Muslim 974',
  ),
  QuizQuestion(
    id: 'q_madinah_08',
    doorId: 'madinah',
    questionEn:
        'Of which mountain north of Madinah did the Prophet ﷺ say, “It is a mountain that loves us and we love it”?',
    optionsEn: ['Mount Safa', 'Mount Uhud', 'Mount Sala‘', 'Mount Radwa'],
    correctIndex: 1,
    explanationEn:
        'Mount Uhud overlooks the plain where Hamzah (RA) and the noble martyrs of Uhud rest.',
    reference: 'Sahih al-Bukhari 4083',
  ),
  QuizQuestion(
    id: 'q_madinah_09',
    doorId: 'madinah',
    questionEn:
        'A single prayer in Al-Masjid an-Nabawi carries how much more reward than prayer in ordinary mosques elsewhere?',
    optionsEn: ['10 times', '100 times', '500 times', '1,000 times'],
    correctIndex: 3,
    explanationEn:
        'One Salah in the Prophet’s Mosque in Madinah is better than 1,000 prayers elsewhere (except Al-Masjid al-Haram).',
    reference: 'Sahih al-Bukhari 1190',
  ),
  QuizQuestion(
    id: 'q_madinah_10',
    doorId: 'madinah',
    questionEn:
        'Between which two sacred landmarks inside Al-Masjid an-Nabawi is Al-Rawdah al-Sharifah situated?',
    optionsEn: [
      'The Prophet’s ﷺ Chamber and his Minbar',
      'Jannat al-Baqi and Bab al-Salam',
      'Masjid Quba and Qiblatayn',
      'North Piazza and Umbrellas',
    ],
    correctIndex: 0,
    explanationEn:
        'He ﷺ explicitly defined the space between his house/chamber and his pulpit (Minbar) as a garden from Paradise.',
    reference: 'Sahih al-Bukhari 1196',
  ),
  QuizQuestion(
    id: 'q_madinah_11',
    doorId: 'madinah',
    questionEn:
        'What modern architectural marvels open smoothly across the Madinah Mosque piazzas to shade pilgrims from heat?',
    optionsEn: [
      'Stone domes only',
      'Canvas tents',
      'Retractable automated sun-umbrellas',
      'Glass bridges',
    ],
    correctIndex: 2,
    explanationEn:
        'More than 250 monumental motorized umbrellas cool and shade hundreds of thousands of worshippers across the outer courtyards.',
    reference: 'Al-Masjid an-Nabawi Operations',
  ),
  QuizQuestion(
    id: 'q_madinah_12',
    doorId: 'madinah',
    questionEn:
        'Which two senior companions lie resting beside Prophet Muhammad ﷺ in the Sacred Chamber?',
    optionsEn: [
      'Uthman and Ali (RA)',
      'Abu Bakr and Umar (RA)',
      'Hamzah and Abbas (RA)',
      'Bilal and Salman (RA)',
    ],
    correctIndex: 1,
    explanationEn:
        'Visitors pass through Bab al-Salam offering peace respectfully to the Prophet ﷺ, Abu Bakr al-Siddiq, and Umar al-Faruq.',
    reference: 'Madinah Ziyarat Etiquette',
  ),
  QuizQuestion(
    id: 'q_madinah_13',
    doorId: 'madinah',
    questionEn:
        'Which Madinah mosque southwest of the Haram is named after the cloud that shaded the Prophet ﷺ during Eid & Rain prayers?',
    optionsEn: [
      'Masjid al-Fath',
      'Masjid al-Suqya',
      'Masjid al-Sajdah',
      'Masjid al-Ghamamah',
    ],
    correctIndex: 3,
    explanationEn:
        '“Ghamamah” means cloud—commemorating the cloud that sheltered the Prophet ﷺ as he led Eid and Istisqa prayers.',
    reference: 'Madinah Historical Landmarks',
  ),
  QuizQuestion(
    id: 'q_madinah_14',
    doorId: 'madinah',
    questionEn:
        'Who was appointed by the Prophet ﷺ as the first Muezzin to call the Adhan in Al-Masjid an-Nabawi?',
    optionsEn: [
      'Bilal ibn Rabah (RA)',
      'Abdullah ibn Mas‘ud',
      'Zayd ibn Thabit',
      'Sa‘d ibn Abi Waqqas',
    ],
    correctIndex: 0,
    explanationEn:
        'Bilal’s (RA) resonant voice echoed from the rooftops of Madinah calling believers to all five daily prayers.',
    reference: 'Sahih al-Bukhari 604',
  ),
  QuizQuestion(
    id: 'q_madinah_15',
    doorId: 'madinah',
    questionEn:
        'What was the shaded platform at the back of Al-Masjid an-Nabawi where devoted learners like Abu Hurayrah lived called?',
    optionsEn: ['Al-Minbar', 'Al-Mihrab', 'Al-Suffah', 'Al-Rawdah'],
    correctIndex: 2,
    explanationEn:
        'Ahl al-Suffah memorized Hadith and Qur’an directly from the Prophet ﷺ, passing knowledge down to every generation.',
    reference: 'Sahih al-Bukhari 6452',
  ),
  QuizQuestion(
    id: 'q_madinah_16',
    doorId: 'madinah',
    questionEn:
        'In the Duya app, which sacred Madinah visit typically requires booking an organized time-slot permit?',
    optionsEn: [
      'Outer piazza seating',
      'Al-Rawdah al-Sharifah',
      'Hotel breakfast',
      'Public library hall',
    ],
    correctIndex: 1,
    explanationEn:
        'Organized time-slot permits allow every visitor to pray peacefully inside Al-Rawdah al-Sharifah without overcrowding.',
    reference: 'Duya Rawdah Permit Flow',
  ),
  QuizQuestion(
    id: 'q_madinah_17',
    doorId: 'madinah',
    questionEn:
        'In 5 AH, which defensive innovation did Salman al-Farsi suggest to protect Madinah along its northern gap?',
    optionsEn: [
      'Digging a defensive trench (Khandaq)',
      'Flooding the wells',
      'Retreating to Taif',
      'Building wooden towers',
    ],
    correctIndex: 0,
    explanationEn:
        'Prophet Muhammad ﷺ worked hand-in-hand with the Companions digging the Khandaq to defend Madinah.',
    reference: 'Sahih al-Bukhari 4103',
  ),
  QuizQuestion(
    id: 'q_madinah_18',
    doorId: 'madinah',
    questionEn:
        'Which historic mosque complex near Mount Uhud honors Hamzah (RA) and the noble martyrs resting nearby?',
    optionsEn: [
      'Masjid Quba',
      'Masjid al-Ijabah',
      'Masjid al-Fath',
      'Sayyid al-Shuhada Mosque',
    ],
    correctIndex: 3,
    explanationEn:
        'Sayyid al-Shuhada sits at the base of Mount Uhud, a regular stop on Madinah Ziyarat tours.',
    reference: 'Madinah Ziyarat Guide',
  ),
  QuizQuestion(
    id: 'q_madinah_19',
    doorId: 'madinah',
    questionEn:
        'Through which traditional gate do pilgrims enter calmly to pass before the Sacred Chamber and offer Salam?',
    optionsEn: [
      'Bab Makkah',
      'Bab al-Salam',
      'Bab al-Safa',
      'Bab al-Umrah',
    ],
    correctIndex: 1,
    explanationEn:
        'Entering smoothly from Bab al-Salam leads visitors along the eastern walkway toward Bab al-Baqi.',
    reference: 'Al-Masjid an-Nabawi Visitor Map',
  ),
  QuizQuestion(
    id: 'q_madinah_20',
    doorId: 'madinah',
    questionEn:
        'What Qur’anic etiquette (49:2) guides worshippers when standing inside the Prophet’s Mosque in Madinah?',
    optionsEn: [
      'Shouting loudly to be heard',
      'Rushing ahead of others',
      'Calmness, reverence & lowered voices',
      'Filming everyone nearby',
    ],
    correctIndex: 2,
    explanationEn:
        'Surah Al-Hujurat (49:2) teaches gentle humility and lowered voices in the presence of the Messenger ﷺ.',
    reference: 'Surah Al-Hujurat 49:2',
  ),
];

const List<QuizQuestion> _umrahQuestions = [
  QuizQuestion(
    id: 'q_umrah_01',
    doorId: 'umrah',
    questionEn:
        'What is the designated boundary station called where pilgrims enter the sacred state of Ihram before reaching Makkah for Umrah?',
    optionsEn: ['Miqat', 'Mina', 'Jamarat', 'Maqam'],
    correctIndex: 0,
    explanationEn:
        'Pilgrims assume Ihram and make their Umrah intention (niyyah) at or before crossing their appointed Miqat boundary.',
    reference: 'Sahih al-Bukhari 1524',
  ),
  QuizQuestion(
    id: 'q_umrah_02',
    doorId: 'umrah',
    questionEn:
        'What are the two unsewn white cloths worn by male pilgrims in the state of Ihram called?',
    optionsEn: [
      'Thobe & Bisht',
      'Jubbah & Shawl',
      'Izar & Rida’',
      'Kufi & Izar',
    ],
    correctIndex: 2,
    explanationEn:
        'Male pilgrims wear the lower wrap (Izar) and upper shoulder wrap (Rida’), symbolizing humility and equality before Allah.',
    reference: 'Sahih al-Bukhari 1542',
  ),
  QuizQuestion(
    id: 'q_umrah_03',
    doorId: 'umrah',
    questionEn:
        'Which designated Miqat just south of Madinah serves pilgrims traveling from Madinah toward Makkah?',
    optionsEn: ['Qarn al-Manazil', 'Dhul-Hulayfah (Abyar Ali)', 'Yalamlam', 'Dhat Irq'],
    correctIndex: 1,
    explanationEn:
        'Pilgrims departing Madinah enter Ihram at Masjid Dhul-Hulayfah (commonly known as Miqat Abyar Ali).',
    reference: 'Sahih al-Bukhari 1524',
  ),
  QuizQuestion(
    id: 'q_umrah_04',
    doorId: 'umrah',
    questionEn:
        'Which Miqat corresponds to travelers arriving from Egypt, the Levant, North Africa, or western routes toward Makkah?',
    optionsEn: ['Yalamlam', 'Qarn al-Manazil', 'Dhat Irq', 'Al-Juhfah (near Rabigh)'],
    correctIndex: 3,
    explanationEn:
        'Al-Juhfah (near modern Rabigh) was appointed by the Prophet ﷺ for pilgrims coming from the Levant, Egypt, and the West.',
    reference: 'Sahih al-Bukhari 1524',
  ),
  QuizQuestion(
    id: 'q_umrah_05',
    doorId: 'umrah',
    questionEn: 'What are the essential pillars (Arkan) of performing a valid Umrah?',
    optionsEn: [
      'Ihram intention, Tawaf around the Kaaba & Sa‘i between Safa and Marwah',
      'Standing at Arafah & overnight in Mina',
      'Fasting three days & sacrificing a sheep',
      'Pelting Jamarat & visiting Uhud',
    ],
    correctIndex: 0,
    explanationEn:
        'Umrah consists of entering Ihram at Miqat, circling the Kaaba seven times (Tawaf), walking Safa–Marwah seven times (Sa‘i), and cutting hair.',
    reference: 'Fiqh of Umrah Consensus',
  ),
  QuizQuestion(
    id: 'q_umrah_06',
    doorId: 'umrah',
    questionEn:
        'Which uplifting devotional chant do pilgrims recite repeatedly from Miqat until starting Tawaf?',
    optionsEn: [
      'Takbirat al-Eid',
      'Qunut Nazilah',
      'Al-Talbiyah (“Labbayk Allahumma labbayk...”)',
      'Adhan of Fajr',
    ],
    correctIndex: 2,
    explanationEn:
        '“Here I am, O Allah, here I am!” affirms pure monotheism and readiness to answer Allah’s sacred invitation.',
    reference: 'Sahih al-Bukhari 1549',
  ),
  QuizQuestion(
    id: 'q_umrah_07',
    doorId: 'umrah',
    questionEn:
        'After finishing the 7th lap of Sa‘i at Marwah, what concluding act frees a pilgrim from Ihram?',
    optionsEn: [
      'Changing directly without any act',
      'Halq (shaving head) or Taqsir (trimming hair evenly)',
      'Touching the Black Stone again',
      'Repeating Tawaf three times',
    ],
    correctIndex: 1,
    explanationEn:
        'Men either shave the head completely (Halq—carrying extra Prophetic dua) or trim hair evenly all over (Taqsir).',
    reference: 'Sahih al-Bukhari 1727',
  ),
  QuizQuestion(
    id: 'q_umrah_08',
    doorId: 'umrah',
    questionEn: 'How do women exit Ihram upon completing Sa‘i during Umrah?',
    optionsEn: [
      'Shaving the head completely',
      'Plucking eyebrows',
      'Reciting Adhan three times',
      'Trimming about a fingertip’s length from the hair ends',
    ],
    correctIndex: 3,
    explanationEn:
        'Women exit Ihram solely by trimming a fingertip’s measure evenly from the tips of their hair—never shaving.',
    reference: 'Sunan Abi Dawud 1985',
  ),
  QuizQuestion(
    id: 'q_umrah_09',
    doorId: 'umrah',
    questionEn:
        'Which of the following is restricted while a pilgrim remains in the sacred state of Ihram?',
    optionsEn: [
      'Applying scented perfume, cutting hair/nails, or tailored clothes (for men)',
      'Drinking cold Zamzam water',
      'Using an umbrella or sunglasses',
      'Washing hands with unscented water',
    ],
    correctIndex: 0,
    explanationEn:
        'Normal hygiene like bathing gently, carrying bags, or shading with an umbrella is allowed; perfume and cutting hair/nails wait until Halq/Taqsir.',
    reference: 'Sahih Muslim 1177',
  ),
  QuizQuestion(
    id: 'q_umrah_10',
    doorId: 'umrah',
    questionEn:
        'When flying toward Jeddah airport for Umrah, when should air travelers prepare and declare their Ihram?',
    optionsEn: [
      'Two days after arriving in Makkah',
      'Inside the Jeddah baggage hall',
      'Onboard before crossing the pilot-announced Miqat line',
      'At Mount Safa',
    ],
    correctIndex: 2,
    explanationEn:
        'Crossing the Miqat boundary without Ihram is avoided by wearing Ihram wraps beforehand and making niyyah right at the captain’s alert.',
    reference: 'Umrah Air Travel Guide',
  ),
  QuizQuestion(
    id: 'q_umrah_11',
    doorId: 'umrah',
    questionEn: 'What dress guideline specifically applies to women in Ihram?',
    optionsEn: [
      'Only green abayas are permitted',
      'Any modest regular clothing without wearing a tied face veil (niqab) or gloves',
      'Unsewn white sheets only',
      'Removing hijab in public',
    ],
    correctIndex: 1,
    explanationEn:
        'Women wear comfortable modest attire of any clean color; they leave hands bare and drape a loose veil if passing crowds rather than a fitted niqab.',
    reference: 'Sahih al-Bukhari 1838',
  ),
  QuizQuestion(
    id: 'q_umrah_12',
    doorId: 'umrah',
    questionEn:
        'During the first three circuits of Umrah Tawaf, what brisk walking pace is Sunnah for able-bodied men?',
    optionsEn: ['Qasr', 'Sa‘i', 'Idtiba‘', 'Raml'],
    correctIndex: 3,
    explanationEn:
        'Raml is walking briskly with short confident steps during laps 1–3 of the initial Tawaf, then walking calmly for laps 4–7.',
    reference: 'Sahih al-Bukhari 1602',
  ),
  QuizQuestion(
    id: 'q_umrah_13',
    doorId: 'umrah',
    questionEn:
        'If a male pilgrim uncovered his right shoulder (Idtiba‘) during Umrah Tawaf, when must he cover both shoulders?',
    optionsEn: [
      'Before praying the two rak‘ahs after Tawaf',
      'Only back at the hotel',
      'At the Airport',
      'After leaving Makkah',
    ],
    correctIndex: 0,
    explanationEn:
        'Idtiba‘ belongs exclusively to the arrival/Umrah Tawaf; shoulders are covered properly before standing in Salah.',
    reference: 'Fiqh of Prayer & Tawaf',
  ),
  QuizQuestion(
    id: 'q_umrah_14',
    doorId: 'umrah',
    questionEn: 'At what moment does a pilgrim pause reciting the Talbiyah in Umrah?',
    optionsEn: [
      'Three days later',
      'At Jeddah airport',
      'Upon reaching Al-Hajar al-Aswad to begin Tawaf',
      'Before entering Madinah',
    ],
    correctIndex: 2,
    explanationEn:
        'Pilgrims chant the Talbiyah along the journey and pause it as they align with the Black Stone to begin Tawaf.',
    reference: 'Sunan al-Tirmidhi 919',
  ),
  QuizQuestion(
    id: 'q_umrah_15',
    doorId: 'umrah',
    questionEn: 'When during the Islamic year can Umrah be performed?',
    optionsEn: [
      'Only during Dhul Hijjah',
      'Year-round (every month outside active Hajj days for pilgrims)',
      'Only on Fridays',
      'Once every ten years',
    ],
    correctIndex: 1,
    explanationEn:
        'Unlike Hajj with its fixed Dhul Hijjah days, Umrah is often called the “Minor Pilgrimage” open across all seasons.',
    reference: 'Umrah Fiqh Reference',
  ),
  QuizQuestion(
    id: 'q_umrah_16',
    doorId: 'umrah',
    questionEn:
        'What spiritual blessing did the Prophet ﷺ attach to performing one Umrah followed by another?',
    optionsEn: [
      'Exemption from Ramadan fasting',
      'Ten camels of charity',
      'No need for Wudu',
      'Expiation (forgiveness) of minor sins between the two Umrahs',
    ],
    correctIndex: 3,
    explanationEn:
        'He ﷺ taught: “From one Umrah to the next is an expiation for whatever occurred between them.”',
    reference: 'Sahih al-Bukhari 1773',
  ),
  QuizQuestion(
    id: 'q_umrah_17',
    doorId: 'umrah',
    questionEn:
        'Performing Umrah specifically in the blessed month of Ramadan carries spiritual reward equal to what?',
    optionsEn: [
      'Performing Hajj (in reward)',
      'Two voluntary prayers',
      'Fasting one week',
      'Building a well',
    ],
    correctIndex: 0,
    explanationEn:
        'The Prophet ﷺ told Umm Ma‘qil: “Umrah during Ramadan is equivalent to Hajj (or Hajj with me).”',
    reference: 'Sahih al-Bukhari 1782',
  ),
  QuizQuestion(
    id: 'q_umrah_18',
    doorId: 'umrah',
    questionEn:
        'If crowds are heavy near Maqam Ibrahim after Tawaf, where can you pray the two Sunnah rak‘ahs?',
    optionsEn: [
      'Wait 6 hours in the middle of moving lines',
      'Skip Salah completely',
      'Anywhere behind Maqam Ibrahim inside Al-Masjid al-Haram',
      'Only on the roof of Mina',
    ],
    correctIndex: 2,
    explanationEn:
        'Moving calmly out of Tawaf traffic and praying behind Maqam Ibrahim anywhere in the Sanctuary keeps Al-Mataf flowing safely.',
    reference: 'Haram Crowd Etiquette',
  ),
  QuizQuestion(
    id: 'q_umrah_19',
    doorId: 'umrah',
    questionEn: 'What footwear rule applies to men while wearing Ihram?',
    optionsEn: [
      'Leather boots above the ankle',
      'Open sandals leaving the ankles and upper foot exposed',
      'Socks covering the toes only',
      'Barefoot walking is mandatory indoors and out',
    ],
    correctIndex: 1,
    explanationEn:
        'Open sandals protect feet comfortably across marble plazas while honoring Ihram guidelines.',
    reference: 'Sahih al-Bukhari 1838',
  ),
  QuizQuestion(
    id: 'q_umrah_20',
    doorId: 'umrah',
    questionEn:
        'How does Duya’s Motawef feature support first-time Umrah pilgrims?',
    optionsEn: [
      'Weather forecasts only',
      'Flight seat maps only',
      'Restaurant coupons only',
      'Live Tawaf & Sa‘i circuit counters, step-by-step rites & contextual duas',
    ],
    correctIndex: 3,
    explanationEn:
        'Duya’s Motawef tool keeps pilgrims focused on worship by tracking all 7 Tawaf and 7 Sa‘i rounds with authentic duas.',
    reference: 'Duya Motawef Companion',
  ),
];

const List<QuizQuestion> _hajjQuestions = [
  QuizQuestion(
    id: 'q_hajj_01',
    doorId: 'hajj',
    questionEn:
        'Which day of Dhul Hijjah is described by the Prophet ﷺ as the essential pillar and spiritual summit of Hajj?',
    optionsEn: [
      'Day of Arafah (9th Dhul Hijjah)',
      'Day of Tarwiyah (8th Dhul Hijjah)',
      'First Day of Tashriq',
      'Last Day of Muharram',
    ],
    correctIndex: 0,
    explanationEn:
        'The Prophet ﷺ said, “Hajj is Arafah” — standing in earnest supplication on the plain of Arafah on the 9th of Dhul Hijjah.',
    reference: 'Sunan al-Tirmidhi 889',
  ),
  QuizQuestion(
    id: 'q_hajj_02',
    doorId: 'hajj',
    questionEn:
        'What is the 8th day of Dhul Hijjah called when pilgrims enter Ihram and settle into the tent city of Mina?',
    optionsEn: ['Yawm al-Nahr', 'Yawm al-Fath', 'Yawm al-Tarwiyah', 'Yawm al-Jum‘ah'],
    correctIndex: 2,
    explanationEn:
        'Historically pilgrims watered mounts and stored provisions on Yawm al-Tarwiyah before spending the night in Mina praying Dhuhr through Fajr.',
    reference: 'Hajj Chronology Guide',
  ),
  QuizQuestion(
    id: 'q_hajj_03',
    doorId: 'hajj',
    questionEn:
        'What are the three recognized ways (Nusuk) a pilgrim may intend and perform Hajj?',
    optionsEn: [
      'Raml, Sa‘i & Halq',
      'Tamattu‘, Qiran & Ifrad',
      'Fajr, Dhuhr & Asr',
      'Safa, Marwah & Zamzam',
    ],
    correctIndex: 1,
    explanationEn:
        'Pilgrims choose Tamattu‘ (Umrah then separate Hajj), Qiran (both in one Ihram), or Ifrad (Hajj only).',
    reference: 'Sahih Muslim 1211',
  ),
  QuizQuestion(
    id: 'q_hajj_04',
    doorId: 'hajj',
    questionEn:
        'In which popular form of Hajj does a pilgrim perform Umrah first, exit Ihram temporarily, then re-enter Ihram for Hajj on the 8th?',
    optionsEn: ['Hajj al-Ifrad', 'Hajj al-Badal', 'Hajj al-Qiran', 'Hajj al-Tamattu‘'],
    correctIndex: 3,
    explanationEn:
        'Most international pilgrims perform Hajj al-Tamattu‘, enjoying full relief between Umrah and the 8th of Dhul Hijjah.',
    reference: 'Sahih al-Bukhari 1564',
  ),
  QuizQuestion(
    id: 'q_hajj_05',
    doorId: 'hajj',
    questionEn:
        'To which open valley between Arafah and Mina do pilgrims travel immediately after sunset on the Day of Arafah?',
    optionsEn: ['Muzdalifah', 'Quba', 'Badr', 'Taif'],
    correctIndex: 0,
    explanationEn:
        'In Muzdalifah pilgrims rest under the night sky and gather smooth pebbles for Rami at Mina.',
    reference: 'Sahih Muslim 1218',
  ),
  QuizQuestion(
    id: 'q_hajj_06',
    doorId: 'hajj',
    questionEn:
        'Which two daily prayers do pilgrims combine and offer together upon reaching Muzdalifah on the night of the 9th?',
    optionsEn: [
      'Fajr and Dhuhr',
      'Dhuhr and Asr',
      'Maghrib and Isha',
      'Asr and Maghrib',
    ],
    correctIndex: 2,
    explanationEn:
        'Following the Prophet’s ﷺ Sunnah, pilgrims delay Maghrib slightly until reaching Muzdalifah and combine Maghrib (3) and shortened Isha (2).',
    reference: 'Sahih al-Bukhari 1674',
  ),
  QuizQuestion(
    id: 'q_hajj_07',
    doorId: 'hajj',
    questionEn:
        'What is the 10th of Dhul Hijjah—celebrated globally as Eid al-Adha and the busiest day of Hajj—called?',
    optionsEn: [
      'Yawm al-Tarwiyah',
      'Yawm al-Nahr (Day of Sacrifice)',
      'Ashura',
      'Laylat al-Qadr',
    ],
    correctIndex: 1,
    explanationEn:
        'On Yawm al-Nahr pilgrims stone Jamrat al-Aqabah, offer Hady sacrifice, shave/trim hair, and perform Tawaf al-Ifadah.',
    reference: 'Sahih al-Bukhari 1741',
  ),
  QuizQuestion(
    id: 'q_hajj_08',
    doorId: 'hajj',
    questionEn:
        'On Eid morning (10th Dhul Hijjah), which Jamarat pillar alone do pilgrims pelt with seven pebbles?',
    optionsEn: [
      'All three Jamarat',
      'Jamrat al-Sughra only',
      'Jamrat al-Wusta only',
      'Jamrat al-Aqabah (the Largest Pillar)',
    ],
    correctIndex: 3,
    explanationEn:
        'Only Jamrat al-Aqabah (nearest to Makkah) is pelted on the 10th; all three are pelted on subsequent Tashriq days.',
    reference: 'Sahih Muslim 1299',
  ),
  QuizQuestion(
    id: 'q_hajj_09',
    doorId: 'hajj',
    questionEn:
        'What is the pilgrimage sacrifice required of Tamattu‘ and Qiran pilgrims on the 10th of Dhul Hijjah called?',
    optionsEn: ['Hady', 'Zakat al-Fitr', 'Kaffarah', 'Sadaqah Jariyah'],
    correctIndex: 0,
    explanationEn:
        'Hady honors Prophet Ibrahim’s (AS) devotion and feeds the needy in the Haram and worldwide.',
    reference: 'Surah Al-Baqarah 2:196',
  ),
  QuizQuestion(
    id: 'q_hajj_10',
    doorId: 'hajj',
    questionEn:
        'Which obligatory Tawaf around the Holy Kaaba performed on or after the 10th is a fundamental pillar (Rukn) of Hajj?',
    optionsEn: [
      'Tawaf al-Qudum',
      'Tawaf al-Wada‘',
      'Tawaf al-Ifadah (Tawaf al-Ziyarah)',
      'Voluntary Nafl Tawaf',
    ],
    correctIndex: 2,
    explanationEn:
        'Without Tawaf al-Ifadah, Hajj remains incomplete; it seals the pilgrim’s exit from all remaining Ihram restrictions.',
    reference: 'Surah Al-Hajj 22:29',
  ),
  QuizQuestion(
    id: 'q_hajj_11',
    doorId: 'hajj',
    questionEn:
        'What collective name refers to the 11th, 12th, and 13th of Dhul Hijjah spent in Mina pelting the three Jamarat?',
    optionsEn: [
      'White Days',
      'Days of Tashriq',
      'Months of Peace',
      'Nights of Safar',
    ],
    correctIndex: 1,
    explanationEn:
        '“Days of Tashriq are days of eating, drinking, and remembering Allah” while completing Jamarat in Mina.',
    reference: 'Sahih Muslim 1141',
  ),
  QuizQuestion(
    id: 'q_hajj_12',
    doorId: 'hajj',
    questionEn:
        'In which sequential order are the three Jamarat pillars pelted on the 11th and 12th of Dhul Hijjah?',
    optionsEn: [
      'Largest → Middle → Smallest',
      'Middle → Smallest → Largest',
      'Any random order',
      'Smallest (Sughra) → Middle (Wusta) → Largest (Aqabah)',
    ],
    correctIndex: 3,
    explanationEn:
        'Pilgrims begin with Small, pause briefly to face Qibla and make dua, proceed to Middle + dua, and finish with Aqabah.',
    reference: 'Sahih al-Bukhari 1753',
  ),
  QuizQuestion(
    id: 'q_hajj_13',
    doorId: 'hajj',
    questionEn:
        'How many tiny pebbles should be thrown one by one while saying “Allahu Akbar” at each Jamrah?',
    optionsEn: ['7 pebbles', '3 pebbles', '12 pebbles', '40 pebbles'],
    correctIndex: 0,
    explanationEn:
        'Seven small chickpea-sized pebbles are cast gently one at a time in remembrance of Allah.',
    reference: 'Sahih Muslim 1297',
  ),
  QuizQuestion(
    id: 'q_hajj_14',
    doorId: 'hajj',
    questionEn:
        'What final ritual around the Kaaba bids farewell to Makkah at the close of Hajj?',
    optionsEn: [
      'Tawaf al-Qudum',
      'Raml al-Sa‘i',
      'Tawaf al-Wada‘ (Farewell Tawaf)',
      'Shaving at Mina',
    ],
    correctIndex: 2,
    explanationEn:
        'The Prophet ﷺ instructed pilgrims that their final covenant before departing Makkah should be circling the Sacred House.',
    reference: 'Sahih al-Bukhari 1755',
  ),
  QuizQuestion(
    id: 'q_hajj_15',
    doorId: 'hajj',
    questionEn:
        'Which renowned mosque inside Mina valley was prayed in by seventy prophets, as narrated in traditions?',
    optionsEn: ['Masjid Namirah', 'Masjid al-Khayf', 'Masjid Quba', 'Masjid Bilal'],
    correctIndex: 1,
    explanationEn:
        'Masjid al-Khayf stands at the southern slope of Mina, sheltering thousands of pilgrims during the Tashriq days.',
    reference: 'Makkah Heritage Guide',
  ),
  QuizQuestion(
    id: 'q_hajj_16',
    doorId: 'hajj',
    questionEn:
        'Inside which vast mosque spanning the border of Arafah is the annual Arafah Khutbah delivered?',
    optionsEn: [
      'Masjid al-Haram',
      'Masjid al-Khayf',
      'Masjid Mash‘ar al-Haram',
      'Masjid Namirah',
    ],
    correctIndex: 3,
    explanationEn:
        'Hundreds of thousands gather at Masjid Namirah to hear the Arafah sermon and pray Dhuhr and Asr combined at noon.',
    reference: 'Sahih Muslim 1218',
  ),
  QuizQuestion(
    id: 'q_hajj_17',
    doorId: 'hajj',
    questionEn:
        'What is the iconic white-pillared rocky hill on the plain of Arafah known as?',
    optionsEn: [
      'Jabal al-Rahmah (Mount of Mercy)',
      'Jabal Thawr',
      'Jabal Uhud',
      'Jabal al-Nour',
    ],
    correctIndex: 0,
    explanationEn:
        'The Prophet ﷺ stood near the base of Jabal al-Rahmah affirming, “Every spot of Arafah is a place of standing.”',
    reference: 'Sahih Muslim 1218',
  ),
  QuizQuestion(
    id: 'q_hajj_18',
    doorId: 'hajj',
    questionEn:
        'What reward did Prophet Muhammad ﷺ promise for a sincere, righteous Hajj free of sin and quarrel (Hajj Mabrur)?',
    optionsEn: [
      'Ten years of wealth',
      'Exemption from Friday prayer',
      'Nothing less than Paradise (and returning pure like a newborn)',
      'A silver crown',
    ],
    correctIndex: 2,
    explanationEn:
        '“There is no reward for an accepted Hajj (Hajj Mabrur) except Jannah.”',
    reference: 'Sahih al-Bukhari 1773',
  ),
  QuizQuestion(
    id: 'q_hajj_19',
    doorId: 'hajj',
    questionEn:
        'Which noble prophet’s steadfast rejection of Shaytan’s whispers is remembered through stoning the Jamarat?',
    optionsEn: [
      'Prophet Musa (AS)',
      'Prophet Ibrahim (AS)',
      'Prophet Dawud (AS)',
      'Prophet Isa (AS)',
    ],
    correctIndex: 1,
    explanationEn:
        'When Shaytan appeared at three stations along Mina to tempt Ibrahim (AS) away from Allah’s command, Jibril instructed him to pelt Shaytan seven times.',
    reference: 'Musnad Ahmad / Al-Mustadrak',
  ),
  QuizQuestion(
    id: 'q_hajj_20',
    doorId: 'hajj',
    questionEn:
        'How does Duya’s Hajj section help pilgrims prepare during the five intense days of pilgrimage?',
    optionsEn: [
      'Only photos of hotels',
      'Stock market tickers',
      'Sports scores',
      'Day-by-day 8th–13th Dhul Hijjah schedule, rites checklist & emergency guidance',
    ],
    correctIndex: 3,
    explanationEn:
        'Duya organizes every station—Mina, Arafah, Muzdalifah, Jamarat, and Tawaf al-Ifadah—so pilgrims focus on devotion.',
    reference: 'Duya Hajj Companion',
  ),
];

const List<QuizQuestion> _prayerQuestions = [
  QuizQuestion(
    id: 'q_prayer_01',
    doorId: 'prayer',
    questionEn:
        'According to authentic Hadith, how many times greater is the reward of one prayer in Al-Masjid al-Haram compared to ordinary mosques?',
    optionsEn: ['100,000 times', '1,000 times', '500 times', '70 times'],
    correctIndex: 0,
    explanationEn:
        'A single salah offered inside Al-Masjid al-Haram in Makkah equals 100,000 prayers elsewhere, and 1,000 prayers in Al-Masjid an-Nabawi.',
    reference: 'Sunan Ibn Majah 1406',
  ),
  QuizQuestion(
    id: 'q_prayer_02',
    doorId: 'prayer',
    questionEn: 'How many obligatory daily prayers (Fard Salah) were ordained upon Muslims?',
    optionsEn: ['3 prayers', '4 prayers', '5 prayers', '7 prayers'],
    correctIndex: 2,
    explanationEn:
        'Fajr, Dhuhr, Asr, Maghrib, and Isha were gifted directly during Al-Isra wal-Mi‘raj, carrying the reward of fifty!',
    reference: 'Sahih al-Bukhari 349',
  ),
  QuizQuestion(
    id: 'q_prayer_03',
    doorId: 'prayer',
    questionEn:
        'What Arabic term refers to the sacred direction facing the Kaaba toward which Muslims align every prayer?',
    optionsEn: ['Mihrab', 'Qibla', 'Minbar', 'Takbir'],
    correctIndex: 1,
    explanationEn:
        'Whether at home or traveling worldwide, Duya’s Qibla Compass calculates the great-circle bearing directly to Makkah.',
    reference: 'Surah Al-Baqarah 2:144',
  ),
  QuizQuestion(
    id: 'q_prayer_04',
    doorId: 'prayer',
    questionEn:
        'Which obligatory daily prayer opens the day at true dawn (Fajr Sadiq) before sunrise?',
    optionsEn: ['Dhuhr', 'Asr', 'Isha', 'Fajr'],
    correctIndex: 3,
    explanationEn:
        'The two Sunnah rak‘ahs before Fajr were described by the Prophet ﷺ as better than the entire world and all it contains.',
    reference: 'Sahih Muslim 725',
  ),
  QuizQuestion(
    id: 'q_prayer_05',
    doorId: 'prayer',
    questionEn:
        'Which special congregational weekly prayer with two Khutbah sermons replaces Dhuhr on Fridays?',
    optionsEn: [
      'Salat al-Jumu‘ah',
      'Salat al-Duha',
      'Salat al-Istikhara',
      'Salat al-Kusuf',
    ],
    correctIndex: 0,
    explanationEn:
        'Muslims gather cleanly dressed with fragrance for the Friday sermon and two-unit congregational Jumu‘ah prayer.',
    reference: 'Surah Al-Jumu‘ah 62:9',
  ),
  QuizQuestion(
    id: 'q_prayer_06',
    doorId: 'prayer',
    questionEn:
        'Which blessed voluntary morning prayer begins roughly 15–20 minutes after sunrise and lasts until before noon?',
    optionsEn: ['Witr', 'Tarawih', 'Salat al-Duha', 'Janazah'],
    correctIndex: 2,
    explanationEn:
        'Offering two or more rak‘ahs of Duha fulfills the charity of every single bone and joint in the body each day.',
    reference: 'Sahih Muslim 720',
  ),
  QuizQuestion(
    id: 'q_prayer_07',
    doorId: 'prayer',
    questionEn:
        'Which odd-numbered concluding night prayer did the Prophet ﷺ consistently guard whether at home or traveling?',
    optionsEn: ['Salat al-Kusuf', 'Salat al-Witr', 'Tahiyyat al-Wudu', 'Istisqa'],
    correctIndex: 1,
    explanationEn:
        'The Prophet ﷺ advised: “Make the last of your night prayers an odd number (Witr).”',
    reference: 'Sahih al-Bukhari 998',
  ),
  QuizQuestion(
    id: 'q_prayer_08',
    doorId: 'prayer',
    questionEn:
        'Which call inside the Adhan translates to “Come to prayer, come to success”?',
    optionsEn: [
      'Allahu Akbar',
      'Qad qamatis-salah',
      'La ilaha illallah',
      'Hayya ‘alas-salah, hayya ‘alal-falah',
    ],
    correctIndex: 3,
    explanationEn:
        'Repeating the Muezzin’s phrases softly—and answering “La hawla wa la quwwata illa billah” at Hayya ‘alas-salah—brings immense reward.',
    reference: 'Sahih Muslim 385',
  ),
  QuizQuestion(
    id: 'q_prayer_09',
    doorId: 'prayer',
    questionEn:
        'What unique reminder (“Prayer is better than sleep”) is chanted in the Fajr Adhan?',
    optionsEn: [
      'As-salatu khayrun min an-nawm',
      'SubhanAllah al-Azim',
      'Al-salatu jami‘ah',
      'Labbayk Allahumma labbayk',
    ],
    correctIndex: 0,
    explanationEn:
        'This peaceful wake-up call (Tathwib) encourages believers to rise for Fajr before dawn breaks.',
    reference: 'Sunan Abi Dawud 500',
  ),
  QuizQuestion(
    id: 'q_prayer_10',
    doorId: 'prayer',
    questionEn:
        'What physical state of purification is essential before standing in Salah or beginning Tawaf around the Kaaba?',
    optionsEn: ['Fasting', 'Wearing green', 'Wudu (ritual ablution)', 'Standing on marble'],
    correctIndex: 2,
    explanationEn:
        'Clean Wudu washes limbs and sins together, preparing heart and body to stand before Allah.',
    reference: 'Sahih Muslim 224',
  ),
  QuizQuestion(
    id: 'q_prayer_11',
    doorId: 'prayer',
    questionEn:
        'When praying inside Al-Masjid al-Haram around the Kaaba, how do rows of believers align?',
    optionsEn: [
      'Strictly east-to-west lines only',
      'Concentric circles around all four sides facing the Kaaba center',
      'Always facing north',
      'Standing only at Mount Safa',
    ],
    correctIndex: 1,
    explanationEn:
        'Every concentric ring inside Al-Mataf faces inward toward the Kaaba from all 360 degrees!',
    reference: 'Al-Masjid al-Haram Prayer Lines',
  ),
  QuizQuestion(
    id: 'q_prayer_12',
    doorId: 'prayer',
    questionEn:
        'What brief Sunnah prayer does the Prophet ﷺ advise offering upon first entering a mosque before taking a seat?',
    optionsEn: [
      'Four rak‘ahs of Asr',
      'Salat al-Eid',
      'Funeral prayer',
      'Tahiyyat al-Masjid (2 rak‘ahs greeting the mosque)',
    ],
    correctIndex: 3,
    explanationEn:
        '“When any of you enters the mosque, let him not sit down until he prays two rak‘ahs.” (In Al-Haram, starting Tawaf itself serves as its greeting.)',
    reference: 'Sahih al-Bukhari 444',
  ),
  QuizQuestion(
    id: 'q_prayer_13',
    doorId: 'prayer',
    questionEn:
        'What gracious easing (Rukhsah) does Islam provide to travelers regarding four-rak‘ah prayers like Dhuhr, Asr, and Isha?',
    optionsEn: [
      'Shortening 4 rak‘ahs to 2 rak‘ahs (Qasr)',
      'Repeating them twice',
      'Skipping prayer until returning home',
      'Replacing all prayers with fasting',
    ],
    correctIndex: 0,
    explanationEn:
        'Allah loves His travelers accepting Qasr (2 rak‘ahs for Dhuhr, Asr, and Isha) and permitting combining pairs when on the road.',
    reference: 'Sahih Muslim 686',
  ),
  QuizQuestion(
    id: 'q_prayer_14',
    doorId: 'prayer',
    questionEn:
        'Alongside Al-Masjid al-Haram and Al-Masjid an-Nabawi, which third sanctuary completes the three mosques toward which pilgrimage travel is uniquely blessed?',
    optionsEn: [
      'Cordoba Mosque',
      'Sultan Ahmed Mosque',
      'Al-Masjid al-Aqsa in Jerusalem',
      'Masjid al-Azhar',
    ],
    correctIndex: 2,
    explanationEn:
        '“Do not set out on a religious journey except to three mosques: Al-Masjid al-Haram, my Mosque (Nabawi), and Al-Masjid al-Aqsa.”',
    reference: 'Sahih al-Bukhari 1189',
  ),
  QuizQuestion(
    id: 'q_prayer_15',
    doorId: 'prayer',
    questionEn:
        'Saying the Shahadah and repentance dua right after completing Wudu opens how many gates of Paradise according to Sahih Muslim?',
    optionsEn: ['Two gates', 'All eight gates of Paradise', 'Four gates', 'One gate'],
    correctIndex: 1,
    explanationEn:
        'Reciting “Ashhadu an la ilaha illallah...” after careful Wudu invites the believer through whichever of the eight gates they wish.',
    reference: 'Sahih Muslim 234',
  ),
  QuizQuestion(
    id: 'q_prayer_16',
    doorId: 'prayer',
    questionEn: 'When does the time window for Dhuhr prayer begin each day?',
    optionsEn: [
      'At sunset',
      'One hour before dawn',
      'Right at sunrise',
      'Immediately after the sun crosses its midday zenith (Zawal)',
    ],
    correctIndex: 3,
    explanationEn:
        'Once the sun tilts just past high noon toward the west, Dhuhr time enters.',
    reference: 'Sahih Muslim 612',
  ),
  QuizQuestion(
    id: 'q_prayer_17',
    doorId: 'prayer',
    questionEn: 'Which evening prayer enters right as the entire disk of the sun sets below the horizon?',
    optionsEn: ['Maghrib', 'Asr', 'Fajr', 'Duha'],
    correctIndex: 0,
    explanationEn:
        'In Ramadan, Maghrib also joyfully signals the exact moment to break the fast (Iftar) with dates and water.',
    reference: 'Sahih Muslim 612',
  ),
  QuizQuestion(
    id: 'q_prayer_18',
    doorId: 'prayer',
    questionEn:
        'Which daily prayer did Prophet Muhammad ﷺ identify as Salat al-Wusta (“The Guarded Middle Prayer” in Surah 2:238)?',
    optionsEn: ['Fajr prayer', 'Maghrib prayer', 'Asr prayer', 'Isha prayer'],
    correctIndex: 2,
    explanationEn:
        'Allah calls special attention to guarding prayers—especially the late-afternoon Asr prayer amid busy daily schedules.',
    reference: 'Sahih Muslim 627',
  ),
  QuizQuestion(
    id: 'q_prayer_19',
    doorId: 'prayer',
    questionEn:
        'During which serene portion of the night does Tahajjud bring special closeness and answered prayers?',
    optionsEn: [
      'Right after sunset',
      'The final third of the night before Fajr',
      'Mid-afternoon',
      'Ten minutes after Dhuhr',
    ],
    correctIndex: 1,
    explanationEn:
        'Even two quiet rak‘ahs before Fajr with sincere dua bring peace, clarity, and answered supplications.',
    reference: 'Sahih al-Bukhari 1145',
  ),
  QuizQuestion(
    id: 'q_prayer_20',
    doorId: 'prayer',
    questionEn:
        'How does the Duya app determine accurate Prayer Times & Qibla bearings for Makkah, Madinah, and cities worldwide?',
    optionsEn: [
      'Fixed 6 AM / 6 PM estimates',
      'Random daily offsets',
      'Manual paper charts only',
      'Astronomical solar angles, city coordinates & Umm al-Qura calculation methods',
    ],
    correctIndex: 3,
    explanationEn:
        'Duya calculates real-time local solar prayer schedules (plus Qibla azimuths) offline and accurately wherever your journey takes you.',
    reference: 'Duya Prayer & Qibla Engine',
  ),
];

const List<QuizQuestion> _duasQuestions = [
  QuizQuestion(
    id: 'q_duas_01',
    doorId: 'duas',
    questionEn:
        'What Prophetic guidance accompanies drinking sacred Zamzam water during pilgrimage and daily life?',
    optionsEn: [
      'Making sincere dua — Zamzam is for whatever purpose it is drunk',
      'Drinking only at sunrise',
      'Fasting beforehand',
      'Facing away from the Qibla',
    ],
    correctIndex: 0,
    explanationEn:
        'The Prophet ﷺ taught, “The water of Zamzam is for whatever it is drunk for,” encouraging believers to ask Allah for beneficial Ilm, sustenance, and healing.',
    reference: 'Sunan Ibn Majah 3062',
  ),
  QuizQuestion(
    id: 'q_duas_02',
    doorId: 'duas',
    questionEn:
        'Which three phrases of Tasbih are recommended 33, 33, and 33 times (plus Tahliil to 100) after every obligatory Salah?',
    optionsEn: [
      'Bismillah only',
      'Labbayk only',
      'SubhanAllah, Alhamdulillah, Allahu Akbar',
      'Amin repeated 100 times',
    ],
    correctIndex: 2,
    explanationEn:
        'These three luminous phrases are easily counted in Duya’s built-in Tasbih counter after each prayer.',
    reference: 'Sahih Muslim 597',
  ),
  QuizQuestion(
    id: 'q_duas_03',
    doorId: 'duas',
    questionEn:
        'What is the joyful meaning of “Labbayk Allahumma labbayk” at the start of the pilgrimage Talbiyah?',
    optionsEn: [
      'Peace upon dawn',
      'Here I am, O Allah, answering Your call',
      'Open the gates of morning',
      'Grant us safe return home',
    ],
    correctIndex: 1,
    explanationEn:
        'It voices the pilgrim’s humble, loving response to Allah’s centuries-old invitation to His Sacred House.',
    reference: 'Sahih al-Bukhari 1549',
  ),
  QuizQuestion(
    id: 'q_duas_04',
    doorId: 'duas',
    questionEn:
        'Which comprehensive Qur’anic dua from Surah Al-Baqarah (2:201) did the Prophet ﷺ recite most often—and especially between Rukn al-Yamani and the Black Stone?',
    optionsEn: [
      'Rabbi zidni ilman',
      'Hasbunallahu wa ni‘mal-wakil',
      'Inna lillahi wa inna ilayhi raji‘un',
      'Rabbana atina fid-dunya hasanah wa fil-akhirati hasanah wa qina ‘adhaban-nar',
    ],
    correctIndex: 3,
    explanationEn:
        'Asking Allah for goodness in both this world and the Hereafter gathers every spiritual and earthly blessing into one breath.',
    reference: 'Surah Al-Baqarah 2:201',
  ),
  QuizQuestion(
    id: 'q_duas_05',
    doorId: 'duas',
    questionEn:
        'Upon climbing Safa and Marwah and facing the Kaaba during Sa‘i, how did the Prophet ﷺ praise Allah three times before personal duas?',
    optionsEn: [
      'Allahu Akbar (3x), La ilaha illallahu wahdahu la sharika lah...',
      'Silent bowing only',
      'Reading Surah Al-Fatihah',
      'Clapping hands',
    ],
    correctIndex: 0,
    explanationEn:
        'Facing the Kaaba, he glorified Allah, raised his hands warmly in long personal dua, and repeated this three times.',
    reference: 'Sahih Muslim 1218',
  ),
  QuizQuestion(
    id: 'q_duas_06',
    doorId: 'duas',
    questionEn:
        'Which short dua does the Prophet ﷺ recommend saying as you step inside any mosque with your right foot?',
    optionsEn: [
      'Allahumma inni as’aluka min fadlik (bounty)',
      'Allahumma salli wa sallim only',
      'Allahumma ftah li abwaba rahmatik (“Open for me the doors of Your mercy”)',
      'Ghufranaka',
    ],
    correctIndex: 2,
    explanationEn:
        'Entering asks for Allah’s expansive Mercy (Rahmah); exiting asks for Allah’s pure Bounty (Fadl) as you step back into daily life.',
    reference: 'Sahih Muslim 713',
  ),
  QuizQuestion(
    id: 'q_duas_07',
    doorId: 'duas',
    questionEn:
        'Which dua accompanies stepping OUT of a mosque with the left foot?',
    optionsEn: [
      'Allahumma ftah li abwaba rahmatik',
      'Allahumma inni as’aluka min fadlik (“O Allah, I ask You from Your bounty”)',
      'Subhanaka rabbana',
      'Bismika Allahumma amutu wa ahya',
    ],
    correctIndex: 1,
    explanationEn:
        'Seeking Allah’s Fadl connects worship inside the Masjid directly to ethical livelihood and kindness outdoors.',
    reference: 'Sahih Muslim 713',
  ),
  QuizQuestion(
    id: 'q_duas_08',
    doorId: 'duas',
    questionEn:
        'Which opening words begin Sayyid al-Istighfar—the “Master Supplication for Seeking Forgiveness”?',
    optionsEn: [
      'Allahu Akbar kabira',
      'Labbayk Allahumma',
      'Rabbana zalamna anfusana',
      'Allahumma Anta Rabbi la ilaha illa Anta, khalaqtani wa ana ‘abduk...',
    ],
    correctIndex: 3,
    explanationEn:
        'Recited with conviction morning and evening, Sayyid al-Istighfar acknowledges Allah’s favors, repents sincerely, and seeks refuge in Him.',
    reference: 'Sahih al-Bukhari 6306',
  ),
  QuizQuestion(
    id: 'q_duas_09',
    doorId: 'duas',
    questionEn:
        'Which Qur’anic travel dua (43:13) is recited upon boarding a plane, train, or bus toward Makkah & Madinah?',
    optionsEn: [
      'Subhanalladhi sakhkhara lana hadha wa ma kunna lahu muqrinin',
      'Alhamdulillahi rabbil-‘alamin only',
      'MashaAllah tabarakAllah',
      'Qul Huwallahu Ahad',
    ],
    correctIndex: 0,
    explanationEn:
        'The Travel Dua honors Allah who subjected vehicles smoothly to our service and asks for piety and ease along the journey.',
    reference: 'Sahih Muslim 1342',
  ),
  QuizQuestion(
    id: 'q_duas_10',
    doorId: 'duas',
    questionEn:
        'What closing dua (Kaffarat al-Majlis) clears idle slips when ending a gathering or study session?',
    optionsEn: [
      'Amin, Amin',
      'Bismillah al-Rahman al-Rahim',
      'Subhanaka Allahumma wa bihamdika, ashhadu an la ilaha illa Anta, astaghfiruka wa atubu ilayk',
      'Allahu Akbar',
    ],
    correctIndex: 2,
    explanationEn:
        'Concluding gatherings with praise and istighfar leaves every conversation elevated and forgiven.',
    reference: 'Sunan al-Tirmidhi 3433',
  ),
  QuizQuestion(
    id: 'q_duas_11',
    doorId: 'duas',
    questionEn:
        'Which short remembrance did the Prophet ﷺ tell Abu Musa al-Ash‘ari is “one of the treasures of Paradise”?',
    optionsEn: [
      'Ya Hayyu Ya Qayyum',
      'La hawla wa la quwwata illa billah',
      'MashaAllah la quwwata',
      'JazakAllahu khayran',
    ],
    correctIndex: 1,
    explanationEn:
        '“There is no might nor power except through Allah” refills exhausted travelers with quiet spiritual strength.',
    reference: 'Sahih al-Bukhari 4205',
  ),
  QuizQuestion(
    id: 'q_duas_12',
    doorId: 'duas',
    questionEn:
        'Reciting “Hasbiyallahu la ilaha illa Huwa, ‘alayhi tawakkaltu...” seven times morning and evening nurtures what inner quality?',
    optionsEn: [
      'Hurried anxiety',
      'Pride in wealth',
      'Forgetfulness',
      'Complete reliance (Tawakkul) knowing Allah is sufficient for your worries',
    ],
    correctIndex: 3,
    explanationEn:
        'Trusting Allah with every concern eases anxiety during travel, visas, crowds, and daily responsibilities.',
    reference: 'Sunan Abi Dawud 5081',
  ),
  QuizQuestion(
    id: 'q_duas_13',
    doorId: 'duas',
    questionEn:
        'Which heartfelt dua did the Prophet ﷺ teach Aishah (RA) for Laylat al-Qadr—and every moment seeking pardon?',
    optionsEn: [
      'Allahumma innaka ‘afuwwun tuhibbul-‘afwa fa‘fu ‘anni',
      'Allahumma barik lana fi Rajab',
      'Rabbi ishrah li sadri',
      'Salawat Ibrahimiyyah',
    ],
    correctIndex: 0,
    explanationEn:
        '“O Allah, You are Pardoning and love to pardon, so pardon me completely.”',
    reference: 'Sunan al-Tirmidhi 3513',
  ),
  QuizQuestion(
    id: 'q_duas_14',
    doorId: 'duas',
    questionEn:
        'Which morning dua recited by the Prophet ﷺ after Fajr specifically asks Allah for beneficial knowledge (“Ilm”)?',
    optionsEn: [
      'Dua al-Qunut',
      'Dua of Sulayman',
      'Allahumma inni as’aluka ‘ilman nafi‘an, wa rizqan tayyiban, wa ‘amalan mutaqabbalan',
      'Dua for entering sleep',
    ],
    correctIndex: 2,
    explanationEn:
        'Asking each morning for beneficial Ilm, pure lawful provision, and accepted deeds mirrors the very mission of Duya’s Ilm Challenge!',
    reference: 'Sunan Ibn Majah 925',
  ),
  QuizQuestion(
    id: 'q_duas_15',
    doorId: 'duas',
    questionEn:
        'What touching prayer of Prophet Ibrahim (AS) near the Kaaba valley continues to be answered for pilgrims today (Surah 14:37)?',
    optionsEn: [
      'Send snow to Makkah',
      '“Make hearts of people incline lovingly toward them and provide them with fruits”',
      'Keep visitors away from the valley',
      'Build stone palaces only',
    ],
    correctIndex: 1,
    explanationEn:
        'Every believer’s longing for Makkah and the endless fresh fruit in Haram markets echo Ibrahim’s (AS) timeless dua.',
    reference: 'Surah Ibrahim 14:37',
  ),
  QuizQuestion(
    id: 'q_duas_16',
    doorId: 'duas',
    questionEn:
        'Which combination of spiritual states is renowned in Hadith for eagerly accepted duas?',
    optionsEn: [
      'Only while arguing',
      'During oversleeping',
      'Only on weekdays',
      'While traveling, in prostration (Sujud), and on the Day of Arafah',
    ],
    correctIndex: 3,
    explanationEn:
        'Umrah and Hajj pilgrims carry a special blessing—both their journey and moments in Sujud at the Haramain are prime times for dua.',
    reference: 'Sahih Muslim 482 / Tirmidhi 1905',
  ),
  QuizQuestion(
    id: 'q_duas_17',
    doorId: 'duas',
    questionEn:
        'What humble etiquette accompanies drinking Zamzam inside Al-Masjid al-Haram?',
    optionsEn: [
      'Say Bismillah, drink calmly in three breaths, make dua & praise Allah',
      'Pour it onto shoes',
      'Drink silently without intention',
      'Discard half the cup',
    ],
    correctIndex: 0,
    explanationEn:
        'Drinking Zamzam mindfully—stopping to breathe and thanking Allah—refreshes both body and soul.',
    reference: 'Sahih al-Bukhari / Sunan Etiquette',
  ),
  QuizQuestion(
    id: 'q_duas_18',
    doorId: 'duas',
    questionEn:
        'Which famous Qur’anic dua of Prophet Yunus (AS) was praised by the Prophet ﷺ as answered whenever a distressed believer invokes it?',
    optionsEn: [
      'Rabbi la tadharni farda',
      'Hasbunallah',
      'La ilaha illa Anta subhanaka inni kuntu minaz-zalimin',
      'Qad aflaha man tazakka',
    ],
    correctIndex: 2,
    explanationEn:
        'Affirming Allah’s transcendence alongside personal humility unlocks divine relief in hardship.',
    reference: 'Surah Al-Anbiya 21:87 / Tirmidhi 3505',
  ),
  QuizQuestion(
    id: 'q_duas_19',
    doorId: 'duas',
    questionEn:
        'Inside Duya’s Duas & Athkar hub, what interactive helper supports daily remembrance alongside pilgrimage supplications?',
    optionsEn: [
      'Flight seat picker',
      'Interactive Digital Tasbih & Morning/Evening Athkar checklists',
      'Currency calculator only',
      'Hotel invoice exporter',
    ],
    correctIndex: 1,
    explanationEn:
        'Duya pairs categorized pilgrimage duas (Ihram, Tawaf, Sa‘i, Travel) with a soothing haptic-style Tasbih counter.',
    reference: 'Duya Duas & Tasbih Hub',
  ),
  QuizQuestion(
    id: 'q_duas_20',
    doorId: 'duas',
    questionEn:
        'When bringing sacred Zamzam water home for loved ones, what warm Sunnah intention completes the gift?',
    optionsEn: [
      'Selling it at high markup',
      'Hiding it permanently untouched',
      'Mixing it with soda',
      'Sharing freely while praying for barakah, healing (Shifa), and beneficial Ilm',
    ],
    correctIndex: 3,
    explanationEn:
        'Sharing Zamzam water hospitably spreads the blessings of Makkah to family, elders, and neighbors back home.',
    reference: 'Islamic Pilgrimage Tradition',
  ),
];
