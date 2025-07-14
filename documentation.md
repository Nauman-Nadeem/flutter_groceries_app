# Technical Documentation

## Technical Decisions 

### Architecture Choices
1. **Provider Pattern for State Management**
   - Chose Provider over other state management solutions (BLoC, Getx ) due to:
     - Simplicity and ease of implementation
     - Official recommendation by Flutter team
     - Perfect fit for the app's moderate complexity level
     - Built-in ChangeNotifier for efficient UI updates

2. **Service Layer Implementation**
   - Implemented dedicated services (ProductService, CartService, UserService) to:
     - Separate business logic from UI
     - Enable better testability
     - Provide clear data flow patterns
     - Make future backend integration easier

3. **Widget Choices**
   - Used BottomNavigationBar over Drawer because:
     - Better accessibility for frequent navigation actions
     - Modern mobile UX patterns
     - Consistent with material design guidelines

4. **Data Persistence**
   - SharedPreferences for cart data:
     - Lightweight solution for small data sets
     - Fast read/write operations
     - Sufficient for current requirements
     - Easy to implement and maintain

### Component Architecture
1. **Screens Organization**
   - Modular screen components (Home, Profile, Cart, etc.)
   - Each screen is self-contained with its own widget tree
   - Clear separation of concerns

2. **Model Structure**
   - Immutable models with final fields
   - Clear property definitions

## Challenges and Solutions 

### 1. State Management
**Challenge:** Managing application state across multiple screens and components.
**Solution:**
- Implemented Provider pattern for state management
- Created NavigationProvider for handling navigation state
- Used ChangeNotifier for efficient UI updates
- Maintained clean architecture with separate service layers

### 2. Data Loading and Caching
**Challenge:** Efficient loading and caching of product data.
**Solution:**
- Implemented asynchronous data loading with Future
- Used JSON asset loading for initial product data
- Optimized data structure for quick access

### 3. UI/UX Implementation
**Challenge:** Creating a responsive and user-friendly interface.
**Solution:**
- Used ListView with separated items for better performance
- Implemented custom ProductCard widget for consistent display
- Maintained consistent styling across screens

## ListView vs GridView

**ListView** displays items in a single column, vertically scrolling.  
- Best for linear lists (e.g., product lists, messages).
- Easier to separate items with dividers (`ListView.separated`).
- Simpler for layouts where each item spans the full width.

**GridView** arranges items in a grid (multiple columns/rows).  
- Suitable for image galleries or when you want to show multiple items per row.
- More complex layout and spacing management.
- Can be harder to maintain consistent item heights.

**Why ListView was chosen:**
- The app's product listing benefits from a vertical scroll and full-width cards for better readability.
- ListView is more accessible and familiar for grocery/shopping apps.
- Easier to implement item separation and responsive layouts.

**Why not use something else (e.g., Table, CustomScrollView):**
- Table is for tabular data, not suited for dynamic lists.
- CustomScrollView is more complex and needed only for advanced, mixed scrollable layouts.
- ListView provides the best balance of simplicity, performance, and maintainability for this use case.

### Why use the Card widget?

The Card widget was chosen for product display because:
- It provides a clean, material design look with built-in elevation and rounded corners.
- Cards help visually separate each product, improving readability and focus.
- Easy to customize with padding, margin, and shadow.
- Consistent with modern mobile UI patterns, especially for shopping apps.

**Why not use something else (e.g., Container, ListTile, Custom Widget)?**
- **Container** requires manual styling for elevation, borders, and shadows, increasing code complexity.
- **ListTile** is best for simple list items, not for rich product layouts with images, prices, and actions.
- **Custom Widgets** could be used, but Card offers all needed features out-of-the-box, reducing development time and ensuring consistency.

Card provides the best balance of simplicity, appearance, and maintainability for product presentation in this app.

### 4. Code Organization
**Challenge:** Maintaining clean and maintainable code structure.
**Solution:**
- Separated concerns into Models, Services, and Providers
- Created reusable widgets for common UI elements
- Implemented clear naming conventions

## Time Breakdown and Learnings

### Day 1: Project Setup and Basic Structure
- Project initialization and configuration
- Basic screen setup and navigation 
- Provider implementation
**Learnings:**
- Importance of proper project structure
- Provider pattern implementation best practices
- Efficient navigation setup in Flutter

### Day 2: Core Features Implementation
- Product listing and cart functionality 
- User profile implementation 
- Services layer development 
**Learnings:**
- Async data handling in Flutter
- Service layer architecture
- State management patterns

### Day 3: UI Polish and Testing
- UI refinement and responsiveness 
- Bug fixes and optimization 
- Documentation and code cleanup
**Learnings:**
- Importance of proper documentation
