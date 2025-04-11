import 'package:better_breaks/data/models/break_models.dart';
import 'package:better_breaks/shared/app_images.dart';

class EventRepository {
  // Get all events
  List<Event> getAllEvents() {
    return _events;
  }

  // Get events filtered by category
  List<Event> getEventsByCategory(String category) {
    if (category == 'All') {
      return _events;
    } else if (category == 'Top picks') {
      return _events.where((event) => event.isTopPick).toList();
    } else {
      return _events
          .where((event) => event.categories.contains(category))
          .toList();
    }
  }

  // Search events by query
  List<Event> searchEvents(String query) {
    final queryLower = query.toLowerCase();
    return _events
        .where((event) =>
            event.title.toLowerCase().contains(queryLower) ||
            event.location.toLowerCase().contains(queryLower))
        .toList();
  }

  // Private list of sample events
  final List<Event> _events = [
    Event(
      image: AppImageData.image7,
      title: 'Chelsea vs Arsenal Premier League Match',
      location: 'Stamford Bridge Stadium, London',
      date: 'Sat, 20 Aug • 3:00 PM',
      price: '\$60',
      isFullWidth: true,
      categories: ['Top picks', 'Sports'],
      isTopPick: true,
      description:
          'Experience the excitement of Premier League football with this London derby. Watch Chelsea take on Arsenal in a crucial match that could determine the top four positions. Enjoy the electric atmosphere at Stamford Bridge as two of England\'s biggest clubs battle it out on the pitch.',
    ),
    Event(
      image: AppImageData.image5,
      title: 'Jazz Night at The Blue Note',
      location: 'The Blue Note, London',
      date: 'Fri, 15 Jul • 8:00 PM',
      price: '\$25',
      isFullWidth: true,
      categories: ['Top picks', 'Music'],
      isTopPick: true,
      description:
          'Join us for an unforgettable night of jazz featuring some of London\'s finest musicians. From classic standards to contemporary compositions, the evening promises to be a journey through the rich tapestry of jazz.',
    ),
    Event(
      image: AppImageData.image8,
      title: 'Yoga in the Park',
      location: 'Hyde Park, London',
      date: 'Sun, 17 Jul • 9:00 AM',
      price: '\$10',
      isFullWidth: false,
      categories: ['Health'],
      isTopPick: true,
      description:
          'Start your Sunday with a rejuvenating yoga session in the heart of Hyde Park. Suitable for all levels, this class blends traditional yoga practices with mindfulness techniques for a holistic wellness experience.',
    ),
    Event(
      image: AppImageData.image4,
      title: 'Tennis Finals: London Championships',
      location: 'Queen\'s Club, London',
      date: 'Sun, 28 Aug • 1:00 PM',
      price: '\$45',
      isFullWidth: false,
      categories: ['Sports'],
      isTopPick: false,
      description:
          'Watch the finals of the prestigious London Championships at the iconic Queen\'s Club. See world-class tennis players compete for one of the most coveted grass-court titles in an elegant setting with a rich sporting history.',
    ),
    Event(
      image: AppImageData.image4,
      title: 'Art Exhibition: Modern Masters',
      location: 'National Gallery, London',
      date: 'Sat, 16 Jul • 10:00 AM',
      price: '\$15',
      isFullWidth: false,
      categories: ['All'],
      isTopPick: false,
      description:
          'Explore the works of modern masters in this curated exhibition that spans the 20th and 21st centuries. From abstract expressionism to pop art, witness the evolution of contemporary artistic movements.',
    ),
    Event(
      image: AppImageData.image6,
      title: 'Food Festival',
      location: 'Southbank Centre, London',
      date: 'Sat, 23 Jul • 11:00 AM',
      price: '\$20',
      isFullWidth: true,
      categories: ['All', 'Top picks'],
      isTopPick: true,
      description:
          'A gastronomic celebration featuring diverse cuisines from around the world. Sample street food, artisanal products, and craft beverages while enjoying live cooking demonstrations from celebrated chefs.',
    ),
    Event(
      image: AppImageData.image7,
      title: 'Photography Workshop',
      location: 'Tate Modern, London',
      date: 'Sun, 30 Jul • 2:00 PM',
      price: '\$30',
      isFullWidth: false,
      categories: ['All'],
      isTopPick: false,
      description:
          'Enhance your photography skills in this hands-on workshop. Learn composition techniques, lighting principles, and post-processing tips from professional photographers in the inspiring setting of the Tate Modern.',
    ),
    Event(
      image: AppImageData.image8,
      title: 'Comedy Night',
      location: 'The Comedy Store, London',
      date: 'Fri, 21 Jul • 7:30 PM',
      price: '\$18',
      isFullWidth: false,
      categories: ['All'],
      isTopPick: false,
      description:
          'Laugh the night away with performances from both established comedians and rising stars. The Comedy Store\'s intimate venue creates the perfect atmosphere for an evening of humor and entertainment.',
    ),
    Event(
      image: AppImageData.image1,
      title: 'New Blockbuster Premiere',
      location: 'Picturehouse Cinema, London',
      date: 'Thu, 20 Jul • 7:00 PM',
      price: '\$18',
      isFullWidth: true,
      categories: ['Movies', 'Top picks'],
      isTopPick: true,
      description:
          'Be among the first to see this season\'s most anticipated blockbuster. The special premiere includes exclusive behind-the-scenes footage and a Q&A session with members of the cast and crew.',
    ),
    Event(
      image: AppImageData.image2,
      title: 'Indie Film Festival',
      location: 'BFI Southbank, London',
      date: 'Sat, 22 Jul • All Day',
      price: '\$45',
      isFullWidth: false,
      categories: ['Movies'],
      isTopPick: false,
      description:
          'An all-day celebration of independent cinema featuring award-winning shorts, documentaries, and feature films from around the world. The festival showcases emerging filmmakers pushing the boundaries of storytelling.',
    ),
    Event(
      image: AppImageData.image3,
      title: 'Classical Music Concert',
      location: 'Royal Albert Hall, London',
      date: 'Sun, 23 Jul • 7:30 PM',
      price: '\$35',
      isFullWidth: false,
      categories: ['Music'],
      isTopPick: false,
      description:
          'Experience the majesty of orchestral music in the iconic Royal Albert Hall. The program includes beloved works from Mozart, Beethoven, and Tchaikovsky performed by the London Philharmonic Orchestra.',
    ),
    Event(
      image: AppImageData.image4,
      title: 'Wellness Retreat Day',
      location: 'The Shard, London',
      date: 'Sat, 29 Jul • 10:00 AM',
      price: '\$80',
      isFullWidth: true,
      categories: ['Health'],
      isTopPick: true,
      description:
          'Escape the bustle of city life with a day dedicated to wellness and self-care. Enjoy panoramic views of London while participating in meditation sessions, wellness workshops, and nutritional consultations.',
    ),
  ];
}
