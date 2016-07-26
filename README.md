# Countdown Tracker #

This is a webapp for keeping track of Countdown clocks in TheSprawl

### What is this repository for? ###

* Quick summary 

    This is a jsp based webapp that connects to an Orient ODBMS.  It uses KnockoutJS and jQuery and WebSockets.

* Version

* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

* Summary of set up

    * Download and install Java 8
    * Download and install a copy of Orient DB version 1.7.X
    * Create a DB called 'theSprawl'
    * Download and install Tomcat 8
    * Download and install Maven 3.3.9
    * Clone the Clocks Git repo
    * Edit the /clocks/src/main/webapp/WEB-INF/web.xml with your Orient DB connection String
    * Edit the /clocks/pom.xml.  Change the output directory of the maven war plugin to be your tomcat/webapps directory
    * Run a maven install


* Configuration
    * deploy the webapp
    * edit the clocks/WEB-INF/web.xml -- set the db connection string, the websocketHttpPort and websocketHttpsPort.
 
* Dependencies -- handled by maven

* Database configuration -- you'll need to create a DB called 'theSprawl' with the Orient DB Console

* How to run tests -- don't run the tests.  All they do is manipulate the DB

* Deployment instructions --  either configure maven to drop the war file into the tomcat webapps or do it by hand

### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact