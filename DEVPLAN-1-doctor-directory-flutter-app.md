---
feature_id: DEVPLAN-TBA
title: Doctor Directory — Flutter Mobile Application
type: Feature
spec_status: Draft
status_summary: Prepared by agent
spec_path: working/DEVPLAN-TBA-doctor-directory-flutter-app/spec.md
approval_reference: TBD
last_updated: 2026-06-17
---

# DEVPLAN-TBA — Doctor Directory Flutter Mobile Application

---

### Table of Contents

- Metadata
- Requirement Classification
- Document Decision
- Audience and Consumers
- Feature Scope Summary
- Problem Statement
- Benefit Hypothesis
- Goals
- Non-Goals
- Feature-Level Acceptance Criteria
- Non-Functional Requirements
- Enablers
- User Stories
- Implementation Sequence
- Risks and Dependencies
- Open Questions
- Evidence Sources
- Traceability

---

### Metadata

| Field | Value |
|---|---|
| Feature ID | DEVPLAN-TBA |
| Title | Doctor Directory — Flutter Mobile Application |
| Type | Feature |
| Spec Status | Draft |
| Status Summary | Prepared by agent |
| Approval Reference | TBD |
| Classification | New capability |
| Domain | Mobile Application › Doctor Directory |
| Primary Audience | Engineering |
| Spec Path | working/DEVPLAN-TBA-doctor-directory-flutter-app/spec.md |
| Last Updated | 2026-06-17 |

---

### Requirement Classification

**Type**: Feature — New mobile application
**Subtype**: Greenfield Flutter application for educational / hackathon demonstration
**Platform**: Flutter (Android + iOS)
**Routing decision**: New spec. No existing feature spec exists in `working/` for this domain.

---

### Document Decision

This document specifies the full product and technical requirements for the Doctor Directory Flutter application. The application is a self-contained mobile app intended for educational and hackathon purposes, demonstrating modern Flutter development practices, clean architecture, mock API integration, and Material Design 3 UI.

---

### Audience and Consumers

| Audience | Usage |
|---|---|
| Flutter Engineer | Primary implementer — uses stories, ACs, and sequence for delivery |
| QA | Uses ACs for test case derivation |
| Hackathon Reviewer | Evaluates completeness against functional requirements |
| Product / Demo Reviewer | Reviews UX against design guidelines |

---

### Feature Scope Summary

The Doctor Directory application is a four-screen Flutter mobile app. Users can browse, search, and filter a directory of doctors; view full doctor profiles including a work experience timeline; create new doctor profiles with dynamic work experience entries; delete existing doctor profiles after confirmation; and view a static personal profile page. Data is managed through a mock HTTP layer using Dio with an in-memory interceptor, simulating a real REST API without a live backend.

---

### Problem Statement

Healthcare hackathon participants and Flutter developers need a self-contained, production-quality reference application that demonstrates clean architecture, Material Design 3, API-layer abstraction, and real CRUD workflows — without requiring a live backend. Existing samples are either too trivial (counter app, single screen) or too coupled to real services to be useful as demonstration or interview portfolio material.

---

### Benefit Hypothesis

> If we deliver a fully specified Doctor Directory Flutter application with clean architecture, mock API integration, and a complete CRUD workflow, then Flutter developers and hackathon participants will be able to demonstrate professional-quality mobile development skills, resulting in a deployable reference application that passes functional and design review within the scope of a single sprint.

**Strength check:**
- Named persona: Flutter developer / hackathon participant ✓
- Measurable outcome: Deployable reference application that passes design review ✓
- Behavior change: Demonstrates professional-quality work without a live backend ✓
- Validates post-delivery: Functional and design review by hackathon or portfolio reviewers ✓

---

### Goals

1. Deliver a complete, runnable Flutter application covering four screens: Doctor Listing, Doctor Details, Create Doctor, and Profile.
2. Implement a mock HTTP layer using Dio + interceptors backed by an in-memory data store to simulate API integration.
3. Apply clean architecture: separate data, domain, and presentation layers.
4. Implement full doctor CRUD (Create, Read, Delete) with form validation and confirmation dialogs.
5. Apply Material Design 3 with a dark blue primary color scheme, consistent spacing, and rounded corners (12–16 px).
6. Implement real-time name search and department chip filtering on the Doctor Listing screen.
7. Support grouped doctor listing by department when the "All" filter is selected.
8. Allow users to add one or more work experience entries dynamically when creating a doctor profile.

