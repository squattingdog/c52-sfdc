# C52 SFDC
This is the project that contains the code related to the sfdc org.

## Setup Local Machine
#### Create Local Configuration File
* Add a file to the build folder named, ```local.build.properties```
* Add settings for the following items:
```
env.dev.username=[your dev org username]
env.dev.password=[your dev org user's password]
env.dev.endpoint=https://c52--[theoDev].cs22.my.salesforce.com # replace [theoDev] with your instance name

path.temp=[./your/build/temp/directory]
```