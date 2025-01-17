---
title: About this Website
pagetitle: About Website
no-nav-entry: True
---

This is a preview of the Programming Club's redesigned website.  
Designed by Kentaro Watts.  
Implemented by Joshua Wierenga and Kentaro Watts.  

Built using [Pandoc](https://pandoc.org/)'s Markdown to HTML converter as a static site generator with images prepared with [ImageMagick](https://imagemagick.org/).  
This website relies on [Bootstrap 5](https://getbootstrap.com/), licensed under [MIT](https://github.com/twbs/bootstrap/blob/v5.3.3/LICENSE) 
and various icons from [Bootstrap Icons](https://icons.getbootstrap.com/), also licensed under [MIT](https://github.com/twbs/icons/blob/v1.11.3/LICENSE).  
Special thanks to Nathaniel for their css only dark mode toggle [code](https://endtimes.dev/no-javascript-dark-mode-toggle/).

Website info:

* Version: v2.0.0-preview
* Pandoc version: %PANDOC_VERSION%
* ImageMagick version: %MAGICK_VERSION%
<!-- TODO: Move to build.sh so setup.yaml can use the same variable -->
* Bootstrap version: v5.3.3
* Bootstrap Icons version: v1.13.3
<!-- TODO: Parse to local time with js? -->
* Last built: %BUILD_TIME%
* Git commit: %BUILD_COMMIT%
* Git commit author(s): %BUILD_COMMIT_AUTHOR%
<!-- TODO: Parse to local time with js? -->
* Git commit time: %BUILD_COMMIT_TIME%
* Git commit branch: %BUILD_COMMIT_BRANCH%

<!-- TODO: Uncomment once js dark mode support is back -->
<!-- <span class="js-only" hidden>
Using a js based dark mode system with full persistance between pages and browser level support.
</span> -->
<!-- <noscript> -->
Note: Using a css only dark mode system without persistance between pages and limited browser level suppport.
<!-- </noscript> -->


<a class="hideul" href="https://validator.w3.org/nu/?showoutline=yes&showimagereport=yes&doc=https%3A%2F%2Fprogrammingclub.com.au%2Ftestwebsite%2Fwebsiteabout.html">
  <img style="border:0;width:88px;height:31px"
       src="https://raw.githubusercontent.com/bradleytaunt/html5-valid-badge/refs/heads/master/html5-validator-badge.png"
       alt="Valid HTML5!">
</a>
<a class="hideul" href="http://jigsaw.w3.org/css-validator/validator?lang=en&profile=css3svg&uri=https%3A%2F%2Fprogrammingclub.com.au%2Ftestwebsite%2Fassets%2Fstyle.css&usermedium=all&vextwarning=true&warning=2">
  <img style="border:0;width:88px;height:31px"
       src="https://jigsaw.w3.org/css-validator/images/vcss"
       alt="Valid CSS!">
</a>