---

### Non-Goals

1. **Edit Doctor** — update of an existing doctor profile is explicitly out of scope.
2. **Authentication / login** — the Profile screen is static demo data; no real auth layer.
3. **Backend / live API** — no server is required; the mock interceptor is the full data layer.
4. **Push notifications** — out of scope.
5. **Pagination or infinite scroll** — all doctors are loaded in a single in-memory list.
6. **Image upload or real doctor photos** — avatars are generated from the first letter of the doctor's name.
7. **Multi-language / localization** — English only.
8. **Tablet or desktop layouts** — mobile-first; phones only.

---

### Feature-Level Acceptance Criteria

**Happy Path — Doctor Listing loads and displays grouped cards**

```gherkin
Given the app is launched for the first time
When the Doctor Listing screen is displayed
Then doctors are shown grouped by department under labeled section headers
And the "All" department chip is selected by default
And each card shows the doctor's name, qualification, department, and a colored status badge
```

**Happy Path — Department filter narrows visible doctors**

```gherkin
Given the Doctor Listing screen is visible
When the user taps a specific department chip (e.g., "Cardiology")
Then only doctors belonging to Cardiology are displayed
And section headers are not rendered when a specific department is selected
```

**Happy Path — Name search filters results in real time**

```gherkin
Given the Doctor Listing screen is visible with multiple doctors
When the user types a partial name into the search field
Then only doctors whose names contain the typed string are shown
And the filtering updates on each keystroke
```

**Happy Path — Doctor Details displays full profile and work history**

```gherkin
Given a doctor card is visible on the listing screen
When the user taps the card
Then the Doctor Details screen opens
And it shows avatar, name, qualification, department, status badge, age, about section, experience years, and work experience timeline
```

**Happy Path — Create Doctor adds a new doctor to the listing**

```gherkin
Given the user taps the Add Doctor FAB on the listing screen
And fills all required fields including at least one work experience entry
When the user taps Create Doctor
Then the form is validated successfully
And a POST request is simulated via the Dio mock interceptor
And the app navigates back to the Doctor Listing screen
And the new doctor appears in the list under the correct department
```

**Happy Path — Delete Doctor removes the doctor after confirmation**

```gherkin
Given the user is on the Doctor Details screen
When the user taps Remove Doctor
Then a confirmation dialog appears with Cancel and Remove actions
When the user taps Remove
Then a DELETE request is simulated via the Dio mock interceptor
And the doctor is removed from the in-memory list
And the app navigates back to the Doctor Listing screen
And the removed doctor is no longer visible
```

**Failure Path — Cancel delete keeps the doctor in the list**

```gherkin
Given the confirmation dialog is displayed
When the user taps Cancel
Then the dialog dismisses
And the doctor remains in the list and details remain visible
```

**Failure Path — Create Doctor form submitted with empty fields**

```gherkin
Given the Create Doctor form is open
When the user taps Create Doctor without filling required fields
Then validation error messages appear beneath each empty required field
And no navigation or mock API call is triggered
```

**Edge Case — Search returns no results**

```gherkin
Given the user has typed a name that matches no doctor in the list
When the search query is applied
Then an empty-state message is displayed (e.g., "No doctors found")
And no doctor cards are rendered
```

**Edge Case — Profile screen is static and displays demo data**

```gherkin
Given the user navigates to the Profile tab
When the Profile screen loads
Then it displays the hardcoded user name, role, age, height, weight, phone, and email
And no dynamic data fetch is triggered
```

---

### Non-Functional Requirements

