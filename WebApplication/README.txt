//=== Project Type ===
ActionScript Project
SDK: Flex 4.6 with AIR 3.5

//=== Project Dependencies ==
FeathersUILib (in this repo)
== OR ==
MadComponentsUILib (in this repo)

//=== Further Setup ===
To set up this project in Flash Builder, create a new ActionScript project and create it in the directory where
you've checked out this repo.

After creating the project, go into the index.template.html file and add a wmode of direct to the params object:
params.wmode = 'direct';

This project is meant to switch between the Feathers or MadComponents UI libraries to demonstrate the difference
between the two and build one app twice. You should switch between those libs, but they should never both be used
by this project at the same time.