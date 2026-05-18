# Agents.md – InDieTonne iOS App

## Projektübersicht

**InDieTonne** ist eine native iOS-App zur Verwaltung von Müllabfuhr-Terminen. Benutzer können sich registrieren/einloggen, ihren Ort und ihre Straße auswählen, Müllsorten (Fraktionen) konfigurieren und Erinnerungen für Abholtermine planen. Die App kommuniziert mit einem GraphQL-Backend und empfängt Push-Benachrichtigungen via Apple Push Notification service (APNs) / Firebase Cloud Messaging.

- **Bundle ID:** `com.indietonne.ios`
- **Sprache:** Swift (100%)
- **Min iOS:** 26.2
- **Build-System:** Xcode + Swift Package Manager (SPM)
- **Projekt-Setup:** `PBXFileSystemSynchronizedRootGroup` – neue Dateien im `apple/`-Ordner werden automatisch ins Xcode-Projekt aufgenommen.

---

## Tech-Stack & Bibliotheken

| Kategorie | Technologie | Details |
|---|---|---|
| **UI** | SwiftUI | Native iOS UI Framework |
| **Navigation** | SwiftUI `NavigationStack` + `NavigationPath` | Typsichere Stack-Navigation |
| **DI / State** | `@Observable` (iOS 17+) | Services per `@Environment` injiziert, kein externes DI-Framework |
| **Netzwerk (GraphQL)** | Apollo iOS (apollo-ios) | Queries, Mutations, Custom Scalar Adapters |
| **Netzwerk (REST)** | `URLSession` | Nur für Bild-Service (Picture API) |
| **State Management** | `@Observable` + `@State` / `@Binding` | In ViewModels (iOS 17+) |
| **Persistenz (Token)** | Keychain (`Security` Framework) | Verschlüsselte Token-Speicherung |
| **Persistenz (Einstellungen)** | `UserDefaults` (via `@AppStorage`) | Nicht-sensitive Nutzereinstellungen |
| **Serialisierung** | `Codable` / `JSONDecoder` | Für API-Responses und lokale Persistenz |
| **Push Notifications** | APNs + Firebase Cloud Messaging iOS SDK | Rich Notifications mit Bild-Attachments |
| **Bildladen** | [Kingfisher](https://github.com/onevcat/Kingfisher) | Async Image Loading & Caching |
| **Code Style** | SwiftLint | Konfiguriert via `.swiftlint.yml` |
| **Async/Concurrency** | Swift Concurrency (`async/await`, `Task`, `AsyncStream`) | Äquivalent zu Kotlin Coroutines + StateFlow |

---

## Architektur

Clean Architecture mit drei Schichten:

```
┌─────────────────────────────────────────────┐
│              presentation/                   │
│   (Views, ViewModels, UI States)            │
├─────────────────────────────────────────────┤
│                domain/                       │
│           (UseCases)                         │
├─────────────────────────────────────────────┤
│                 data/                        │
│   (Repositories, Remote APIs, Scalars)      │
├─────────────────────────────────────────────┤
│                  di/                         │
│   (AppEnvironment, KeychainService, etc.)   │
├─────────────────────────────────────────────┤
│                common/                       │
│   (Resource, AppRoute, Constants, ...)      │
└─────────────────────────────────────────────┘
```

### Verzeichnisstruktur

```
apple/
├── appleApp.swift                    # @main App-Entry, NavigationStack, Token-Check
│
├── graphql/                          # GraphQL-Schema & Operationen (Apollo iOS Codegen)
│   ├── schema.graphqls
│   ├── authentication.graphql
│   ├── query.graphql
│   └── mutation.graphql
│
├── common/
│   ├── Constants.swift
│   ├── Resource.swift                # enum Resource<T>
│   ├── AppRoute.swift                # enum AppRoute: Hashable
│   └── CategoryHeader.swift
│
├── data/
│   ├── remote/
│   │   ├── AuthenticationApi.swift
│   │   ├── AuthenticatedApi.swift
│   │   └── ImageRepositoryProtocol.swift
│   └── repository/
│       ├── AuthRepositoryImpl.swift
│       ├── AuthenticatedRepositoryImpl.swift
│       ├── ImageRepositoryImpl.swift
│       └── Scalars.swift
│
├── domain/
│   └── useCase/
│       ├── PostLoginUseCase.swift
│       ├── PostRegisterUseCase.swift
│       ├── GetAppointmentsUseCase.swift
│       ├── GetImageUseCase.swift
│       ├── RequestPasswordResetUseCase.swift
│       ├── ResetPasswordUseCase.swift
│       ├── VerifyEmailUseCase.swift
│       └── PostScheduleAppointmentUseCase.swift
│
├── presentation/
│   ├── login/        { LoginPage, LoginViewModel, LoginState }
│   ├── register/     { RegisterPage, RegisterViewModel, RegisterState }
│   ├── place/        { PlacesPage, PlacesViewModel, PlaceListState }
│   ├── street/       { StreetPage, StreetViewModel, StreetListState }
│   ├── trashSettings/{ TrashSettings, TrashSettingsViewModel, ... }
│   ├── scheduleOverview/ { ScheduleOverview, ScheduleViewModel, AppointmentListState }
│   ├── scheduleList/ { ScheduleList }
│   ├── profile/      { ProfilePage, ProfileViewModel }
│   ├── auth/         { ForgotPasswordPage, ResetPasswordPage, VerifyEmailPage, ResendVerificationPage }
│   └── components/   { AppBar, PlaceListItem, PlaceListOverviewItem }
│
├── di/
│   ├── AppEnvironment.swift
│   ├── KeychainService.swift
│   ├── ApolloClientProvider.swift
│   ├── TokenStore.swift
│   └── DeviceInfoService.swift
│
└── ui/theme/
    ├── Color+Extension.swift
    ├── InDieTonneTheme.swift
    └── Typography.swift
```

---

## Architektur-Muster & Konventionen

### 1. Dependency Injection via `@Environment`

- Kein externes DI-Framework – Swift's `@Environment` + `@Observable` ersetzt Hilt.
- `AppEnvironment` ist `@Observable` und enthält alle Services.
- Wird in `appleApp.swift` erzeugt und via `.environment(appEnvironment)` injiziert.
- ViewModels bekommen Services per Constructor Injection.
- **Zwei getrennte ApolloClients** (wie Android):
  - Unauthentifiziert: Login/Register
  - Authentifiziert: `Authorization: Bearer <token>` via `AuthorizationInterceptor`

### 2. Netzwerk-Architektur

- **Apollo iOS** für GraphQL.
- **URLSession** nur für Bild-Service (Port 3001).
- Logging via `os_log` / `Logger`.

### 3. State Management

- ViewModels = `@Observable final class` (iOS 17+).
- UI-State-Structs: `isLoading: Bool`, `data: T?`, `error: String`.
- `Resource<T>` enum: `.loading`, `.success(T)`, `.error(String)`.

### 4. Navigation

- `NavigationStack` mit `enum AppRoute: Hashable`.
- Start-Destination basiert auf Token-Existenz im Keychain.

### 5. Datenpersistenz & Sicherheit

- **Keychain** für JWT-Token (`KeychainService`).
- `TokenStore` (`@Observable`) wraps `KeychainService` reaktiv.
- `@AppStorage` für nicht-sensitive Einstellungen.

### 6. GraphQL (Apollo iOS)

- `apollo-ios-cli generate` für Codegen.
- Custom Scalars: `UUID` → `UUID`, `Instant` → `Date` (ISO-8601).

### 7. Build-Konfigurationen

| Konfiguration | Backend-URL |
|---|---|
| `Debug (local)` | `http://localhost:8080/graphql` |
| `Debug (prod)` | `http://192.168.178.25:8080/` |
| `Release` | `http://192.168.178.25:8080/` |

- Konfigurationswerte in `.xcconfig`-Dateien, gelesen aus `Info.plist`.

### 8. Push Notifications (APNs / FCM)

- **Firebase iOS SDK** (`FirebaseMessaging`).
- Rich Notifications via `UNNotificationServiceExtension`.
- APNs-Token wird beim Register ans Backend gemeldet.

---

## Coding-Konventionen

### Namenskonventionen
- **Views:** `<Feature>Page` / `<Feature>View`
- **ViewModels:** `<Feature>ViewModel` – `@Observable final class`
- **UI States:** `<Feature>State` – `struct`
- **Repositories:** Protocol `<Name>Api` / `<Name>RepositoryProtocol`, Impl `<Name>RepositoryImpl`
- **UseCases:** `Get<Entity>UseCase` / `Post<Action>UseCase`

### Schritt-für-Schritt: Neues Feature

1. GraphQL-Operation in `graphql/` definieren
2. `apollo-ios-cli generate`
3. API-Protocol in `data/remote/`
4. Repository-Implementierung in `data/repository/`
5. UseCase in `domain/useCase/`
6. `AppEnvironment` erweitern
7. State struct in `presentation/<feature>/`
8. ViewModel in `presentation/<feature>/`
9. View in `presentation/<feature>/`
10. Route in `common/AppRoute.swift`
11. `navigationDestination` in `appleApp.swift`

### ViewModel-Template

```swift
@Observable
@MainActor
final class MyFeatureViewModel {
    private let useCase: MyUseCase
    private(set) var state = MyFeatureState()

    init(useCase: MyUseCase) {
        self.useCase = useCase
    }

    func loadData(param: SomeParam) async {
        state.isLoading = true
        do {
            state.data = try await useCase.execute(param: param)
            state.isLoading = false
        } catch {
            state.error = error.localizedDescription
            state.isLoading = false
        }
    }
}
```

### State-Template

```swift
struct MyFeatureState {
    var isLoading: Bool = false
    var data: MyDataType? = nil
    var error: String = ""
}
```

---

## Build & Entwicklung

### Voraussetzungen

- Xcode 16+ (Swift 6 / iOS 26 SDK)
- `brew install apollo-ios-cli`
- `brew install swiftlint`

### Wichtige Befehle

```bash
swiftlint lint --config .swiftlint.yml
swiftlint --fix --config .swiftlint.yml
apollo-ios-cli generate
apollo-ios-cli fetch-schema --endpoint http://localhost:8080/graphql --output apple/graphql/schema.graphqls
xcodebuild test -scheme apple -destination 'platform=iOS Simulator,name=iPhone 16'
```

### Hinweise

- Backend lokal: Port `8080` (GraphQL), Port `3001` (Bild-Service).
- Im Simulator: `localhost` (nicht `10.0.2.2` wie Android).
- `GoogleService-Info.plist` muss vorhanden sein.
- ATS-Ausnahmen für lokale HTTP-Endpunkte in `Info.plist` per Build-Konfiguration.

---

## Backend-Ressourcen (Zugriff benötigt)

> ⚠️ Folgende Ressourcen werden für vollständige Implementierung benötigt:

| Ressource | Status |
|---|---|
| `schema.graphqls` | ✅ Im Android-Repo vorhanden – wird gespiegelt |
| GraphQL-Endpoint (`:8080/graphql`) | Nur für Live-Tests nötig |
| Bild-Service (`:3001`) | Nur für Bildladen-Tests nötig |
| `GoogleService-Info.plist` | ❌ Aus Firebase Console laden |
| APNs Push Capability | ❌ Im Apple Developer Account aktivieren |

---

## Bekannte technische Schulden / TODOs

- Apollo iOS SPM-Package muss noch in Xcode hinzugefügt werden (siehe `README` unten).
- Kingfisher SPM-Package muss noch hinzugefügt werden.
- Firebase iOS SDK muss noch hinzugefügt werden.
- SwiftLint-Build-Phase muss in Xcode konfiguriert werden.
- `.xcconfig`-Dateien für Build-Konfigurationen fehlen.
- `GoogleService-Info.plist` fehlt.
- ATS-Ausnahmen in `Info.plist` fehlen.

---

## SPM-Pakete (in Xcode hinzufügen)

| Paket | URL | Branch/Version |
|---|---|---|
| Apollo iOS | `https://github.com/apollographql/apollo-ios` | from `1.15.0` |
| Kingfisher | `https://github.com/onevcat/Kingfisher` | from `8.0.0` |
| Firebase iOS | `https://github.com/firebase/firebase-ios-sdk` | from `11.0.0` (nur `FirebaseMessaging`) |