| # | Requirement | Threshold |
|---|---|---|
| NFR-01 | List scroll frame rate | ≥ 60 fps on mid-range device |
| NFR-02 | Screen navigation transition | ≤ 300 ms felt latency |
| NFR-03 | Mock API response time | ≤ 50 ms simulated delay via interceptor |
| NFR-04 | Form validation feedback | Must appear inline, beneath the relevant field, within 1 frame of submit attempt |
| NFR-05 | Material Design 3 compliance | All interactive components must use M3 tokens; no raw `Color()` hardcoding outside theme |
| NFR-06 | Rounded corners | 12 px minimum on cards; 16 px on modal surfaces and FABs |
| NFR-07 | Dark blue primary theme | Primary: `#1A3A5C` (or closest M3 seed); no secondary brand color conflicts |
| NFR-08 | Status badge accessibility | Color alone is not the only differentiator; badge label text must be present alongside the color indicator |
| NFR-09 | Code organization | Clean architecture enforced: `data/`, `domain/`, `presentation/` layers separated; no cross-layer direct imports |
| NFR-10 | No hardcoded strings in widgets | All user-visible strings must use constants or a string resource file |

---

### Enablers

#### EN-01 — Project Scaffold with Clean Architecture Folder Structure

**Type**: Architecture
**Purpose**: Establish the project layout, package dependencies, and layer boundaries before any screen work begins.

**Scope**:
- Create Flutter project with `flutter create`
- Add core dependencies: `dio`, `go_router` or `auto_route`, `provider` or `riverpod`, `equatable`
- Establish folder structure:
  ```
  lib/
    core/           ← theme, constants, errors, utils
    data/           ← models, repositories (impl), mock interceptor
    domain/         ← entities, repository interfaces, use cases
    presentation/   ← screens, widgets, providers / viewmodels
  ```
- Configure `MaterialApp` with `ThemeData.from(colorScheme: ColorScheme.fromSeed(...))` using dark blue seed and `useMaterial3: true`
- Define status color tokens: Active → Green, Offline → Grey, Busy → Orange

**Acceptance Criteria**:

```gherkin
Given the project is created and dependencies are installed
When `flutter run` is executed on a connected device or emulator
Then the app launches without errors
And the folder structure matches the defined clean architecture layout
And MaterialApp is configured with Material Design 3 and dark blue seed color
```

---

#### EN-02 — Dio Mock HTTP Interceptor with In-Memory Data Store

**Type**: Integration
**Purpose**: Provide a simulated REST API layer so all screens can perform real repository calls without a live backend.

**Scope**:
- Implement `DoctorMockInterceptor` extending `Interceptor`
- In-memory `List<DoctorModel>` initialized with ≥ 6 seed doctors spanning all departments
- Simulate endpoints:
  - `GET /doctors` → return all doctors as JSON array
  - `GET /doctors/{id}` → return single doctor or 404
  - `POST /doctors` → append to list, return 201 with created entity
  - `DELETE /doctors/{id}` → remove from list, return 204
- Inject a 30–50 ms artificial delay per response
- Return correct HTTP status codes and JSON envelopes

**Acceptance Criteria**:

```gherkin
Given the Dio client is configured with DoctorMockInterceptor
When a GET /doctors request is made
Then a list of at least 6 seed doctors is returned with correct JSON shape
And response latency is between 30–50 ms
```

```gherkin
Given a valid doctor payload is POSTed to /doctors
When the interceptor processes the request
Then the new doctor is appended to the in-memory list
And a 201 response with the created doctor body is returned
```

```gherkin
Given a valid doctor ID is sent to DELETE /doctors/{id}
When the interceptor processes the request
Then the matching doctor is removed from the in-memory list
And a 204 response is returned
```

```gherkin
Given an unknown doctor ID is sent to GET /doctors/{id}
When the interceptor processes the request
Then a 404 response is returned
```

---

### User Stories

> All stories target Flutter (Android + iOS). Each story is scoped for a three-person team to complete within one week.

---

#### US-01 — Bottom Navigation Shell and Routing (Flutter)

**Component**: App Shell / Navigation

As a **mobile app user**,
I want a **bottom navigation bar with Doctors and Profile tabs**,
so that **I can switch between the main sections of the app without losing state**.

##### Acceptance Criteria

**Happy Path — Doctors tab is selected by default**

```gherkin
Given the app launches
When the home screen is displayed
Then the bottom navigation bar is visible with "Doctors" and "Profile" tabs
And the "Doctors" tab is selected by default
And the Doctor Listing screen content is displayed
```

