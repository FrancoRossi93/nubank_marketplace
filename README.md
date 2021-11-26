# nubank_marketplace

Project written in Dart and Flutter.
NuBank MarketPlace for interview coding challenge.

## Repository info

# Run project
Just clone the project from my Github public repo (https://github.com/FrancoRossi93/nubank_marketplace) and Run it from terminal or from text editor ui. Branches master and develop are up to date. 
For running the project you will need flutter 2 and it should run in all devices (android and iOS).

# Clean code, pattern and architecture
This repository is organized in a clean way with BloC library and modules separeted in features.
Each features has 3 roots folders (layers), domain, data and presentation.
Domain folder will contain the bussiness logic (use cases) and entities (bussiness objects), its also the most inner layer folder of them and independent. 
The data folder consists of a repository implementation and through data sources (remote and local) for getting the data from the api (remote).
Presentation layer is where all the widgets and BloCs are. Separating widgets from their pages and BloCs keeps code clean.

# Problem domain solving
Fetching data from Graphql API was made through REST calls, i know there is a package in flutter to implement (https://pub.dev/packages/graphql_flutter), but i decided to do it with REST in http because it was more challgening and i wanted to keep the presentation layer organized and only with BloC statemanegment.

# Tests
All necessary unit tests has been implemented, their folders follow the same organization as in their counterparts. 

# UI
I made the ui as beautiful as I could in two days of work, I hope you like it.