# References
# https://usethis.r-lib.org
# https://r-pkgs.org

#####################################
# USE RSTUDIO for this exercise
#####################################
library(usethis)

# 1. Create a new Rstudio project :
# New Project -> New Directory-> Project Type : New Project.
# Click "Open in new sessoion" and  "Create git repository"

# 2. Run setwd() to make sure that you go in the right EMPTY directory
setwd("path to where you want your project to be")

# 3. Create empty R package : vizestudentnumber
# If create_package() asks confirmation, say yes
path <- file.path(getwd(), "vize123456")
create_package(path)
#At this point Rstudio will refresh and open a new R package space

# 4. Use MIT License
usethis::use_mit_license("Your Name")

# 5. Create a Readme.md
usethis::use_readme_md()

# 6. Creat a News file
usethis::use_news_md()

# 7. If you have data that you want your package to offer as lazy loading AND your data
# is in R format already, run use_data(). This will create /data

# DO NOT PUT csv, excel, json etc files under /data. Only .rda data
x <- 1; y <- 2; usethis::use_data(x, y)

# If you have any kind of other files (PDF, Excel, csv, json etc) put the inside /inst/extdata
# 8. Create unit test infrastructure
usethis::use_testthat()

# 9. Write your first few tests (similar tests inside same file)
use_test("data-presence")
use_test("data-integrity")

# 10. Make the DESCRIPTION file better.
use_description() # Overwrite existing file

#Then edit the file DESCRIPTION so that

# 11 Make sure we use Roxygen for documentation
use_namespace(roxygen = TRUE)

# 12 Create your functions inside a .R scripts under R
file.create("R/data-presence.R")
file.create("R/data-integrity.R")

#Do not forget to write a small help section for each function with @export command

# 13 Create Documentation
#  In Rstudio do CTRL+SHIFT+D
#  or
#  Menu : Build -> Document
#  This will automatically update file NAMESPACE. It will also creat man/*.Rdhelp files

# 14 Build package
#  In Rstudio do CTRL+SHIFT+B
#  or
#  Menu : Build -> Install Package
#  If build is successful, this will install the package and load it. Your latest changes should be reflected.