**Happy Path — Tab switch navigates without full reload**

```gherkin
Given the app is displaying the Doctor Listing screen
When the user taps the Profile tab
Then the Profile screen is displayed
And tapping back to Doctors restores the listing screen without re-fetching all data
```

**Failure Path — Deep navigation preserves correct tab root**

```gherkin
Given the user navigated from Doctor Listing into Doctor Details
When the user taps the Profile tab and then taps Doctors tab again
Then the Doctor Listing screen is shown (not the Details screen)
```

**Error Handling — Unknown route**

```gherkin
Given a programmatic navigation to an undefined route
When the router processes the navigation
Then a fallback unknown-screen is shown with a message
And the bottom navigation bar remains visible
```

##### Traceability

| Item | Reference |
|---|---|
| Parent Feature | DEVPLAN-TBA — Doctor Directory Flutter Application |
| Related Enabler | EN-01 |
| Sequence Order | 1 |
| Dependencies | EN-01 |

---

#### US-02 — Doctor Listing Screen with Department Grouping (Flutter)

**Component**: Presentation › DoctorListingScreen

As a **mobile app user**,
I want to **see all doctors grouped by department in a scrollable list**,
so that **I can quickly scan which doctors are available in each specialty**.

##### Acceptance Criteria

**Happy Path — Doctors displayed with department section headers**

```gherkin
Given the Doctor Listing screen is open and "All" chip is selected
When the screen loads
Then doctors are displayed in a scrollable list
And each department appears as a section header above its doctors
And each doctor card shows name, qualification, department, and colored status badge
And a circular avatar with the first letter of the doctor's name is shown on each card
```

**Happy Path — FAB is visible on listing screen**

```gherkin
Given the Doctor Listing screen is displayed
When the screen renders
Then a Floating Action Button labeled "Add Doctor" is visible at the bottom right
```

**Failure Path — Empty doctor list**

```gherkin
Given the in-memory data store contains no doctors
When the Doctor Listing screen loads
Then an empty-state message is displayed
And no section headers or doctor cards are rendered
```

**Edge Case — Doctor with very long name**

```gherkin
Given a doctor whose name exceeds 30 characters is in the list
When the card renders
Then the name is truncated with an ellipsis and does not overflow the card layout
```

##### Traceability

| Item | Reference |
|---|---|
| Parent Feature | DEVPLAN-TBA — Doctor Directory Flutter Application |
| Related Enabler | EN-01, EN-02 |
| Sequence Order | 2 |
| Dependencies | EN-01, EN-02, US-01 |

---

#### US-03 — Real-Time Search and Department Filter Chips (Flutter)

**Component**: Presentation › DoctorListingScreen › SearchBar + FilterChips

As a **mobile app user**,
I want to **search for doctors by name and filter by department**,
so that **I can quickly find the doctor I'm looking for without scrolling the entire list**.

##### Acceptance Criteria

**Happy Path — Name search filters list in real time**

```gherkin
Given the Doctor Listing screen is visible with multiple doctors
When the user types a partial name into the search field
Then only doctors whose names contain the typed string (case-insensitive) are displayed
And results update on each keystroke without a submit action
```

**Happy Path — Department chip filters and hides section headers**

```gherkin
Given the "All" chip is selected
When the user taps "Cardiology"
Then the "Cardiology" chip becomes active
And only Cardiology doctors are shown
And department section headers are not rendered
```

**Happy Path — Search and department filter combine**

```gherkin
Given "Cardiology" is the active department filter
When the user also types a partial name in the search field
Then only Cardiology doctors whose names match the typed string are shown
```

**Failure Path — No results for combined filter + search**

```gherkin
Given "Neurology" is the active filter
When the user types a name that matches no Neurology doctor
Then an empty-state message is shown
```

**Edge Case — Clearing search restores filtered list**

```gherkin
Given a name search is active
When the user clears the search field
Then the full list for the currently selected department chip is restored
```

**Error Handling — Search input exceeds reasonable length**

```gherkin
Given the user types more than 100 characters into the search field
When each character is typed
Then the field accepts input and the app does not crash or degrade
And results gracefully show the empty state if no match is found
```

