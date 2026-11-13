import 'package:flutter/foundation.dart';

import '../../domain/models/journey_models.dart';

/// Repository for Journey travel offers, heritage dining, attractions,
/// user bookings, and AI trip itinerary generation.
class JourneyRepository extends ChangeNotifier {
  final List<TripBooking> _bookings = [
    const TripBooking(
      id: 'bk_seed_1',
      type: 'Hotel',
      title: 'Dar Al-Taqwa Madinah',
      subtitle: '2 min walk to Al-Rawdah Gate • 3 Nights',
      dateLabel: '14–17 Shawwal',
      referenceCode: 'DY-HTL-8412',
      status: 'Confirmed',
      totalSar: 2850,
    ),
  ];

  List<TripBooking> get bookings => List.unmodifiable(_bookings);

  List<FlightOffer> get flights => const [
        FlightOffer(
          id: 'flt_1',
          airline: 'Saudia Airlines',
          flightCode: 'SV 805',
          fromCode: 'DAC',
          toCode: 'JED',
          departureTime: '02:15 AM',
          arrivalTime: '06:30 AM',
          duration: '7h 15m',
          cabinClass: 'Economy',
          priceSar: 1680,
          stopsLabel: 'Direct',
        ),
        FlightOffer(
          id: 'flt_2',
          airline: 'Flynas',
          flightCode: 'XY 512',
          fromCode: 'RUH',
          toCode: 'MED',
          departureTime: '09:45 AM',
          arrivalTime: '11:20 AM',
          duration: '1h 35m',
          cabinClass: 'Economy',
          priceSar: 320,
          stopsLabel: 'Direct',
        ),
        FlightOffer(
          id: 'flt_3',
          airline: 'Qatar Airways',
          flightCode: 'QR 1184',
          fromCode: 'LHR',
          toCode: 'JED',
          departureTime: '08:40 AM',
          arrivalTime: '07:10 PM',
          duration: '8h 30m',
          cabinClass: 'Business',
          priceSar: 5420,
          stopsLabel: '1 Stop (DOH)',
        ),
      ];

  List<HotelOffer> get hotels => const [
        HotelOffer(
          id: 'htl_makkah_1',
          name: 'Jabal Omar Conrad Makkah',
          city: 'Makkah',
          distanceToHaram: '120m to King Fahd Gate',
          rating: 4.9,
          reviewCount: 2410,
          pricePerNightSar: 1120,
          amenities: ['Haram View', 'Prayer Audio', 'Breakfast', 'Family Suite'],
          description:
              'Steps from Al-Masjid Al-Haram plaza with direct elevator access and live Haram audio in rooms.',
          accentHex: 0xFF15634C,
        ),
        HotelOffer(
          id: 'htl_madinah_1',
          name: 'Anwar Al-Madinah Mövenpick',
          city: 'Madinah',
          distanceToHaram: '80m to Ladies Gate 25',
          rating: 4.8,
          reviewCount: 1890,
          pricePerNightSar: 790,
          amenities: ['Al-Rawdah Access', 'Direct Mall Link', 'Breakfast'],
          description:
              'Ideal for families visiting Al-Masjid An-Nabawi, located right beside the northern courtyard.',
          accentHex: 0xFF0E4D3B,
        ),
        HotelOffer(
          id: 'htl_makkah_2',
          name: 'Voco Makkah by IHG',
          city: 'Makkah',
          distanceToHaram: '1.2 km • 24/7 Shuttle',
          rating: 4.6,
          reviewCount: 1120,
          pricePerNightSar: 410,
          amenities: ['Free Shuttle', 'Halal Dining', 'High-Speed Wi-Fi'],
          description:
              'Modern value stay with dedicated air-conditioned shuttle buses operating every 5 minutes.',
          accentHex: 0xFF7B5E3B,
        ),
      ];

  List<PlaceItem> get places => const [
        PlaceItem(
          id: 'plc_abu_zaid',
          name: 'Abu Zaid Heritage',
          category: 'Heritage Restaurants',
          city: 'Makkah',
          distanceLabel: '1.4 km from Haram',
          rating: 4.7,
          description:
              'Beloved Hijazi breakfast & traditional ma‘soub, mutabbaq, and spiced tea served since 1966.',
          signatureNote: 'Famous for Royal Ma‘soub & Fresh Foul',
          accentHex: 0xFF0E4D3B,
        ),
        PlaceItem(
          id: 'plc_abu_osaid',
          name: 'Abu Osaid',
          category: 'Heritage Restaurants',
          city: 'Madinah',
          distanceLabel: '900m from Nabawi',
          rating: 4.8,
          description:
              'Warm wooden Hijazi interior offering authentic Madani mandi, kabsa, and traditional hospitality.',
          signatureNote: 'Traditional Floor Seating & Madani Mandi',
          accentHex: 0xFF7B5E3B,
        ),
        PlaceItem(
          id: 'plc_khayal',
          name: 'Khayal Restaurant',
          category: 'Restaurants',
          city: 'Jeddah / Makkah',
          distanceLabel: '2.1 km',
          rating: 4.8,
          description:
              'Contemporary Levantine & charcoal-grilled platters ideal for families after Umrah.',
          signatureNote: 'Fresh Tandoor Bread & Mixed Grills',
          accentHex: 0xFF247A64,
        ),
        PlaceItem(
          id: 'plc_quba',
          name: 'Masjid Quba',
          category: 'Ziyarat',
          city: 'Madinah',
          distanceLabel: '3.5 km South',
          rating: 5.0,
          description:
              'The first mosque built in Islam. Performing two rak‘ahs there in purity carries the reward of an Umrah.',
          signatureNote: 'Connected via Quba Walking Boulevard',
          accentHex: 0xFF8D6A32,
        ),
        PlaceItem(
          id: 'plc_hira',
          name: 'Hira Cultural District',
          category: 'Ziyarat',
          city: 'Makkah',
          distanceLabel: '4.8 km East',
          rating: 4.9,
          description:
              'Revelation Exhibition at the foot of Jabal Al-Nour illuminating the history of the Noble Qur’an.',
          signatureNote: 'Interactive Revelation Museum',
          accentHex: 0xFFC99A3B,
        ),
      ];

