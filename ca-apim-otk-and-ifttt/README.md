# CA APIM OAuth Toolkit and IFTTT

## Disclaimer

This is a tutorial, not a production ready software. The purpose is to give an idea to developers how CA API Gateway 
with OTK and IFTTT can be leveraged to support additional use cases. There is no warranty that it works in all 
environments. As I would say in Germany: "Es ist, wie es ist!" - "It is, as it is!".

However, I have tried to enable interested users to get going fast and easy.

**IMPORTANT:** 

This tutorial comes with pre-configured client_id and client_secret and a fake username and password. Please
 note that these are included to give you an idea how the system should look like once it is configured. Before you 
 start implementing any apps use your own client_id and client_secret and usernames! The instructions further down will 
 explain what you need to do! 

In any case, enjoy!

## Tutorial

The tutorial will show how CA API Gateway with CA APIM OAuth Toolkit installed can be used for building an application at 
[IFTTT](https://ifttt.com).

This tutorial was demonstrated and a replay can be viewed [here](https://www.youtube.com/watch?v=2T5Q1r_Fy9k). Most of 
the content artifacts can be found here so that anybody can try it out themselves.

**What is included?***
1. A docker-compose file. Launching this brings up a gateway that includes OTK and IFTTT policies. No need for manual installations!
2. A SOAPUI project that contains example tests for OTK and IFTTT APIs hosted on the target gateway
3. Instructions

**Dependencies**
1. A gateway license. This can be requested [here](https://transform.ca.com/API-Management-Trial.html)
2. A CA API Gateway (gateway 9.3). This can be downloaded and used after a license has been requested
2. A CA API Gateway policy manager (for gateway 9.3)
3. Optional: SOAPUI is a free and open source tool. To use it needs to be downloaded from [here](https://www.soapui.org/downloads/latest-release.html)
4. Optional: Docker. The system runs in docker which gets you started fast. Otherwise, any other CA API Gateway can be used but requires manual installation steps. However, these are shown further down
5. When using Docker the docker-compose file will also launch a MySQL image. The tutorial will not work without it. However, the policies could still be viewed via policy manager

## Getting started

I am suggesting the following approach:
1. Use the docker-compose file to launch the gateway
2. Run the SOAPUI project and verify that everything is *green*

Please note that these instructions are made to run on a MacBook. If you are a Windows user you may have to adjust commands to your needs.

### Docker

Using docker gets you started very fast. When using the provided docker-compose file, these ports will be occupied:

- 80: for http connections
- 443: for https connections
- 8443: for https connections (policy manager)
- 3306: MySQL

Follow these steps:

- **sudo vi /etc/hosts**, add **127.0.0.1 otk-ifttt.tutorial.com** // add the hostname otk-ifttt.tutorial.com
- **[user]$ vi docker-compose.yml**, replace **/path/to/your/gateway/license** with your path to your gateway license
- **[user]$ docker-compose -p otk_ifttt up** // launches the gateway
- **[user]$ /path/to/java/bin/java -jar /path/to/policy/manager/Manager.jar** // launches the policy manager
- Use **admin/password** to login // these credentials are configured in the docker-compose.yml file
  - Use **otk-ifttt.tutorial.com** as hostname

#### In policy manager do the following:

Add a new user to the gateway:
- Click the button **Create Internal User**, add 'mr_ifttt/Mr_ift_@234pas$word' 

For some reason cluster-properties need to be 'clicked':
- Tasks -> Global Settings -> Manage Cluster-Wide Properties
- Select each one, click 'Edit', followed by 'OK'
- Close the dialog

Do not worry about values, these will be updated later!

While in the policy manager, you may want to have a look around and pay attention to these pieces:

- Folder OTK: open all folders in the Server/DMZ subfolder, you can see a few disabled services. These are disabled since they are not required for this tutorial. Enable them if you want to play around with them
- Folder OTK/Customizations: A few policies have been modified to integrate with IFTTT. For any OTK those are required. Here is the list:
  - \#OTK Storage Configuration: max_oauth_token_count=2, default=1
  - \#OTK OVP Configuration: reuse_refresh_token=true, default=false
  - \#OTK Fail with error message: overwriting error 990 (expired or unknown access_token) and 103 (missing or invalid parameters) to match IFTTTs error response expectations
  - \#OTK Authorization Server Website Template: added and modified 'content' and 'error.msg' to display 'CA OTK Tutorial Bank' at the authorization servers page. This modification is optional



#### SOAPUI

The next step is to verify that the system is up and running, including OTK. SOAPUI is required:

- Launch SOAPUI
- Import the projects **./apitest/project/ifttt-tutorial-project.xml** and **./apitest/project/ifttt-tutorial-project.xml**
- Double-click **IFTTT/Testing** and click the *green* arrow in the appearing dialog, you should see a green **FINISHED** message
- Double-click **OTK-4.2/Example TestSuite** and click the *green* arrow in the appearing dialog, you should see a green **FINISHED** message

**Hurray!** Our IFTTT endpoints and OTK are up and running! 


