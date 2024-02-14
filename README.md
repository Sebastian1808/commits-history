# Commits History

In this application you can see the commits you have made in a GitHub repository.

## Installation

### Prerequisites

Before proceeding, make sure you have installed:

- Make sure you have Flutter and Dart installed on your system. You can follow the [official Flutter documentation](https://flutter.dev/docs/get-started/install) for detailed instructions on how to do this.
- Code editor (e.g. Visual Studio Code, Android Studio, etc.)
- Make sure you have and set up a mobile device emulator in your IDE in which you can test the application.
### Installation steps

1. Clone this repository on your local machine:

````bash
git clone https://github.com/Sebastian1808/commits-history
````
2. Open the directory where you cloned your project in the IDE of your choice, we recommend (Android Studio).
3. Make sure you have the Flutter and Dart SDKs installed on your system. You can follow the [official Flutter documentation](https://flutter.dev/docs/get-started/install) for detailed instructions on how to do this.
4. Configure the Device Manager in your IDE if necessary create a device to emulate the application
5. Make sure you have the .env file in the root of the project, if you don't have it create one with the .env.example structure.


6. Open a terminal at the root of the project and run the following command to obtain the necessary dependencies:

````bash
flutter pub get
````
7. Run the application with the following command:

````bash
flutter run
````
8. Enjoy the application
## Usage

1. When you run the application, you will see a screen where you can see the commits of the same application repository or put your personal access token and see the commits of the repositories you have access to.
2. if you want to visualize how the project would look like on iOS or Android you must change line 32 of the Main.dart file, in which you specify the device -> .Material = Android, .Cupertino = iOS
3. You can see the details of the commits by clicking on them.
4. You can switch between repositories by selecting the drop-down menu at the top left in the "Commits History" section.

## Contributing

If you want to contribute to this project and make it better, your help is very welcome. Create a pull request with your new features, bug fixes, etc.

## License

This project is licensed under the MIT License - see the [LICENSE.md]
