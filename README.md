This is the repo for the learnr-tutorial rlernen. It is mainly useful for myself or anyone who wants to modify or host the rlernen tutorial.

Important note: It is not clear whether caching works with learnr. For tag2 and tag5 it is turned off as it leads to problems. tag2 does not render at all, it takes forever. For tag5 navigation breaks. 

# v2.0 (September 2023)

All Tutorials were updated. There is now a new section on reading and writing data. A custom help-function was created. I tried to get rid of some dependencies which reduced the image size from 3.62 to 1.89 GB.

# Procedure

## docker

After making changes to the .Rmd files, push to github, pull and rebuild the docker image:

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

## website 

programming/rkurs_website project

run create_nav.R

upload to server:

rsync -arvz --stats --progress --itemize-changes -e 'ssh -p 22' _site/ johannes@method.hsw.tu-chemnitz.de:/var/www/rlernen_v2.0.de

## shinyproxy

url for shinyproxy and for website has to be the same!

test.rlernen.de -> redirects to website /var/www/rlernen.de/html
test.rlernen.de/shinyproxy -> redirects to shinyproxy server

both are on the same url

for navbar the base url is test.rlernen.de/shinyproxy/app_direct

test.rlernen.de/rlernen -> for parts of website that do not go through shinyproxy; e.g. mitwirkende.html; 

rewrite ^/rlernen/(.*)$ /$1 break; takes care of removing the prefix and redirecting directly to the correct file, whereas all other things go through shinyproxy -> nope, i think this was just some temporary solution; all normal files go directly to the correct folder; it is the shiniproxy prefix in the url that redirects to shinyproxy 
