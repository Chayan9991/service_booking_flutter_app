List<Map<String, dynamic>> categories = [
  {
    "categoryId": 1,
    "category": "AC Services",
    "icon": "assets/icons/ac_services.png",
    "basePrice": "20",
    "details":
        "Get your AC installed, repaired, or serviced by expert technicians.",
  },
  {
    "categoryId": 2,
    "category": "Cleaning",
    "icon": "assets/icons/cleaning_services.png",
    "basePrice": "10",
    "details": "Complete cleaning solutions for your home, car, and more.",
  },
  {
    "categoryId": 3,
    "category": "Painters",
    "icon": "assets/icons/painting_services.png",
    "basePrice": "30",
    "details":
        "Give your home or office a new look with professional painting services.",
  },
  {
    "categoryId": 4,
    "category": "Electrician",
    "icon": "assets/icons/electrician.png",
    "basePrice": "15",
    "details":
        "Certified electricians for all wiring, installation, and repair needs.",
  },
  {
    "categoryId": 5,
    "category": "Pest Control",
    "icon": "assets/icons/pest_control.png",
    "basePrice": "30",
    "details":
        "Protect your home from pests with expert extermination services.",
  },
  {
    "categoryId": 6,
    "category": "Appliance Service",
    "icon": "assets/icons/appliance_repair.png",
    "basePrice": "20",
    "details": "Repair and maintenance services for all home appliances.",
  },
  {
    "categoryId": 7,
    "category": "Home Assistant",
    "icon": "assets/icons/home_assist.png",
    "basePrice": "10",
    "details": "Reliable professionals for home maintenance and daily help.",
  },
];

