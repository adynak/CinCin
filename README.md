## CinCin

Cheers and welcome to the CinCin app.  Use this app to create a catalog of your favorite cocktails.

* Define the ingredients you use.
* Create catagories for your cocktails.
* Search your recipes by name or ingredient
* View your selected cocktail.
* Install this on a server then view the app on your mobile device.

## Getting Started

You have a few things to get in place before using this app in your environment

### Prerequisites

Load these software packages.

```
node and npm
```

```
php 5.5
```

```
postgreSQL 9.3 
```

```
apache or IIS
```

### Installing

Clone the repo to a folder under your web server and use npm to install it.

```
npm install
```

Find the SQL script in the repo and run it to create a table and populate that table with some default values.

## Running the app

The first time you run the app, you will be prompted for the database schema (the default is **draanks**) as well as the database password and the listening port for postgreSQL.  These are saved in local storage.

You can log in as guest, but can only view recipies.  Add qualified users to the postgreSQL table to enable all the features of this app. 


## Make it Yours

Look in **i18n/en_us** for branding, email addresses, and default user settings.

Change the configuration in the postgreSQL script to suit your needs.

The project has an email feature that uses an existing google script.  The repo contains a [copy](https://github.com/adynak/FormsBuilder/blob/master/resources/scripts/script.gs) that you can modify, submit to google, register and deploy as a web app.  Change the email URL to the new one assigned to you by google.


## Authors

* **Al Dynak** - *Initial work* 

See also the list of [contributors](https://github.com/adynak/FormsBuilder/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/adynak/FormsBuilder/blob/master/LICENSE) file for details

