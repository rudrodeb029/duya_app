/// Immutable domain models for Journey travel: flights, hotels, restaurants,
/// Ziyarat places, attractions (e.g., Clock Tower Museum), bookings & itineraries.
class FlightOffer {
  const FlightOffer({
    required this.id,
    required this.airline,
    required this.flightCode,
    required this.fromCode,
    required this.toCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.cabinClass,
    required this.priceSar,
    required this.stopsLabel,
  });

  final String id;
  final String airline;
  final String flightCode;
  final String fromCode;
  final String toCode;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String cabinClass;
  final double priceSar;
  final String stopsLabel;
}

class HotelOffer {
  const HotelOffer({
    required this.id,
    required this.name,
    required this.city,
    required this.distanceToHaram,
    required this.rating,
    required this.reviewCount,
    required this.pricePerNightSar,
    required this.amenities,
    required this.description,
    required this.accentHex,
  });

  final String id;
  final String name;
  final String city; // 'Makkah' or 'Madinah'
  final String distanceToHaram;
  final double rating;
  final int reviewCount;
  final double pricePerNightSar;
  final List<String> amenities;
  final String description;
  final int accentHex;
}

class PlaceItem {
  const PlaceItem({
    required this.id,
    required this.name,
    required this.category, // 'Heritage Restaurants', 'Restaurants', 'Ziyarat'
    required this.city,
    required this.distanceLabel,
    required this.rating,
    required this.description,
    required this.signatureNote,
    required this.accentHex,
  });

  final String id;
  final String name;
  final String category;
  final String city;
  final String distanceLabel;
  final double rating;
  final String description;
  final String signatureNote;
  final int accentHex;
}

class AttractionItem {
  const AttractionItem({
    required this.id,
    required this.title,
    required this.city,
    required this.subtitle,
    required this.description,
    required this.ticketPriceSar,
    required this.highlights,
    required this.availableSlots,
    required this.accentHex,
  });

  final String id;
  final String title;
  final String city;
  final String subtitle;
  final String description;
  final double ticketPriceSar;
  final List<String> highlights;
  final List<String> availableSlots;
  final int accentHex;
}

class TripBooking {
  const TripBooking({
    required this.id,
    required this.type, // 'Flight', 'Hotel', 'Attraction', 'Permit'
    required this.title,
    required this.subtitle,
    required this.dateLabel,
    required this.referenceCode,
    required this.status,
    required this.totalSar,
  });

  final String id;
  final String type;
  final String title;
  final String subtitle;
  final String dateLabel;
  final String referenceCode;
  final String status;
  final double totalSar;
}

class TripItineraryDay {
  const TripItineraryDay({
    required this.dayNumber,
    required this.city,
    required this.focusTitle,
    required this.activities,
  });

  final int dayNumber;
  final String city;
  final String focusTitle;
  final List<String> activities;
}
