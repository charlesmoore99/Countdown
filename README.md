# Countdown Tracker #

This is a webapp for keeping track of Countdown clocks in games that are Powered By The Apocalypse game engine.

### What is this repository for? ###

* Quick summary 

    This is a jsp based webapp that connects to a PostgreSQL RDBMS.  it used to connect ot Orient DB, but Orient prooved too high maintenance on Openshift.  It uses KnockoutJS and jQuery and WebSockets and Chromecast.

* Version

* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

* Summary of set up

    * Download and install Java 8
    * Download and install a copy of PostgreSQL DB version 9.2 (or really any modern postgres.)
    * Create a DB called 'theSprawl'
    * Download and install Tomcat 8
    * Download and install Maven 3.3.9
    * Clone the Countdown Git repo
    * Edit the /clocks/src/main/webapp/WEB-INF/web.xml with your Postgres DB connection String
    * Edit the /clocks/pom.xml.  Change the output directory of the maven war plugin to be your tomcat/webapps directory
    * Run a maven install


* Configuration
    * deploy the webapp
    * edit the clocks/WEB-INF/web.xml -- set the db connection string, the websocketHttpPort and websocketHttpsPort.  (a normal tomcat uses the same ports for ws and wss as http and https, but OpenShift hides its tomcat behind a proxy.  Because of this the websockets need to go directly to special websokcet ports)
 
* Dependencies -- handled by maven

* Database configuration -- you'll need to create a DB called 'theSprawl' with the pgAdmin or via SQL

* How to run tests -- don't run the tests.  All they do is manipulate the DB

* Deployment instructions --  either configure maven to drop the war file into the tomcat webapps or do it by hand

### Contribution guidelines ###

* You're on your own

### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact
