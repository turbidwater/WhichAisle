//=== Project Type ===
ActionScript Mobile Project
SDK: Flex 4.6 with AIR 3.5

//=== Project Dependencies ==
FeathersUILib (in this repo)
== OR ==
MadComponentsUILib (in this repo)

//=== Further Setup ===
To set up this project in Flash Builder, create a new ActionScript Mobile project and create it in the directory where
you've checked out this repo. No added permissions should be needed for this project. Target whatever mobile 
devices you want. This was built with Android in mind. Tested for the Google Nexus S as the simulator target.

After creating the project, go into the PhoneApplication-app.xml file and make sure that renderMode is set to
direct:
<renderMode>direct</renderMode>
Also, set id to:
<id>com.realeyes.mysteryapp</id>

This project is meant to switch between the Feathers or MadComponents UI libraries to demonstrate the difference
between the two and build one app twice. You should switch between those libs, but they should never both be used
by this project at the same time.