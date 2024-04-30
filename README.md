Final Year Project Submission - README

Tested on a virtual machine running Linux 20.04 LTS, latest Docker 26.x.x and Kathara 3.7.4.

Would need to download the files and extract to a directory, then use the following commands to start the container:

docker build -t <image_name_here>

for example: docker build -t kathara/jordan_snort:latest
-t is the tag/name of the image being built

once this is built you can start the container by running the following:

docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/run/docker.sock:/var/run/docker.sock -u root --cap-add NET_ADMIN -it <image_name>:<image_version>

for example: "docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/run/docker.sock:/var/run/docker.sock -u root --cap-add NET_ADMIN -it kathara/jordan_snort:latest"

-e sets the environment variable for the display to be used by the Kathará CLIs

-v specifies certain volumes to be shared for use within the container, the first is for the xterm windows (default terminals used by Kathará machines) and the second is utilise the docker socket for the docker deamon
to be used within the container (allows docker commands to be used in the container despite not being explicitly installed which has some concerns discussed in the report).

-u specifies the user in this case the root user (also has some security implications)

--cap-add adds capabilities to the user, --privileged can also be used however I believe this is less secure than adding necessary capabilities. Kathará apparently also requires this for networking to function.

-it allows the container to become interactive

and finally we specify which image to base the container on.
