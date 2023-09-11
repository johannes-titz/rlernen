This is the repo for the learnr-tutorial rlernen. It is mainly useful for myself or anyone who wants to modify or host the rlernen tutorial.

Important note: It is not clear whether caching works with learnr. It is turned off except for some heavy computations in tag7.Rmd.

# Procedure

After making changes to the .Rmd files, rebuild the docker image:

```
sudo docker build -t rlernen
```

Test the container (modify the file to see all tutorials):

```
docker run --rm -p 4000:3838 rlernen R -e "rmarkdown::run('tag2.Rmd')"
```

- Why is the port 4k? because shinyproxy expects it to be 4k?
- --rm stands for remove, so that you do not clutter your docker container list
- R -e is running R execute