##### Traceability

| Item | Reference |
|---|---|
| Parent Feature | DEVPLAN-TBA — Doctor Directory Flutter Application |
| Related Enabler | EN-01 |
| Sequence Order | 3 |
| Dependencies | US-02 |

---

#### US-04 — Doctor Details Screen with Work Experience Timeline (Flutter)

**Component**: Presentation › DoctorDetailsScreen

As a **mobile app user**,
I want to **view a doctor's complete profile, biography, and work history**,
so that **I can evaluate the doctor's experience and background before an appointment or referral**.

##### Acceptance Criteria

**Happy Path — Full profile renders with all sections**

```gherkin
Given the user taps a doctor card on the listing screen
When the Doctor Details screen opens
Then the header shows avatar, name, qualification, department, and status badge
And the Personal Information section shows name, age, qualification, and department
And the About Me section shows the biography text
And the Experience Summary shows total years of experience
And the Work Experience Timeline shows all entries with year range, role, and hospital
```

**Happy Path — Work experience timeline is ordered most recent first**

```gherkin
Given a doctor has three work experience entries
When the timeline renders
Then entries are displayed in reverse chronological order
And each entry shows the year range, role title, and hospital name
```

**Failure Path — Doctor not found by ID**

```gherkin
Given the user navigates to a doctor ID that no longer exists in the store
When the details screen attempts to load
Then an error state is shown with a "Doctor not found" message
And a back button is available to return to the listing screen
```

**Edge Case — About Me text is very long**

```gherkin
Given a doctor has a biography exceeding 500 characters
When the About Me section renders
Then the full text is shown in a scrollable card without truncation or layout overflow
```

##### Traceability

| Item | Reference |
|---|---|
| Parent Feature | DEVPLAN-TBA — Doctor Directory Flutter Application |
| Related Enabler | EN-02 |
| Sequence Order | 4 |
| Dependencies | EN-02, US-01, US-02 |

---

#### US-05 — Delete Doctor with Confirmation Dialog (Flutter)

**Component**: Presentation › DoctorDetailsScreen › DeleteConfirmationDialog

As a **mobile app user**,
I want to **remove a doctor from the directory after confirming my intent**,
so that **I do not accidentally delete a profile that should remain in the system**.

##### Acceptance Criteria

**Happy Path — Doctor is removed and listing reflects deletion**

```gherkin
Given the user is on the Doctor Details screen
When the user taps "Remove Doctor"
Then a dialog appears with title "Remove Doctor?", a warning message, and Cancel / Remove actions
When the user taps Remove
Then a DELETE /doctors/{id} call is simulated via the interceptor
And the doctor is removed from the in-memory store
And the app navigates back to the Doctor Listing screen
And the removed doctor is no longer visible in the list
```

**Failure Path — Cancel dismisses dialog without deleting**

```gherkin
Given the Remove Doctor confirmation dialog is open
When the user taps Cancel
Then the dialog closes
And the doctor remains in the list and the Details screen is still visible
```

**Edge Case — Deleting the last doctor in a department**

```gherkin
Given only one doctor exists in the "Dermatology" department
When that doctor is confirmed for deletion
Then the Dermatology section header disappears from the listing screen
And the app does not crash due to an empty group
```

**Error Handling — Interceptor returns error on DELETE**

```gherkin
Given the mock interceptor is configured to return 500 for a specific DELETE request
When the user confirms deletion
Then the dialog closes and an error snackbar is shown
And the doctor remains visible in the list
```

##### Traceability

| Item | Reference |
|---|---|
| Parent Feature | DEVPLAN-TBA — Doctor Directory Flutter Application |
| Related Enabler | EN-02 |
| Sequence Order | 5 |
| Dependencies | EN-02, US-04 |

---

#### US-06 — Create Doctor Form with Validation (Flutter)

**Component**: Presentation › CreateDoctorScreen

As a **mobile app user**,
I want to **fill out a form and create a new doctor profile**,
so that **new doctors can be added to the directory without editing backend data**.

##### Acceptance Criteria

**Happy Path — All fields valid, doctor created and added to list**

