ls wallpapers | egrep '(jpg|png)' | perl -e 'print "<html><body><ul>"; while(<>) { chop $_; print "<li><a href=\"wallpapers/$_\">$_</a></li>";} print "</ul></body></html>"' > index.html
