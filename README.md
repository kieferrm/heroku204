heroku204
=========

Example displaying the issue that manifests when running the server on Heroku.

* Run the server on a heroku instance.
* Set environment variables:
  * TEST_HOST to the url of the heroku instance
  * TEST_PORT to port of the heroku instance (usually 80)
* In the client directory, on a local machine using Ruby 2.0.0 run 'ruby example_client.rb'
 

The POST right after the DELETE fails. See log:
![alt text](example_log.png "Log")
