class AuthUser {
  final String id;
  final String email;

  const AuthUser({required this.id, required this.email});
}

class AuthState {
  final AuthUser? user;
  final bool isLoading;
  final String? errorMessage;

  const AuthState({this.user, this.isLoading = false, this.errorMessage});

  AuthState copyWith({AuthUser? user, bool? isLoading, String? errorMessage}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

// Services domain models
enum ServiceCategory {
  dining,
  kitchen,
  bathroom,
  balcony,
  rooms,
  dogWalking,
  package,
}

class ServiceItem {
  final String id;
  final ServiceCategory category;
  final String name;
  final int minPrice;
  final int? maxPrice; // for ranges like packages
  final String description;
  final String estimatedTime; // e.g., "30-45 min"

  const ServiceItem({
    required this.id,
    required this.category,
    required this.name,
    required this.minPrice,
    this.maxPrice,
    required this.description,
    required this.estimatedTime,
  });

  String get displayPrice => maxPrice != null ? '₹$minPrice-₹$maxPrice' : '₹$minPrice';
}

class ServiceCatalog {
  static const List<ServiceItem> items = [
    // Dining Place
    ServiceItem(
      id: 'dining_floor',
      category: ServiceCategory.dining,
      name: 'Dining Floor',
      minPrice: 69,
      description: 'Sweep, mop and sanitize dining area flooring.',
      estimatedTime: '20-30 min',
    ),
    ServiceItem(
      id: 'dining_table',
      category: ServiceCategory.dining,
      name: 'Dining Table',
      minPrice: 29,
      description: 'Clean and disinfect table surface and legs.',
      estimatedTime: '10-15 min',
    ),
    ServiceItem(
      id: 'dining_sofa',
      category: ServiceCategory.dining,
      name: 'Dining Sofa',
      minPrice: 49,
      description: 'Vacuum, wipe and spot-clean upholstery.',
      estimatedTime: '20-30 min',
    ),
    ServiceItem(
      id: 'dining_wm',
      category: ServiceCategory.dining,
      name: 'Washing Machine',
      minPrice: 49,
      description: 'Exterior wipe, lint trap and adjacent area clean-up.',
      estimatedTime: '15-20 min',
    ),
    ServiceItem(
      id: 'dining_full',
      category: ServiceCategory.dining,
      name: 'Full Dining',
      minPrice: 199,
      description: 'Complete dining area cleaning incl. floor, table and seating.',
      estimatedTime: '40-60 min',
    ),

    // Kitchen
    ServiceItem(
      id: 'kitchen_sink_slab',
      category: ServiceCategory.kitchen,
      name: 'Sink & Slab',
      minPrice: 99,
      description: 'Degrease sink and countertop; disinfect and polish.',
      estimatedTime: '20-30 min',
    ),
    ServiceItem(
      id: 'kitchen_light_ceiling',
      category: ServiceCategory.kitchen,
      name: 'Light & Ceiling',
      minPrice: 39,
      description: 'Dust and wipe lighting fixtures and ceiling surfaces.',
      estimatedTime: '10-15 min',
    ),
    ServiceItem(
      id: 'kitchen_chimney',
      category: ServiceCategory.kitchen,
      name: 'Chimney',
      minPrice: 149,
      description: 'Exterior degreasing; basic filter clean if removable.',
      estimatedTime: '25-35 min',
    ),
    ServiceItem(
      id: 'kitchen_microwave_stove',
      category: ServiceCategory.kitchen,
      name: 'Microwave/Stove',
      minPrice: 119,
      description: 'Wipe interior (microwave) and stovetop degrease & polish.',
      estimatedTime: '20-30 min',
    ),
    ServiceItem(
      id: 'kitchen_fridge_basic',
      category: ServiceCategory.kitchen,
      name: 'Fridge (Basic)',
      minPrice: 149,
      description: 'Exterior clean and handle/door seal wipe.',
      estimatedTime: '15-20 min',
    ),
    ServiceItem(
      id: 'kitchen_fridge_deep',
      category: ServiceCategory.kitchen,
      name: 'Fridge (Deep)',
      minPrice: 249,
      description: 'Interior shelves wipe, exterior polish and seal detail.',
      estimatedTime: '35-50 min',
    ),

    // Bathroom
    ServiceItem(
      id: 'bathroom_toilet',
      category: ServiceCategory.bathroom,
      name: 'Toilet',
      minPrice: 199,
      description: 'Toilet bowl, seat and exterior disinfecting and descaling.',
      estimatedTime: '20-30 min',
    ),
    ServiceItem(
      id: 'bathroom_floor_sink',
      category: ServiceCategory.bathroom,
      name: 'Floor & Sink',
      minPrice: 99,
      description: 'Floor scrubbing and sink cleaning with sanitization.',
      estimatedTime: '20-30 min',
    ),
    ServiceItem(
      id: 'bathroom_light_exhaust',
      category: ServiceCategory.bathroom,
      name: 'Light & Exhaust',
      minPrice: 299,
      description: 'Dust and clean lights; exhaust exterior deep clean.',
      estimatedTime: '20-30 min',
    ),

    // Balcony
    ServiceItem(
      id: 'balcony_floor',
      category: ServiceCategory.balcony,
      name: 'Balcony Floor',
      minPrice: 49,
      description: 'Sweep and mop balcony floor; remove stains if possible.',
      estimatedTime: '15-20 min',
    ),
    ServiceItem(
      id: 'balcony_grill',
      category: ServiceCategory.balcony,
      name: 'Balcony Grill',
      minPrice: 49,
      description: 'Dust and wipe railing/grill surfaces.',
      estimatedTime: '10-15 min',
    ),

    // Rooms
    ServiceItem(
      id: 'rooms_ceiling',
      category: ServiceCategory.rooms,
      name: 'Ceiling (Walls & Fan)',
      minPrice: 69,
      description: 'High-reach dusting of walls and fan; wipe accessible areas.',
      estimatedTime: '20-30 min',
    ),
    ServiceItem(
      id: 'rooms_floors',
      category: ServiceCategory.rooms,
      name: 'Floors',
      minPrice: 49,
      description: 'Vacuum/sweep and mop room flooring.',
      estimatedTime: '20-30 min',
    ),
    ServiceItem(
      id: 'rooms_window',
      category: ServiceCategory.rooms,
      name: 'Window',
      minPrice: 29,
      description: 'Window glass and frame wipe (interior side).',
      estimatedTime: '10-15 min',
    ),
    ServiceItem(
      id: 'rooms_bed',
      category: ServiceCategory.rooms,
      name: 'Bed',
      minPrice: 49,
      description: 'Bed frame dusting and side-table wipe; linen not included.',
      estimatedTime: '10-15 min',
    ),
    ServiceItem(
      id: 'rooms_almirah',
      category: ServiceCategory.rooms,
      name: 'Almirah',
      minPrice: 49,
      description: 'Exterior wipe and handle/panel polish.',
      estimatedTime: '10-15 min',
    ),

    // Dog Walking
    ServiceItem(
      id: 'dog_single',
      category: ServiceCategory.dogWalking,
      name: 'Single Dog',
      minPrice: 199,
      description: 'Leashed walk with water break; route per owner guidance.',
      estimatedTime: '20-30 min',
    ),
    ServiceItem(
      id: 'dog_two',
      category: ServiceCategory.dogWalking,
      name: 'Two Dogs',
      minPrice: 349,
      description: 'Paired walk with safety; paced for both dogs.',
      estimatedTime: '20-30 min',
    ),

    // Packages
    ServiceItem(
      id: 'pkg_1bhk',
      category: ServiceCategory.package,
      name: '1 BHK Full Combo',
      minPrice: 1559,
      maxPrice: 1669,
      description: 'Comprehensive cleaning for 1 BHK incl. kitchen, bath, rooms.',
      estimatedTime: '3-4 hrs',
    ),
    ServiceItem(
      id: 'pkg_2bhk',
      category: ServiceCategory.package,
      name: '2 BHK Full Combo',
      minPrice: 2199,
      maxPrice: 2299,
      description: 'Full home cleaning for 2 BHK with kitchen & bathrooms.',
      estimatedTime: '4-5 hrs',
    ),
    ServiceItem(
      id: 'pkg_3bhk',
      category: ServiceCategory.package,
      name: '3 BHK Full Combo',
      minPrice: 2699,
      maxPrice: 2999,
      description: 'Deep clean for 3 BHK across all rooms and utilities.',
      estimatedTime: '5-6 hrs',
    ),
  ];

  static List<ServiceItem> byCategory(ServiceCategory category) =>
      items.where((e) => e.category == category).toList(growable: false);
}


