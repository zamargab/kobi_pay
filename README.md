# KobiPay App

This Flutter project demonstrates fetching and managing transaction history data using the **BLoC** pattern and a simulated API layer.

---

## 🚀 Setup Instructions

1. **Clone the repository**

   ```bash
   git clone https://github.com/zamargab/kobi_pay.git
   cd kobi_pay
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```


---

## 📚 Libraries Used

* `flutter_bloc` — BLoC state management
* `equatable` — Simplifies equality for states/events
* `sizer` — Responsive sizing for UI
* `flutter/services.dart` — Used for loading bundled JSON files via `rootBundle`
* `bloc_test` — For testing BLoC logic
* `mocktail` — For mocking dependencies in tests
* `flutter_test` — Flutter’s built-in testing framework

---

## 🎨 Design & State Management Decisions

* **Architecture**: Clean separation of concerns using the BLoC pattern.

  * **Repository** layer abstracts data access.
  * **Local Data Source** simulates API by reading from a JSON file in assets.
  * **BLoC** handles business logic and emits states to the UI.
  * **Events** represent user actions (fetch, change month/filter, refund).
  * **States** represent UI conditions (loading, loaded, error).

* **UI**: Uses `Sizer` for consistent layout across screen sizes.

* **Filtering**: Transactions can be filtered by month".

* **Testing & Iteration**: The simulation makes it easy to test loading, success, and error states without a real backend.

---

## 🔌 API Simulation

The app simulates an API by using a **local JSON file** packaged inside the Flutter assets. This allows the app to behave as if it is calling a backend while remaining fully offline.

* Instead of making real HTTP requests, the local data source loads a JSON file via `rootBundle`.
* The repository exposes a clean API to the BLoC, which doesn’t need to know whether the data is coming from local or remote.
* The BLoC then emits states (`Loading`, `Loaded`, `Error`) based on the repository’s response.
* This ensures the app behaves exactly like it would with a real API, including asynchronous state changes, but remains self-contained.

**Summary:** The simulation mimics backend interaction by loading transactions from an asset file, providing a predictable and testable flow.

---

## 🧪 Testing

The project includes comprehensive BLoC tests to ensure predictable behavior:

* **Successful Load**: Verifies that when transactions are fetched successfully, the states transition from `Loading` to `Loaded`.
* **Failure Case**: Verifies that if the repository throws an exception, the states transition from `Loading` to `Error`.
* **Refund Flow**: Verifies that triggering a refund updates the state correctly, marking the transaction as refunded.

These tests use:

* `bloc_test` to structure BLoC event–state tests.
* `mocktail` to mock the repository and control its responses.
* `flutter_test` to run the test cases.


---

## ✅ Features

* Fetch and display a list of transactions (simulated)
* Filter transactions by month
* Display total payments for the selected period
* Unit and BLoC tests for success, error, and refund scenarios

---


