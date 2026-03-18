# Flutter Food Delivery App — Architecture Documentation

---

## Overview

This Flutter application is a food delivery clone (Zomato-style) built with a three-layer architecture: **UI Layer**, **Business Logic Layer**, and **Data Layer**. Each layer has a distinct responsibility, and together they form a clean, maintainable codebase.

---

## 1. UI Layer

The UI layer is everything the user sees and interacts with. It is composed of **screens** and **widgets** that render state and capture user input.

### Screens (`lib/screens/`)

| Screen | Purpose |
|--------|---------|
| `home_screen.dart` | Main entry point. Houses the tab bar (Home, Deals, Dining), sticky header with promo banner, category list, filter bar, restaurant carousel, and restaurant list. |
| `restaurant_details_screen.dart` | Displays a single restaurant's info, dish list, image carousel, and add-to-cart controls. |
| `search_screen.dart` | Full-screen search with voice input (speech-to-text), recent searches, category grid, and live filtered results. |
| `checkout_screen.dart` | Order review screen showing cart items, quantity controls, delivery address, payment method, and place order button. |
| `success_screen.dart` | Post-order Lottie animation screen that auto-navigates back to home after 3.5 seconds. |
| `profile_screen.dart` | User profile hub with sections for preferences, food delivery, and dining settings. |
| `edit_profile_screen.dart` | Editable form for name, email, mobile, DOB, anniversary, and gender with date picker integration. |
| `gold_screen.dart` | Zomato Gold membership screen showing savings, benefits, and coupon input. |
| `address_screen.dart` | Lists saved addresses and provides options to add or edit via map. |
| `add_edit_address_screen.dart` | Interactive map (FlutterMap + OpenStreetMap) with draggable pin for selecting delivery location, plus address form. |
| `location_screen.dart` | Search-based location picker using Nominatim API with debounced input. |
| `audio_call_screen.dart` | Zego UIKit screen for initiating voice calls by entering a target user ID. |

### Widgets (`lib/widgets/`)

| Widget | Purpose |
|--------|---------|
| `top_bar.dart` | App bar showing current delivery address (tappable) and profile avatar. Adapts text color for light/dark backgrounds. |
| `search_area.dart` | Search bar with mic icon and veg-mode toggle. Tapping navigates to `SearchScreen`. |
| `promo_banner.dart` | Auto-playing carousel of promotional banners with gradient backgrounds. |
| `category_list.dart` | Horizontally scrollable food category chips with a "See All" modal bottom sheet. |
| `filter_bar.dart` | Quick-filter chips (Near & Fast, Gourmet, Top Rated) and a Filters button that opens the filter bottom sheet. |
| `filter_bottom_sheet.dart` | Two-panel filter UI (left rail category nav, right scrollable content) for Sort, Time, Rating, Offers, Price, Trust Markers, and Collections. |
| `restaurant_carousel_section.dart` | 2-row horizontal carousel of compact restaurant cards. |
| `restaurant_list_section.dart` | Vertical list of full restaurant cards with image page-view, rating badge, offer info, and bookmark icon. |
| `restaurant_card.dart` | Compact restaurant card used in carousel sections. |
| `explore_more_section.dart` | Horizontal row of icon-based shortcut tiles (Offers, Food on Train, Gourmet, etc.). |
| `checkout_widgets.dart` | Modular checkout components: Gold header, special offer banner, delivery details row, cancellation policy. |
| `app_tab_bar.dart` | Custom floating pill-style tab bar with green active indicator. |
| `profile/profile_card.dart` | Dark-themed profile card showing name, email, Gold member status, and savings. |
| `profile/profile_list_item.dart` | Reusable list row for profile settings sections. |
| `profile/profile_section.dart` | Section container with green left-border title styling. |
| `profile/action_buttons.dart` | Two-button row for Zomato Money and Coupons. |
| `schedule_bottom_sheet.dart` | Date/time slot picker for scheduled delivery orders. |
| `selectable_box_option.dart` | Reusable selectable tile used in filter sheets. |

### Key UI Patterns