List<Map<String, dynamic>> services = [
  // AC Services
  {
    "id": 101,
    "categoryId": 1,
    "name": "AC Installation",
    "price": "50/unit",
    "discount": 10, 
    "estimatedTime": "2 hours",
    "rating": 4.7,
    "reviews": 120,
    "isPopular": false,
    "imageUrl":
        "https://images.pexels.com/photos/5463576/pexels-photo-5463576.jpeg",
    "details": "Professional AC installation ensuring safety and efficiency.",
  },
  {
    "id": 102,
    "categoryId": 1,
    "name": "AC Repair",
    "price": "30/service",
    "discount": 5,
    "estimatedTime": "1 hour",
    "rating": 4.5,
    "reviews": 85,
    "isPopular": false,
    "imageUrl":
        "https://images.pexels.com/photos/5463581/pexels-photo-5463581.jpeg",
    "details": "Fixing cooling issues, leaks, and other AC malfunctions.",
  },
  {
    "id": 103,
    "categoryId": 1,
    "name": "Gas Refilling",
    "price": "40/refill",
    "discount": 15,
    "estimatedTime": "45 minutes",
    "rating": 4.8,
    "reviews": 150,
    "isPopular": false,
    "imageUrl":
        "https://images.pexels.com/photos/3964537/pexels-photo-3964537.jpeg",
    "details": "Top-up your AC gas to restore cooling efficiency.",
  },

  // Cleaning Services
  {
    "id": 201,
    "categoryId": 2,
    "name": "Home Cleaning",
    "price": "50/session",
    "discount": 20,
    "estimatedTime": "3 hours",
    "rating": 4.6,
    "reviews": 200,
    "isPopular": true,
    "imageUrl":
        "https://images.pexels.com/photos/4239040/pexels-photo-4239040.jpeg",
    "details": "Deep cleaning service for a spotless and fresh home.",
  },
  {
    "id": 202,
    "categoryId": 2,
    "name": "Car Cleaning",
    "price": "15/wash",
    "discount": 10,
    "estimatedTime": "1 hour",
    "rating": 4.3,
    "reviews": 75,
    "isPopular": false,
    "imageUrl":
        "https://images.pexels.com/photos/6872150/pexels-photo-6872150.jpeg",
    "details": "Interior and exterior cleaning for your car.",
  },
  {
    "id": 203,
    "categoryId": 2,
    "name": "Sofa Cleaning",
    "price": "25/sofa",
    "discount": 12,
    "estimatedTime": "1.5 hours",
    "rating": 4.4,
    "reviews": 90,
    "isPopular": false,
    "imageUrl":
        "https://images.pexels.com/photos/4098778/pexels-photo-4098778.jpeg",
    "details": "Get your sofa cleaned and refreshed with professional care.",
  },

  // Painters
  {
    "id": 301,
    "categoryId": 3,
    "name": "Interior Painting",
    "price": "100/room",
    "discount": 10,
    "estimatedTime": "5 hours",
    "rating": 4.7,
    "reviews": 95,
    "isPopular": false,
    "imageUrl":
        "https://images.pexels.com/photos/5798978/pexels-photo-5798978.jpeg",
    "details": "Enhance your interiors with high-quality paints and finishes.",
  },
  {
    "id": 302,
    "categoryId": 3,
    "name": "Exterior Painting",
    "price": "200/wall",
    "discount": 15,
    "estimatedTime": "6 hours",
    "rating": 4.8,
    "reviews": 110,
    "isPopular": false,
    "imageUrl":
        "https://images.pexels.com/photos/5799130/pexels-photo-5799130.jpeg",
    "details": "Weather-resistant painting to protect and beautify your walls.",
  },

  // Electrician
  {
    "id": 401,
    "categoryId": 4,
    "name": "Wiring & Installations",
    "price": "25/point",
    "discount": 8,
    "estimatedTime": "2 hours",
    "rating": 4.7,
    "reviews": 140,
    "isPopular": true,
    "imageUrl":
        "https://images.pexels.com/photos/29871587/pexels-photo-29871587.jpeg",
    "details": "Safe and efficient wiring solutions for homes and offices.",
  },
  {
    "id": 402,
    "categoryId": 4,
    "name": "Switchboard Repair",
    "price": "20/repair",
    "discount": 5,
    "estimatedTime": "1 hour",
    "rating": 4.5,
    "reviews": 110,
    "isPopular": false,
    "imageUrl":
        "https://images.pexels.com/photos/257736/pexels-photo-257736.jpeg",
    "details": "Fix faulty switchboards and ensure safe electricity flow.",
  },

  // Pest Control
  {
    "id": 501,
    "categoryId": 5,
    "name": "Cockroach Control",
    "price": "40/session",
    "discount": 12,
    "estimatedTime": "2 hours",
    "rating": 4.6,
    "reviews": 130,
    "isPopular": false,
    "imageUrl":
        "https://images.pexels.com/photos/4097735/pexels-photo-4097735.jpeg",
    "details": "Effective solutions to eliminate cockroach infestations.",
  },
  {
    "id": 502,
    "categoryId": 5,
    "name": "Bed Bug Treatment",
    "price": "60/room",
    "discount": 18,
    "estimatedTime": "3 hours",
    "rating": 4.7,
    "reviews": 140,
    "isPopular": false,
    "imageUrl":
        "https://images.pexels.com/photos/4098576/pexels-photo-4098576.jpeg",
    "details": "Get rid of bed bugs with professional pest control treatment.",
  },

  // Appliance Services
  {
    "id": 601,
    "categoryId": 6,
    "name": "Washing Machine Repair",
    "price": "40/service",
    "discount": 10,
    "estimatedTime": "2 hours",
    "rating": 4.6,
    "reviews": 130,
    "isPopular": true,
    "imageUrl":
        "https://images.pexels.com/photos/4700389/pexels-photo-4700389.jpeg",
    "details":
        "Fixing leaks, drum issues, and electrical faults in washing machines.",
  },
  {
    "id": 602,
    "categoryId": 6,
    "name": "TV Repair",
    "price": "50/service",
    "discount": 15,
    "estimatedTime": "2.5 hours",
    "rating": 4.7,
    "reviews": 100,
    "isPopular": true,
    "imageUrl":
        "https://images.pexels.com/photos/30425504/pexels-photo-30425504.jpeg",
    "details": "Screen, speaker, and motherboard repairs for all TV brands.",
  },

  // Home Assistant
  {
    "id": 701,
    "categoryId": 7,
    "name": "Plumbing Services",
    "price": "10/hour",
    "discount": 5,
    "estimatedTime": "1.5 hours",
    "rating": 4.5,
    "reviews": 80,
    "isPopular": true,
    "imageUrl":
        "https://images.pexels.com/photos/6263144/pexels-photo-6263144.jpeg",
    "details": "Leak repairs, pipe fittings, and bathroom installations.",
  },
  {
    "id": 702,
    "categoryId": 7,
    "name": "Carpentry Services",
    "price": "15/hour",
    "discount": 7,
    "estimatedTime": "2 hours",
    "rating": 4.6,
    "reviews": 90,
    "isPopular": false,
    "imageUrl":
        "https://images.pexels.com/photos/5974408/pexels-photo-5974408.jpeg",
    "details": "Furniture repair, door fittings, and custom woodwork.",
  },
  {
    "id": 703,
    "categoryId": 7,
    "name": "Gardening",
    "price": "20/session",
    "discount": 10,
    "estimatedTime": "2.5 hours",
    "rating": 4.8,
    "reviews": 120,
    "isPopular": false,
    "imageUrl":
        "https://images.pexels.com/photos/5230937/pexels-photo-5230937.jpeg",
    "details": "Landscaping, plant maintenance, and garden cleaning.",
  },
];
