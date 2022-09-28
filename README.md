# smart_ix

## About Smart Ix.
the smart Ix is a home automation assistance that lets you control a large family of devices across your home. The smart Ix application gives the ability to automate activities of your smart home devices by setting up a routine, routines allow you set up commands for your smart home devices which can be triggered by an action or time set for its execution. Setting up scenes to execute a common activity at the same time, the scene allows executing multiple commands at the same time without having to reorder your smart devices.
the smart Ix mobile applications are built with flutter.



## Getting Started with flutter

The smart Ix applications are built with flutter, so installing the flutter SDK on your machine is a must.
Depending on the machine to be installed, flutter provides different versions of the SDK to suit your preferred operating system. 
check out the link for more information regarding the installation of flutter in your machine.
### https://docs.flutter.dev/get-started/install.

### A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development and Firebase for flutter, view the
[online documentation](https://docs.flutter.dev/),  [https://firebase.flutter.dev/]  which offers tutorials,
samples, guidance on mobile development, and a full API reference.


### state management.

the smart ix application implant the bloc pattern as its state management tool, 
Flutter bloc is state management for flutter applications, used to manage and handle all possible states of the application in an easy, 
and more readable way.


### Key concepts:

### BlocProvider:
  is a Flutter widget that provides a bloc to its children via BlocProvider.of<T>(context). 
It is used as dependency injection (DI) widget so that a single instance of a bloc can be provided to multiple widgets within a subtree.

### MultiBlocProvider:
  is a Flutter widget that merges multiple BlocProvider widgets into one. MultiBlocProvider improves readability and eliminates the need to nest multiple BlocProviders. By using MultiBlocProvider we can go from:

### RepositoryProvider:
  is a Flutter widget that provides a repository to its children via RepositoryProvider.of<T>(context). It is used as dependency injection (DI) widget so that a single instance of a repository can be provided to multiple widgets within a subtree. BlocProvider should be used to provide blocs whereas RepositoryProvider should only be used for repositories.

### BlocBuilder:
  is a Flutter widget that requires a Bloc and a builder function. BlocBuilder handles building the widget in response to new states. BlocBuilder is very similar to StreamBuilder but has a more simple API to reduce the amount of boilerplate code needed. The builder function will potentially be called many times and should be a pure function that returns a widget in response to the state.

### BlocListener:
  is a Flutter widget that takes a BlocWidgetListener and an optional Bloc and invokes the listener in response to state changes in the bloc. It should be used for functionality that needs to occur once per state change such as navigation, showing a SnackBar, showing a Dialog, etc

the smart ix applications implements bloc and cubit as state management tools interchangeably, here is the difference between both.

### Cubit
One of the biggest advantages of using Cubit is simplicity. When creating a Cubit, we only have to define the state as well as the functions which we want to expose to change the state. In comparison, when creating a Bloc, we have to define the states, events, and  EventHandler implementation. This makes Cubit easier to understand and there is less code involved.

### Bloc
One of the biggest advantages of using Bloc is knowing the sequence of state changes as well as exactly what triggered those changes. For a state that is critical to the functionality of an application, it might be very beneficial to use a more event-driven approach in order to capture all events in addition to state changes.

check out the written bloc documentation to know more about the Bloc state management pattern. [bloc documentation]([https://docs.flutter.dev](https://bloclibrary.dev/#/gettingstarted)/]
  

## Set-Up

The projects lib folder contains various folders which handle different sections and functionality within the application.
the core folders include 

### application folder:
  this application folder contains the bloc pattern core functionality implementation which is passed through the presentation layer or view layer.
  
###  domain layer:
  container individual Interfaces and abstract methods which are later implemented in  the infrastructure layer and used around the application.
  
###  Infrastructure layer:
  implements the Interfaces created in the domain layer, the content is the repository of the application which holds primarily three repositories which include 
  
   	>>  The AuthenticationRepository is responsible for abstracting the internal implementation details of how we authenticate and fetch user information. In this case, it will be integrating with Firebase but we can always change the internal implementation later on and our application will be unaffected.

	>> The DataBaseRepository is responsible for abstracting the internal implementation of how we store the user and edit the user data, we will be using the firebase firefirestore database data storage to have persistent data among different mobile devices with the same user signed in.
		
	>> The WeatherRepository is responsible for abstracting the implementation of how weather data is fetched, using the metadata weather API to get current location weather conditions.  [metaApi documentation](https://docs.flutter.dev/](https://openweathermap.org/api/weather-map-1h),   

###  The presentation layer implant the user interfaces, and all that is required of the user to see on the screen.

## Folder Structure: 

	smart_ix /
	|- application /
	    |- authentication / 
	    |- smart_device /
	    |- weather /

	|- domain /
	    |- authentication /
	    |- database /
	    |- core /
	    |- weather /

	|- infrastructure /
	    |- authentication /
	    |- core /
	    |- smart_device /
	    |- weather /

	|- presentation /
	    |- routes /
	    |- view /
	    |- widgets /

	|- view.dart

	
	
## App Permissions:
 the smart ix requires user permission to get location to fetch weather data.
	
	 <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
 	 <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

	

## How to use
### Step 1:
Download or clone this repo by using the link below:

### Step 2:
Go to project root and execute the following command in console to get the required dependencies:
flutter pub get 
	
	

	name: smart_ix
	description: smart_ix home assistance.

	publish_to: 'none' # Remove this line if you wish to publish to pub.dev

	version: 1.0.0+1

	environment:
	sdk: ">=2.17.1 <3.0.0"


	dependencies:
	flutter:
	sdk: flutter
	cupertino_icons: ^1.0.2
	firebase_core: ^1.22.0
	firebase_auth: ^3.8.0
	cloud_firestore: ^3.4.8
	equatable: ^2.0.5
	google_sign_in: ^5.4.1
	flow_builder: ^0.0.9
	flutter_bloc: ^8.1.1
	google_fonts: ^3.0.1
	flutter_svg: ^1.1.5
	json_annotation: ^4.6.0
	path_provider: ^2.0.11
	http: ^0.13.0
	formz: ^0.4.1
	google_nav_bar: ^5.0.6
	geolocator: ^9.0.1



	dev_dependencies:
	flutter_test:
	sdk: flutter
	flutter_lints: ^2.0.0
	mocktail: ^0.3.0
	bloc_test: ^9.1.0
	build_runner: ^2.2.0
	json_serializable: ^6.3.1
	plugin_platform_interface: ^2.1.2

	flutter:
	generate: true
	uses-material-design: true

	

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# smart_IX