  List<AttractionItem> get attractions => const [
        AttractionItem(
          id: 'clock_tower_museum',
          title: 'Clock Tower Museum',
          city: 'Makkah',
          subtitle: 'Observatory & Origins of Timekeeping',
          description:
              'An experience that takes you through the origins of the universe, the history of Islamic astronomy and timekeeping, and the intricate details of the world’s largest clock culminating in a breathtaking panoramic view of the Kaaba.',
          ticketPriceSar: 150,
          highlights: [
            'Floor 1: Universe & Solar System Gallery',
            'Floor 2: Islamic Crescent Sighting & Astrolabes',
            'Floor 3: Inside the Makkah Royal Clock Mechanism',
            'Floor 4: Open-air Balcony Overlooking the Kaaba',
          ],
          availableSlots: [
            '10:00 AM',
            '01:30 PM',
            '04:30 PM (Asr View)',
            '08:00 PM (Night Lights)',
          ],
          accentHex: 0xFF7B5E3B,
        ),
        AttractionItem(
          id: 'seerah_museum',
          title: 'As-Salam Museum & Seerah',
          city: 'Madinah',
          subtitle: 'Immersive Prophetic Biography Exhibition',
          description:
              'Interactive 3D architectural models of Madinah during the Prophetic era, bringing the Hijrah and Al-Masjid An-Nabawi’s evolution to life.',
          ticketPriceSar: 45,
          highlights: [
            '3D Scale Model of Prophetic Madinah',
            'Multilingual Guided Audio Tours',
            'Minutes away from Gate 338',
          ],
          availableSlots: ['09:00 AM', '11:30 AM', '05:00 PM'],
          accentHex: 0xFF0E4D3B,
        ),
      ];

  AttractionItem getAttractionById(String id) {
    return attractions.firstWhere(
      (a) => a.id == id,
      orElse: () => attractions.first,
    );
  }

  TripBooking addBooking({
    required String type,
    required String title,
    required String subtitle,
    required String dateLabel,
    required double totalSar,
  }) {
    final booking = TripBooking(
      id: 'bk_${DateTime.now().millisecondsSinceEpoch}',
      type: type,
      title: title,
      subtitle: subtitle,
      dateLabel: dateLabel,
      referenceCode: 'DY-${type.substring(0, 3).toUpperCase()}-${1000 + _bookings.length * 47}',
      status: 'Confirmed',
      totalSar: totalSar,
    );
    _bookings.insert(0, booking);
    notifyListeners();
    return booking;
  }

  List<TripItineraryDay> buildItinerary({
    required int totalDays,
    required String pace,
    required bool includeClockTower,
  }) {
    final days = <TripItineraryDay>[];
    final makkahDays = (totalDays / 2).ceil();
    for (var i = 1; i <= totalDays; i++) {
      final inMakkah = i <= makkahDays;
      if (inMakkah) {
        days.add(
          TripItineraryDay(
            dayNumber: i,
            city: 'Makkah',
            focusTitle: i == 1
                ? 'Arrival & Umrah Devotion'
                : (i == 2 && includeClockTower)
                    ? 'Haram Prayers & Clock Tower Museum'
                    : 'Tawaf, Qur’an & Heritage Dining',
            activities: i == 1
                ? [
                    'Enter Ihram before Miqat & check into Haram-view hotel.',
                    'Perform Umrah via Motawef step-by-step guide.',
                    'Rest & dinner at Abu Zaid Heritage.',
                  ]
                : [
                    'Fajr prayer in Al-Masjid Al-Haram & Morning Athkar.',
                    if (i == 2 && includeClockTower)
                      'Visit Clock Tower Museum (Asr panoramic slot).'
                    else
                      'Visit Hira Cultural District & Revelation Exhibition.',
                    'Voluntary Tawaf & Zamzam reflection before Isha.',
                  ],
          ),
        );
      } else {
        final madinahDay = i - makkahDays;
        days.add(
          TripItineraryDay(
            dayNumber: i,
            city: 'Madinah',
            focusTitle: madinahDay == 1
                ? 'Haramain High-Speed Rail & Al-Rawdah'
                : 'Masjid Quba & Prophetic Seerah ($pace)',
            activities: madinahDay == 1
                ? [
                    'Morning Haramain Train from Makkah to Madinah.',
                    'Check in near Al-Masjid An-Nabawi & offer Salawat.',
                    'Attend scheduled Al-Rawdah Al-Sharifah prayer slot.',
                  ]
                : [
                    'Walk Quba Boulevard in wudu to pray at Masjid Quba.',
                    'Explore As-Salam Seerah Exhibition.',
                    'Family lunch at Abu Osaid Heritage Restaurant.',
                  ],
          ),
        );
      }
    }
    return days;
  }
}
