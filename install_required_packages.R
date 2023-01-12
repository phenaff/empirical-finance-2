# install all missing packages for project

packages <- unique(scan("lib.txt", what="", sep="\n"))
installed <- rownames(installed.packages())

# Install packages not yet installed
for(p in packages) {
  is.installed <- p %in% installed
  if(!is.installed) {
    print(paste("installing: ", p))
    install.packages(p)
  } else {
    print(paste(p, "already installed"))
  }
  }
