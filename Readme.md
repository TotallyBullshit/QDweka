# Quick & Dirty CLI for weka from R

## Logic:

### 1- Run bash commands from R 
### 2- Export results to a txt file
### 3- Parse results using regex
### 4- Use R for graphics

### Basic Usage

```
require("devtools")
setwd("pathtoweka/weka-3-6-11")
install_github("martinbel/QDweka")
require("QDweka")
```
** Write secuence of commands **
```
cmd <- cmd_j48(CLASSPATH = "export CLASSPATH=/Users/mbtangotan/Desktop/weka-3-6-11/weka.jar",
               C = rep(0.5, 2), M = seq(200, 180, by = -20), 
               data = "/Users/mbtangotan/Desktop/permanencia_upselling_3.arff")
```
** Run commands in bash **
```
md <- j48(cmd)
```
### Retrieves a list of "models" as text
```
str(md)
```

tested on OS X 10.9.3
