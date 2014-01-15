# running tilemill (and mapnik) masters. 
# for ubuntu 12.04 users, postgis2.0 users 
# presumes that you already have postgis 2.0 and postgis 9.x installed 
# via source or https://launchpad.net/~ubuntugis/+archive/ubuntugis-stable

# modified https://gist.github.com/springmeyer/2164897


# clear out any old ppa's that might conflict
sudo rm /etc/apt/sources.list.d/*mapnik*
sudo rm /etc/apt/sources.list.d/*developmentseed*
sudo rm /etc/apt/sources.list.d/*chris-lea*

# install if not already, req'd for add-apt-repository
sudo apt-get install python-software-properties


# add new ppa's
echo 'yes' | sudo apt-add-repository ppa:chris-lea/node.js
echo 'yes' | sudo add-apt-repository ppa:mapnik/v2.2.0
#for 3.0.0
#echo 'yes' | sudo apt-add-repository ppa:mapnik/nightly-trunk


# update
sudo apt-get -y update
sudo apt-get -y upgrade


# install nodejs latest and a few tilemill deps
sudo apt-get install -y nodejs git build-essential libgtk2.0-dev libwebkitgtk-dev

# a few other packages that I didn't have installed at the time that I need 
sudo apt-get install -y sqlite3  libprotobuf-dev libprotobuf-lite7

# Now, either install mapnik latest from packages
# Or see file below for installing mapnik from source
# and skip this line
sudo apt-get install -y libmapnik-dev mapnik-utils

# set up postgres
POSTGRES_VERSION=9.1 
POSTGIS_VERSION="2.0" 
sudo apt-get install -y postgresql postgresql-server-dev-$POSTGRES_VERSION postgresql-$POSTGRES_VERSION-postgis
sudo su postgres
# we lost variables, reset them
POSTGRES_VERSION=9.1 
POSTGIS_VERSION="2.0" 
createuser <your user> # yes to super
createdb template_postgis2
psql -d template_postgis2 -c "CREATE EXTENSION postgis;" 
psql -d template_postgis2 -c "CREATE EXTENSION postgis_topology;" # if you want topology
# psql -d template_postgis2 -c "CREATE EXTENSION hstore;" # if you want hstore

exit
# build tilemill
git clone https://github.com/mapbox/tilemill.git
cd tilemill
npm install

# then start it...
# if you are running a desktop server then just boot using all the defaults
./index.js # should open a window automatically, but you can also view at http://localhost:20009

# if you are running a headless server then the easiest thing to do
# to get a visual look at the running application is to tunnel using ssh.
# Do this from your local machine:
TILEMILL_HOST=<remote-ip>
ssh -CA ubuntu@${TILEMILL_HOST} -L 20009:localhost:20009 -L 20008:localhost:20008
# if you are using AWS then you can also pass `-i your.pem`
# then on the remove machine do
./index.js --server=true
# now TileMill is available on your local machine at http:://localhost:20009