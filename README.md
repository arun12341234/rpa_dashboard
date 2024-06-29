Check out http://smashing.github.io/smashing for more information.

---

# Documentation for Managing the Dashboard

This documentation provides step-by-step instructions for setting up and managing your dashboard environment, including installing Ruby with rbenv, setting up MySQL, and deploying with Docker.

## Installing Ruby with rbenv

Ruby is a dynamic, open-source programming language with a focus on simplicity and productivity. This section covers the installation of Ruby using rbenv on Unix-based systems.

### Step 1: Install rbenv and Dependencies

Before installing Ruby, you need to install its dependencies. Begin by updating your package list and installing the necessary packages:

```bash
sudo apt update
sudo apt install git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev
```

Then, install rbenv using the following commands:

```bash
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
type rbenv
```

### Step 2: Install Ruby Using ruby-build

With rbenv and ruby-build installed, you can now install Ruby:

```bash
rbenv install -l  # List all available versions of Ruby
rbenv install 3.3.0  # Install Ruby 3.3.0
rbenv global 3.3.0  # Set Ruby 3.3.0 as the default version
ruby -v  # Verify the installation
```

### Step 3: Installing Dashboard Dependencies

Install essential build tools and the `smashing` gem, a framework for building dashboards:

```bash
sudo apt install nodejs
sudo apt install build-essential
gem install bundler
gem install smashing
```
## Deploying the Dashboard with Docker

### Step 4: Download dashboad template

```bash
git clone https://github.com/arun12341234/rpa_dashboard.git
````

## Deploying the Dashboard with Docker

### Step 5: Build and Run the Docker Container

Go to rpa_dashboard dir

Install mysql to docker
```bash
docker pull mysql:latest
docker network create my_network
docker run --name test-mysql --network my_network -e MYSQL_ROOT_PASSWORD=Password@123 -e MYSQL_DATABASE=RPA_Dashboard -d mysql
````

Build your Docker image and run your dashboard:

```bash
docker-compose up
```
Once it build and start running check browser http://localhost:3030/ close terminal.

check docker status

```bash
docker ps -a
```

```
CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS                     PORTS                 NAMES
ad38eb54d0e7   my-project_smashing   "bundle exec smashin…"   35 minutes ago   Exited (1) 4 seconds ago                         my-project_smashing_1
348510e744a8   mysql                 "docker-entrypoint.s…"   45 minutes ago   Up 45 minutes              3306/tcp, 33060/tcp   test-mysql
```

If my-project_smashing STATUS Exited. Start the container with CONTAINER ID

```bash
docker start <CONTAINER ID> #Use CONTAINER ID here. In my case $ docker start ad38eb54d0e7
```

Finally all the docker containers ready.
```bash
docker ps -a
```

```
CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS          PORTS                                       NAMES
0ccaf990c0d2   my-project_smashing   "bundle exec smashin…"   6 minutes ago    Up 1 second     0.0.0.0:3030->3030/tcp, :::3030->3030/tcp   my-project_smashing_1
c088162b8660   mysql                 "docker-entrypoint.s…"   18 minutes ago   Up 18 minutes   3306/tcp, 33060/tcp                         test-mysql
```

## Updating Dashboard Data

For updating the dashboard data, refer to the [API Dashboard plugin on GitHub](https://github.com/arun12341234/Api-dashboard).

---