- **Sticky Animated Header**: `_StickyHeaderDelegate` in `home_screen.dart` implements a `SliverPersistentHeaderDelegate` that transitions the promo banner to a white search bar as the user scrolls.
- **Dynamic Bottom Navigation**: The floating tab bar and cart bar are toggled via `_isBottomNavVisible` state, which reacts to `UserScrollNotification`.
- **Adaptive Icon Colors**: `TopBar` accepts `isDarkBackground` to switch text and icon colors based on scroll position.
- **Responsive Layout**: `Responsive` utility switches between 1-column (mobile) and 2/3-column (tablet/desktop) grids.

---

## 2. Business Logic Layer

The business logic layer manages **state**, **user actions**, and **data transformations**. In this app, it is implemented through `ChangeNotifier` singletons, `ValueNotifier` globals, and in-screen `setState` calls.

### State Management

#### `CartManager` (`lib/models/cart_manager.dart`)
A singleton `ChangeNotifier` that is the central source of truth for the cart.

```
CartManager (singleton)
├── items: Map<Dish, int>          ← dish → quantity
├── currentRestaurant: Restaurant? ← which restaurant the cart belongs to
├── updateQuantity(dish, delta, restaurant) → updates quantity or clears cart
├── clear()                        → empties cart after order placement
├── totalBill: double              ← computed from items × prices
└── totalItems: int                ← sum of all quantities
```

Used with `ListenableBuilder` in `HomeScreen` to reactively show/hide the floating cart bar.

#### `ValueNotifier` Globals

| Notifier | Type | Defined In | Used For |
|----------|------|------------|----------|
| `currentAddressNotifier` | `ValueNotifier<AddressModel>` | `address_model.dart` | Active delivery address shown in TopBar and CheckoutScreen |
| `savedAddressesNotifier` | `ValueNotifier<List<AddressModel>>` | `address_model.dart` | Persisted list of user-saved addresses |
| `currentUserNotifier` | `ValueNotifier<UserProfile>` | `user_profile.dart` | User name, email, mobile, gender, saved amount |

All are consumed via `ValueListenableBuilder` for fine-grained rebuilds.

### Filter & Sort Logic

Implemented in `_getFilteredAndSortedRestaurants()` inside `HomeScreen`:

```
Input: List<Restaurant> _restaurants
Apply filters in order:
  1. Search query → match on restaurant name or dish names
  2. isPureVeg     → keep only isVeg == true restaurants
  3. maxDeliveryTime → parse minutes from time string and compare
  4. activeOffers  → match Buy1Get1, Gold (isPromoted), Deals (offer.isNotEmpty)
Sort:
  - "Rating"        → sort descending by rating
  - "Delivery Time" → sort ascending by parsed minutes
Output: filtered + sorted list passed to widgets
```

### Navigation & Intent Flow

- Deep navigation is handled with `Navigator.push` / `Navigator.pop` using `MaterialPageRoute`.
- After placing an order, `Navigator.pushReplacement` navigates to `SuccessScreen`, which calls `Navigator.pushAndRemoveUntil` to clear the stack back to `HomeScreen`.
- The Zego call service uses a global `navigatorKey` injected at app startup for SDK-level navigation.

### Form Logic

- `EditProfileScreen` tracks changes by comparing controller text against the current notifier value; the Save button is only enabled when `_hasChanges == true`.
- `AddEditAddressScreen` uses a debounced `Timer` (800ms) on map position changes to trigger reverse geocoding without spamming the API.

### Voice Search

In `SearchScreen`, `SpeechToText` is initialized on mic tap. Recognition results are piped into `_searchQuery` via `setState`, which triggers `_getSearchResults()` synchronously on every rebuild.

---

## 3. Data Layer

The data layer is responsible for **defining data structures**, **loading local assets**, **calling external APIs**, and **persisting state in memory**.

### Data Models (`lib/models/`)

#### `Restaurant` & `Dish` (`app_data.dart`)
```
Restaurant
├── name, imageUrl, imageUrls[]
├── rating: double
├── time: String          ← e.g. "30-35 mins"
├── offer: String
├── isPromoted: bool
├── isVeg: bool
└── dishes: List<Dish>

Dish
├── id, name, description, imageUrl
├── price: int
├── isVeg, isBestseller, isCustomisable: bool
```

Loaded from `assets/data/restaurants.json` via `rootBundle.loadString()` at app startup in `HomeScreen.initState()`.

