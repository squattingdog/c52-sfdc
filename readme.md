
# Salesforce Apps
This is the project that contains the code related to apps in the sfdc org.

## Setup Local Machine
#### Create Local Configuration File
* Add a file to the build folder named  
```
local.build.properties
```
* Add settings for the following items:  
  * `env.dev.username=[your dev org username]`    
  * `env.dev.password=[your dev org user's password]`    
  * `env.dev.endpoint=https://c52--[theoDev].cs22.my.salesforce.com`  
      * replace [theoDev] with your custom domain
  * `build.temp=[./your/build/temp/directory]`

## Deploying
The first time you setup your sf org, run deployDependencies and then deployAll
### Deploy dependencies
```
ant deployDependencies
```

### Deploy source
```
ant deployAll
```

#### Deploy classes or objects only
* `ant deployClasses`     
* `ant deployObjects`


## Helper Scripts
If you are using a windows machine, there are several helper batch files in the build directory.  These include:  
* createClass.bat  
* createTrigger.bat  
* createPage.bat  
* createComponent.bat  
* createPermSet.bat

To see a list of the switches each one supports, run the command followed by the question mark switch.  
`createClass /?`

Some files can be chained together, for example to create a page with a controller class and test class, run the createPage class setting the create controller switch [/i] to enabled.  
`createPage /n [pageName] /c [MyControllerClass] /i 1`

All meta files are also created and placed either in the same location as the file being created or in a general meta directory.