```gherkin
Given the Create Doctor screen is open
And all required fields are filled with valid data
And at least one work experience entry is present
When the user taps "Create Doctor"
Then the form is validated without errors
And a POST /doctors request is simulated via the interceptor
And the app navigates back to the Doctor Listing screen
And the new doctor appears under the correct department section
```

**Happy Path — Department and Status dropdowns display all options**

```gherkin
Given the Create Doctor form is open
When the user taps the Department dropdown
Then the options Cardiology, Neurology, Orthopedics, Pediatrics, Dermatology, and General Medicine are shown
When the user taps the Status dropdown
Then the options Active, Offline, and Busy are shown
```

**Failure Path — Empty required field on submit**

```gherkin
Given one or more required fields are empty
When the user taps "Create Doctor"
Then a validation error message appears beneath each empty field
And the form does not navigate or trigger any interceptor call
```

**Edge Case — Age or experience field contains non-numeric input**

```gherkin
Given the Age or Years of Experience field contains alphabetic characters
When the user taps "Create Doctor"
Then a validation message "Please enter a valid number" is shown beneath the invalid field
```

**Edge Case — Create Doctor button visible when keyboard is open**

```gherkin
Given the keyboard is open on a small screen device
When the user is editing a mid-form field
Then the form is scrollable and the Create Doctor button is reachable
```

**Error Handling — POST interceptor returns error**

```gherkin
Given the mock interceptor is configured to return 422
When the user submits valid data
Then an error snackbar is shown
And the user remains on the Create Doctor screen with their entered data intact
```

##### Traceability

| Item | Reference |
|---|---|
| Parent Feature | DEVPLAN-TBA — Doctor Directory Flutter Application |
| Related Enabler | EN-02 |
| Sequence Order | 6 |
| Dependencies | EN-02, US-01, US-02 |

---

#### US-07 — Dynamic Work Experience Entry Rows in Create Doctor Form (Flutter)

**Component**: Presentation › CreateDoctorScreen › WorkExperienceSection

As a **mobile app user**,
I want to **add one or more work experience entries while creating a doctor**,
so that **the doctor's professional history is captured as part of the initial profile**.

##### Acceptance Criteria

**Happy Path — First work experience row is pre-rendered**

```gherkin
Given the Create Doctor screen opens
When the Work Experience section is visible
Then one empty work experience row is shown with fields: Start Year, End Year (or "Present" toggle), Role, and Hospital
And an "Add Experience" button is visible below the row
```

**Happy Path — Multiple experience rows can be added**

```gherkin
Given one work experience row is visible
When the user taps "Add Experience"
Then a new empty row is appended below the existing rows
And all rows remain independently editable
```

**Happy Path — "Present" toggle supported for current position**

```gherkin
Given a work experience row is visible
When the user enables the "Present" toggle for End Year
Then the End Year input field is disabled
And the saved record stores "Present" as the end year value
```

**Failure Path — Work experience row with empty required fields blocks submit**

```gherkin
Given the user taps Create Doctor with a work experience row that has an empty Role or Hospital field
When validation runs
Then an error is shown beneath the incomplete row
And the form does not submit
```

**Edge Case — Remove an added experience row**

```gherkin
Given two work experience rows are visible
When the user taps the delete icon on the second row
Then the second row is removed
And the first row remains unchanged
```

##### Traceability

| Item | Reference |
|---|---|
| Parent Feature | DEVPLAN-TBA — Doctor Directory Flutter Application |
| Related Enabler | EN-01 |
| Sequence Order | 7 |
| Dependencies | US-06 |

---

#### US-08 — Static Profile Screen (Flutter)

**Component**: Presentation › ProfileScreen

As a **mobile app user**,
I want to **view my profile information on the Profile tab**,
so that **I can see my account details in a clean, organized layout**.

##### Acceptance Criteria

**Happy Path — Profile screen displays hardcoded demo data**

```gherkin
Given the user taps the Profile tab
When the Profile screen loads
Then the header shows avatar, name "John Doe", and role "Administrator"
And information cards display: Name, Age (30), Height (175 cm), Weight (72 kg), Phone (+1 555-123-4567), and Email (john.doe@example.com)
```

**Failure Path — No dynamic API calls are triggered**

