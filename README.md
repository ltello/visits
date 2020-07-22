# VISITS
This Ruby script reads a log file with website requests data and displays statistics about visits and unique visits to the different endpoints.

The scripts expects each line in the log file to be of the format: 
```shell
route ip
```
where `route` is a endpoint path and `ip` is the endpoint's requester ip address.

A generic error message is displayed in the case of issues finding, accessing or parsing the file.

## Implementation
The implementation is based in 3 different components:
- A simple Ruby script located in /bin folder that check for basic error conditions and delegate job to the next 2 Ruby classes:

- The `Analizer` class that locates the log filename and store visit statistics in 2 data structures during the parsing process.

- The `TextFormatter` presenter class that decorates an analizer instance and provides methods to print listings of endpoint visits in plain text.  

## Installation

### Clone the repository

```shell
git clone git@github.com:ltello/visits.git
cd visits
```

### Install Ruby

If Ruby runtime is not installed in your machine, please install it first.
Some popular ruby version managers might be helpful: [rbenv](https://github.com/rbenv/rbenv), [rvm](https://rvm.io/)

### Install  dependencies

You will need [Bundler](https://github.com/bundler/bundler) gem to install Ruby dependencies.
In the root directory of the cloned script check it is installed and accessible typing: 
 ```shell
 bundle -v
 ```  

Install it if you need to:
  ```shell
  gem install bundler
  ```

Once installed, the next command will install of Ruby dependencies for the script to run properly
```shell
bundle install
```

## Run the script

```shell
./bin/visits.rb path_to_log_filename
```

Depending on the contents of your log filename it will display something similar to:
```shell
Page Views:
/about/2 90 visits
/contact 89 visits
/index 82 visits
/about 81 visits
/help_page/1 80 visits
/home 78 visits
-------------------------
Unique Page Views:
/contact 23 visits
/help_page/1 23 visits
/home 23 visits
/index 23 visits
/about/2 22 visits
/about 21 visits```
```

## Run the test suite

In the root folder where you cloned the application, type: 
```shell
rspec
```
