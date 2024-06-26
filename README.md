## Project Title and Description

Task Manager App

The Task Manager App is a powerful and intuitive application designed to help users organize and manage their tasks efficiently. Whether you're tracking personal to-dos, work-related projects, or collaborative tasks, this app provides all the necessary tools to stay on top of your responsibilities and increase productivity.

## Installation

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart SDK: Comes bundled with Flutter
- Android Studio or Xcode: For Android/iOS development

### Steps

1. Clone the repository:
   git clone https://github.com/abed-awad/maids_task_manager.git

2. Navigate to the project directory:
   cd maids_task_manager

3. Get the dependencies:
   flutter pub get

4. Run the app:
   flutter run

## Design Decisions

- **State Management:** I choose Provider for state management but i wanted to use Getx.
- **Local Storage:** I choose SQLite database for local storage.

I used flutter_secure_storage instead of SharedPreferences, which allows saving the username and password securely and encrypted in the local mobile storage.
Note: Although I could use sqflite, flutter_secure_storage provides encryption and higher security especially for authentication.

**UI Design:** splash screen -> login screen -> home screen (only to use pagination)
-> drawer (User Todos) to see the sync between local and online data

## Development Timeline

This project was completed in just 2 days. The rapid development was made possible by leveraging Flutter's robust framework and efficient development tools. The focus was on implementing core features and ensuring a secure, user-friendly experience.

## Future Improvements

Although the project was completed in a short timeframe, there are several features I plan to add in the future to enhance the app's functionality:

Translation, Dark Mode, Offline Mode, Task Details, Forget Password, ....