#### `AddressModel` (`address_model.dart`)
```
AddressModel
├── id: String (UUID)
├── title, subtitle: String
├── lat, lon: double
├── type: String          ← 'Home' | 'Work' | 'Other'
├── receiverName?: String
└── phone?: String
```

Constructed from Nominatim JSON (`fromJson`) or from reverse-geocoded `Placemark` objects.

#### `UserProfile` (`user_profile.dart`)
```
UserProfile
├── name, email, mobile: String
├── dob, anniversary: String
├── gender: String
└── savedAmount: int
```

Mutated through `copyWith()` and pushed into `currentUserNotifier`.

#### `FilterOptions` (`filter_options.dart`)
```
FilterOptions
├── sortBy: String
├── nearAndFast, isScheduled, isPureVeg: bool
├── minRating?: double
├── maxDeliveryTime?: int
├── activeOffers: List<String>
├── dishPriceRange?: String
└── collections: List<String>
```

### Data Sources

#### Local JSON Assets
```
assets/data/restaurants.json       → List of Restaurant objects with dishes
assets/data/search_categories.json → List of {name, imageUrl} category items
assets/lottie/success.json         → Lottie animation for order success
```
Loaded with `rootBundle.loadString()` and parsed with `json.decode()`.

#### External HTTP APIs

**Nominatim (OpenStreetMap) — Address Search**
```
GET https://nominatim.openstreetmap.org/search
  ?q={query}
  &format=json
  &addressdetails=1
  &limit=8
  &countrycodes=in

Response → List<AddressModel>
Used in: LocationScreen, LocationService
```

**Geocoding Package — Reverse Geocoding**
```
placemarkFromCoordinates(lat, lng)
→ List<Placemark>
→ Formatted as: street, subLocality, locality, postalCode
Used in: AddEditAddressScreen (on map drag)
```

**Geolocator Package — Device GPS**
```
Geolocator.checkPermission() / requestPermission()
Geolocator.getCurrentPosition(desiredAccuracy: high)
→ Position { latitude, longitude }
Used in: AddEditAddressScreen ("Use current location" button)
```

**Zego Cloud — Real-time Audio Calls**
```
ZegoUIKitPrebuiltCallInvitationService().init(
  appID, appSign, userID, userName,
  plugins: [ZegoUIKitSignalingPlugin()]
)
ZegoSendCallInvitationButton → triggers ring to target user
Used in: main.dart, AudioCallScreen
```

**Google Fonts (CDN)**
```
GoogleFonts.poppinsTextTheme()
→ Applied globally via MaterialApp.theme
```

### Data Flow Summary

```
JSON Asset ──► rootBundle.loadString() ──► json.decode() ──► fromJson() ──► List<Restaurant>
                                                                               │
                                                             ┌─────────────────┘
                                                             │
                                              _getFilteredAndSortedRestaurants()
                                                             │
                                              RestaurantListSection / CarouselSection
                                                             │
                                              RestaurantDetailsScreen
                                                             │
                                              DishItemWidget ──► cartManager.updateQuantity()
                                                             │
                                              CartManager (ChangeNotifier)
                                                             │
                                              CheckoutScreen ──► cartManager.clear()
                                                             │
                                              SuccessScreen (Lottie) ──► HomeScreen
```

---

## Workflow: User Perspective

### Browsing & Ordering Food

1. **App opens** → User sees a promo banner carousel and a list of restaurants nearby.
2. **User scrolls** → The promo banner fades away and a sticky search bar appears.
3. **User taps the search bar** → A full-screen search opens. The user can type or tap the mic to speak their query.
4. **Search results appear** → Restaurants and dishes matching the query are listed. Tapping one opens the restaurant page.
5. **User applies filters** → The Filters button opens a bottom sheet with sorting, time, rating, and offer options. Results update instantly on closing.
6. **User opens a restaurant** → They see photos, rating, delivery time, offer details, and the dish menu.
7. **User adds a dish** → An ADD button appears on each dish card. Tapping increments the quantity. A floating cart bar appears at the bottom of the screen.
8. **User taps "View cart"** → The checkout screen opens, showing all items, an option to adjust quantities, the delivery address, and the total bill.
9. **User taps "Place Order"** → The cart is cleared and a success animation plays. The app automatically navigates back to the home screen after a few seconds.

### Managing Addresses