```gherkin
Given the Profile screen is active
When the screen lifecycle runs
Then no network request or interceptor call is triggered
And the displayed data is sourced from static constants
```

**Edge Case — Profile screen survives hot restart**

```gherkin
Given the Profile screen has been visited
When a hot restart occurs and the user navigates to Profile
Then all static values remain identical to the first render
```

**Error Handling — Navigation to Profile from deep navigation stack**

```gherkin
Given the user is on the Doctor Details screen
When the user taps the Profile tab
Then the Profile screen is shown correctly
And tapping the Doctors tab returns to the Doctor Listing screen (not the Details screen)
```

##### Traceability

| Item | Reference |
|---|---|
| Parent Feature | DEVPLAN-TBA — Doctor Directory Flutter Application |
| Related Enabler | EN-01 |
| Sequence Order | 8 |
| Dependencies | US-01 |

---

### Implementation Sequence

| # | ID | Title | Type | Depends On |
|---|---|---|---|---|
| 1 | EN-01 | Project Scaffold with Clean Architecture Folder Structure | Enabler | — |
| 2 | EN-02 | Dio Mock HTTP Interceptor with In-Memory Data Store | Enabler | EN-01 |
| 3 | US-01 | Bottom Navigation Shell and Routing | Story | EN-01 |
| 4 | US-02 | Doctor Listing Screen with Department Grouping | Story | EN-01, EN-02, US-01 |
| 5 | US-03 | Real-Time Search and Department Filter Chips | Story | US-02 |
| 6 | US-04 | Doctor Details Screen with Work Experience Timeline | Story | EN-02, US-01, US-02 |
| 7 | US-05 | Delete Doctor with Confirmation Dialog | Story | EN-02, US-04 |
| 8 | US-06 | Create Doctor Form with Validation | Story | EN-02, US-01, US-02 |
| 9 | US-07 | Dynamic Work Experience Entry Rows | Story | US-06 |
| 10 | US-08 | Static Profile Screen | Story | US-01 |

---

### Risks and Dependencies

| # | Risk / Dependency | Impact | Mitigation |
|---|---|---|---|
| R-01 | In-memory store does not persist across app restarts | Data loss on restart in demo context | Document as known limitation; acceptable for hackathon scope |
| R-02 | Dynamic form rows (US-07) increase form state complexity | Additional engineer time | Use a `List<WorkExperienceModel>` in the form ViewModel with add/remove methods |
| R-03 | Dio interceptor ordering — logging/auth interceptors may shadow mock responses | Mock responses may not trigger | Register `DoctorMockInterceptor` as the last interceptor in the Dio instance |
| R-04 | Material Design 3 token availability varies by Flutter SDK version | Some M3 components may behave differently | Pin Flutter SDK to stable ≥ 3.10 |
| R-05 | Keyboard overlap on Create Doctor form on small-screen devices | Submit button may be obscured | Use `SingleChildScrollView` + `resizeToAvoidBottomInset: true` on the Scaffold |

---

### Open Questions

| # | Question | Owner | Status |
|---|---|---|---|
| OQ-01 | Should the mock interceptor support seeding different data scenarios (e.g., populated vs. empty state for demo purposes)? | Engineer | Open |
| OQ-02 | Is there a preference for state management package? (Provider, Riverpod, Bloc — the spec is package-agnostic; choice affects folder structure slightly.) | Engineer | Open |
| OQ-03 | Should the application support dark mode alongside the light-mode dark blue theme? | Product / PM | Open |
| OQ-04 | Should the circular avatar background color be randomized per doctor or derived deterministically from the name hash? | Engineer | Open |

---

### Evidence Sources

- Application requirements provided by the product owner during PM agent intake session (2026-06-17)
- Material Design 3 specification: https://m3.material.io/
- Flutter clean architecture community pattern: layer-first folder convention

---

### Traceability

| Item | Reference |
|---|---|
| Source Request | Doctor Directory Application requirements (PM intake, 2026-06-17) |
| DEVPLAN Ticket | TBA — to be created upon spec approval |
| Related Specs | None (new standalone application) |
| Design References | None provided; design guidelines specified inline in this document |
