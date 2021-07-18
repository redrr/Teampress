# Teampress
Sport team management system
## Requirements
* Java 1.8
* MySQL
* Maven
## Setup
* Pull the repository
* Create a new Database user (Optional)
* Create a new Database and run `database/teampress_demo.sql`
* Open `application/teampress` as a Spring boot project and in the `pom.xml` modify the Database credetials
* Run the Spring boot project
* Open `http://localhost:8080` in your browser
## Roles
* Admin - System administrator
* Owner - Owner of the sport club
* Trainer - Trainer of one or more teams at the sport club
* Player - Who play in a specific team at the sport club
## Modules
### System administration
* Role: `Admin` (username: `app.teampress@gmail.com`, password: `asd123`)
* Features
    * Master data administration
    * User management
    * Team management
    * Role based privilege management
    * Users and Team data import from excel template
### Calendar and newsfeed
* Role: `Owner`, `Trainer`, `Player`
* Features:
    * Create comment, post and attach file
    * Sport calendar - It shows all event for the current user (trainings, competitions, ect.)
### Training module
* Features:
    * Create exercise (`Trainer`)
    * Create training plan (`Trainer`)
    * Rate player's performance on training session, based on the specific training plan (`Trainer`)
    * Watch Training plans, Training performance and statistics (`Owner`, `Trainer`, `Player`)
### Team management
* Features:
    * Player management - Add, delete, change players between teams in the sport club (`Trainer`)
    * Trainer management - Delete and add trainers to the sport club (`Owner`)
### Competition module
* Features:
    * Create competition (`Trainer`)
    * Create strategy plan (`Trainer`)
    * Watch competitions and strategies (`Owner`, `Trainer`, `Player`)
### Finance module
* Features:
   * Create Invoices (`Trainer`, `Owner`)
   * Create subscriptions (`Owner`)
   * Create Incomes, bills (`Trainer`, `Owner`)
   * Accept/decline created incomes and bills (`Owner`)
   * Create income groups (`Owner`)
   * Grouping accepted bills, incomes and fullfiled invoices (`Owner`)
   * Online payment (With Stripe API) - Fullfilment of invoices (`Player`)
   * Finance statistics - monthly balance sheets, yearly balance timeline chart (`Owner`)
### Video analytics
* Features:
   * Upload, edit and publish analized video (`Trainer`)
   * Create action at a specific momment (`Trainer`)
      * Color chooser
      * Player selector tool - selected affected players
      * Area marker tool - Mark given areas
      * Action arrow tool - Mark actions as vectors
      * Add title, comment and suggestions
      * Select the affected user
   * Watch analized and published videos (`Owner`, `Trainer`, `Player`)

## Contact
* Drop a mail, if you have any question.
* e-mail: redlymatyi@gmail.com
