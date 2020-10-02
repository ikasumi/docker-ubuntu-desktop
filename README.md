# Ubuntu Desktop Dockerfile
Docker container for Ubuntu 20.04 including ubuntu-desktop and vncserver.

# How to build
docker build --tag ubuntu-mate .

# How to run

`docker run --rm -p 5901:5901 ubuntu-mate`

and then connect to:

`vnc://<host>:5901` via VNC client.

The VNC password is `password`.
