# Coffsy Movie App

This project aims to present an approach on how to implement a Package-oriented project as Mono-Repo but leaving the possibility of placing the External Modules in another separate Github or Pub, thus being able to use the same as Multi-Repo. Flutter_modular was used to separate the dependency injections into each module so that when you no longer use the dependency, it is removed or removed from memory when exiting the Module.
Flutter_triple was used to simplify Store/Controllers actions and link screen actions with UseCases that link to the Movie API.

This project is not just for standing still, whenever I learn something new or someone asks for more than a resource, I will try to update it here so I can have an example of a "Big" project using the technologies I use in my everyday life.
You can follow the evolution of the Project by seeing the Release, at each evolution of the project i was generating a new release as "breadcrumbs".


![image](https://user-images.githubusercontent.com/4654514/128944745-cc776016-50e6-47f3-b5db-9c561ec37824.png)


## Main App: 

Here we have the principal App, he connect all the external Modules and inner Modules to make a functional app

## Inner Module: 

Here we have Modules inside the main App

## External Modules: 

Modules out of Main App Project, this can be extract from the main project and put in another Github or Pub and can be used in more then one Project, because they can't have "Main App" dependencies

## Libraries: 

Commom libraries beetween MainApp, External and Internal Modules



## Used Packages

  ### UI
  - shimmer: ^2.0.0 
  - cached_network_image: ^3.0.0
  - url_launcher: ^6.0.6
  - flutter_launcher_icons: ^0.9.0
  - package_info: ^2.0.2
  - youtube_player_flutter: ^8.0.0
  - flutter_svg: ^0.22.0
  - liquid_pull_to_refresh: ^3.0.0
  - carousel_slider: ^4.0.0-nullsafety.0
  - lottie: ^1.0.1 
  - fluttertoast: ^8.0.7  
  - dartz: ^0.10.0-nullsafety.2  
  - flutter_modular: ^4.1.2
  - flutter_triple: ^1.2.4+3
  - animated_card: ^2.0.0
  
  ### firebase
  - firebase_performance: ^0.7.0
  - firebase_remote_config: 0.10.0+3
  - firebase_crashlytics: ^2.0.7
  - firebase_analytics: ^8.1.2
  - firebase_remote_config: 0.10.0+3
  - firebase_storage
  
  ### Core
  - shared_preferences: ^2.0.6
  - equatable: ^2.0.2  
  - dio: ^4.0.0  
  - effective_dart: ^1.3.2  





# This Project was Based on:

Project Based on https://github.com/rrifafauzikomara/MovieApp   <- Project With Bloc

Screens Based on https://github.com/triannoviandi/movie-ticketing-app     <- Screens

Mockup based on https://www.youtube.com/watch?v=oGsX4M3wADI

PlayStore on https://play.google.com/store/apps/details?id=com.coffsy_movie_app



