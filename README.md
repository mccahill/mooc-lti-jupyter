# mooc-lti-jupyter

Map Coursera users (via LTI) onto a collection of Jupyter notebooks servers run in Docker containers

To make Jupyter notesbooks available to Coursera and other LTI-capable learning management systems
We need a little bit of glue -  that is what this application does. 

To Coursera, we appear to be an LTI tool, so you can configure a Coursera course to send users to the site where the mooc-lti rails app is running. After the OAuth/LTI negotation succeeds Coursera hands three pieces of information to this app: a unique ID, an displayname for the user, and their e-mail). based on that information, mooc-lti reserves a Jupyter container for the user (if they do not already have a reservation) and redirects them to the container.

Users who were previsouly assigned to a specific Jupyter docker container are always sent back to the same container. Essentially this app maintains a database of users mapped to docker container hosts/ports.

## User LTI passthrough

The user experince of an LTI passthrough is to click on the LTI tool link/button in Coursera and
then be redirected to the mooc-lti app and then immediately be redirected to the Docker container running their instance of a Jupyter notebook server. Users are *not* expected to interact with the mooc-lti application -- it is primarly an impedence matching app to get them from Coursera to Jupyter.

## App administration

Application administrators *are* expected to interact with the mooc-lti app so see things like logs and manage the pool of Jupyter Docker containers.

We presume that mooc-lti is run from inside a Apache web server so that we can depend on grabbing an environmental variable with a Shibboleth/SAML assertion for the identity of any application administrators who visit the site. Apache is configured to require Shibboleth/SAML assertions for everything except the LTI passthrough path.

App administrators can edit the app admin table, and view the LTI sessions, LTI nonces, and Jupyter container tables.


 