1. **User taps the address in the top bar** → The address selection screen opens with saved addresses and search.
2. **User taps "Use current location"** → The app requests GPS permission, fetches the device's coordinates, and drops a pin on the map.
3. **User drags the map pin** → The address label updates in real time via reverse geocoding.
4. **User fills in details and taps "Save address"** → The address appears in the saved list and is available in checkout.

### Personalising the Account

1. **User taps their avatar** → The profile screen opens with preferences, order history shortcuts, and account settings.
2. **User taps "Edit profile"** → A form opens. The Save button activates only after a change is detected.
3. **User taps "Gold member"** → The Gold benefits screen opens showing savings, current benefits, and a coupon input field.

---

## Workflow: Technical Perspective

### App Startup
```
main()
  └── WidgetsFlutterBinding.ensureInitialized()
  └── ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey)
  └── ZegoUIKitPrebuiltCallInvitationService().init(appID, appSign, userID, ...)
  └── SystemChrome.setEnabledSystemUIMode(edgeToEdge)
  └── runApp(MainApp)
        └── MaterialApp(navigatorKey, theme: GoogleFonts.poppinsTextTheme)
              └── HomeScreen
                    └── initState() → _loadRestaurants()
                          └── rootBundle.loadString('assets/data/restaurants.json')
                                └── json.decode() → Restaurant.fromJson() × N
                                      └── setState(_restaurants = ..., _isLoading = false)
```

### Restaurant Filtering Pipeline
```
User interaction (search / filter / veg toggle)
  └── setState(_searchQuery / _filterOptions)
        └── build() → _getFilteredAndSortedRestaurants()
              ├── filter by _searchQuery (restaurant.name, dish.name)
              ├── filter by isPureVeg
              ├── filter by maxDeliveryTime (parse int from time string)
              ├── filter by activeOffers (BOGO / Gold / Deals)
              └── sort by sortBy (rating descending / delivery time ascending)
                    └── Result passed to RestaurantListSection + CarouselSection
```

### Add to Cart Flow
```
DishItemWidget.onQuantityChanged(newQuantity)
  └── delta = newQuantity - (cartManager.items[dish] ?? 0)
  └── cartManager.updateQuantity(dish, delta, restaurant)
        ├── if delta causes quantity ≤ 0 → items.remove(dish)
        ├── else → items[dish] = current + delta
        ├── if items.isEmpty → currentRestaurant = null
        └── notifyListeners()
              └── ListenableBuilder in HomeScreen rebuilds
                    └── hasCartItems = true → show floating cart bar
```

### Checkout & Order Placement
```
User taps "Place Order"
  └── Navigator.pushReplacement(SuccessScreen)
  └── cartManager.clear() → items = {}, currentRestaurant = null → notifyListeners()
        └── SuccessScreen.initState()
              └── Future.delayed(3500ms)
                    └── Navigator.pushAndRemoveUntil(HomeScreen, (route) => false)
```

### Address Save Flow
```
User taps "Save address" in AddEditAddressScreen
  └── _formKey.currentState!.validate()
  └── Construct AddressModel(id: UUID, lat, lon, type, ...)
  └── savedAddressesNotifier.value = [...existing, newAddress]
        └── ValueListenableBuilder in AddressScreen rebuilds
              └── New address card appears in list
  └── Navigator.pop(context)
```

### Map Reverse Geocoding (Debounced)
```
User drags map
  └── MapOptions.onPositionChanged fires
        └── setState(_currentLocation = position.center)
        └── _debounce.cancel() + _debounce = Timer(800ms, callback)
              └── After 800ms idle: _fetchAddressFromLatLng(center)
                    └── placemarkFromCoordinates(lat, lng)
                          └── Placemark → formatted string
                                └── setState(_fetchedAddress = ...)
                                      └── Address label in bottom sheet updates
```

### Profile Update Flow
```
User edits a field in EditProfileScreen
  └── TextEditingController.addListener → _checkForChanges()
        └── Compare current controller values vs currentUserNotifier.value
        └── setState(_hasChanges = true/false)
              └── Save button enables/disables

User taps "Update profile"
  └── currentUserNotifier.value = currentUserNotifier.value.copyWith(
        name, email, mobile, dob, anniversary, gender
      )
  └── ValueListenableBuilder in ProfileCard + TopBar rebuild
  └── Navigator.pop(context)
```