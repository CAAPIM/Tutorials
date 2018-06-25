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
5. When using Docker, the docker-compose file will also launch a MySQL image. The tutorial will not work without it. However, the policies could still be viewed via policy manager

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

### CA OTK Tutorial Bank web application

To confirm even the last piece, open a browser:

- https://otk-ifttt.tutorial.com/tutorial/otk/ifttt/bank
- Login using **admin/password** or **mr_ifttt/Mr_ift_@234pas$word**
- Select the menu item *Account Management* from the left and get an overview of available accounts.
  - that menu is the only ones that works!
  
If all these above steps were successful, you are good to go! Our IFTTT endpoints and OTK are up and running! 

## IFTTT

To get started, create and confirm an account at [IFTTT](https://ifttt.com). Developing an application is free, publishing the 
application is not. However, for this tutorial no publishing is required!

During the next steps a new service will be created, triggers and actions will be defined, an app will be built. To get 
going fast simply use the values that are shown, use your own once this tutorial works.

Here we go:

**Create service from scratch**

- *Service name*: CA OTK Tutorial Bank // replace 'CA' with your own value if it fails. Not sure if this name can be re-used
- *Organization*: your own value
- *IFTTT service ID*: caaimtutorialotk // replace 'ca' with your own value. Not sure if this name can be re-used
- Click *Create*

Next, you will be in front of the *Dashboard*. Starting off at the Service tab.

### IFTTT-Service

**General**:

- *Service name* and *IFTTT service ID* are populated wit values. Configure the rest to your needs
- Click *Save*

**Branding**

- Configure images as you wish. Note that images need to be square and have a size of 620x620 

**Call to action button**

- Select *Visit*
- *Button URL*: https://github.com/CAAPIM/Tutorials

**Search terms**

- fun, ifttt, tutorial, otk, whatever, you, like

**Admins**

- Pre-populated

**Redirects**

- I have not used this yet, if you figure out how to use this, let me know! However, I am using the value below:
- https://github.com/CAAPIM/Tutorials

### IFTTT-API

**General**

- *IFTTT API URL*: https://otk-ifttt.tutorial.com/tutorial/otk/ifttt
  - This is also referred to as 'URL-prefix' within the IFTTT system
- *Service Key*: This is **YOUR** API Key. **Please note**, this is required later on

**Authentication**

This configuration will use OAuth 2.0. To get you started, please use the values provided here. Once it is working, replace the 
credentials with ones generated by your OTK.

- Select *My API has users with expiring OAuth2 access tokens and uses refresh tokens* // third option
- *Client ID*: 8dd8d732-3e76-405e-8598-c26453d9a99f
- *Client secret*: 98c14eee-39ab-4bf4-b3d6-d42262a884d9
- *Authorization URL*: https://otk-ifttt.tutorial.com/auth/oauth/v2/authorize
- *Token URL*: https://otk-ifttt.tutorial.com/auth/oauth/v2/token
- *Redirect url after authentication completes*: pre-populated value. **Please note**, his is required later on
- *Demo account login*: mr_ifttt
- *Demo account password*: Mr_ift_@234pas$word
- *Demo account notes*: Default user

**Triggers**

Triggers will send a message to your server to receive a list of updated/ changed values. In our case, a change at a 
CA OTK Tutorial Bank account will be returned.

- Click *New Trigger*
- *Name*: Account Monitor
- *Description*: whatever you like
- *Endpoint*: 'API', add 'account_monitor'
- Click *Save*

Next screen, section *Trigger fields*. Click *Add trigger field +*:

- *Label*: Account Number
- *Optional helper text*: The account number to be monitored
- *Key name*: account_number
- Click *Save*

Add a second trigger field:

- *Label*: Amount
- *Optional helper text*: The amount as of which the monitor becomes active.
- *Key name*: amount
- Click *Save*

Adding a verbiage:

- *Verbiage*: the account has changed
- Click *Save*

Now we'll add 3 ingredients. Values, that are returned by the trigger, and used as input for actions:

First, remove the default one *CreatedAt*

Ingredient no. 1:
- Click *Add ingredient*
- *Name*: Type
- *Slug*: type
- *Note*: Either withdrawal or deposit
- *Type*: String
- *Example*: http://example.com/account/type // not sure how this is used. If you find out, let me know!
- Click *Save*

Ingredient no. 2:
- Click *Add ingredient*
- *Name*: Amount
- *Slug*: amount
- *Note*: The amount of the change.
- *Type*: String
- *Example*: http://example.com/account/amount // not sure how this is used. If you find out, let me know!
- Click *Save*

Ingredient no. 3:
- Click *Add ingredient*
- *Name*: Id
- *Slug*: id
- *Note*: ID of this transaction.
- *Type*: String
- *Example*: http://example.com/account/id // not sure how this is used. If you find out, let me know!
- Click *Save*

**Actions**

Actions will send a message to your server in order to update your system! They will usually be fed by ingredients 
provided by triggers.

- Click *New action*
- *Name*: Account Manager
- *Description*: Selects a monitored account if an amount has changed.
- *Verbiage*: manage account
- *Endpoint*: add 'account_management'
- Click *Save*

Now we'll add 1 Action field. The value is sent to your server:

- Click *Add action field +*
- *Label*: Which Account
- *Optional account number to manage*: The account number to manage
- *Key name*: which_account
- Click *Save*

**Endpoint tests**

Now, that everything is configured, it is time to run the endpoint tests. This will verify that the configuration matches 
the configuration on the gateway. A few tasks are required to make this happen.

**1. Install a cloud-to-local-environment-proxy**

IFTTT is running in the cloud, your gateway is running in your local environment. To close the gap and enable connections
 between these two, IFTTT recommends 2 different tools. I have used [ngrok.com](https://ngrok.com). To enable this tool 
 simply follow their instructions. It took me 5 minutes to get it going, it is really simple.
 
Once you installed the agent on your machine launch it like this:

- [user]$ ./ngrok http 80
- a dialog opens, copy the shown hostname, e.g.: http://**s45afabc223.ngrop.io**
- open the Dashboard in IFTTT and open the API tab:
  - replace the host name in all URLs in the sections: General, Authentication (3 URLs all together)
  - replace *otk-ifttt.tutorial.com* with your copied hostname, e.g.: *s45afabc223.ngrop.io*

That's it! The agent will now forward any requests received via http or https to the local port 80.

If you wonder why port 80 will work, it is simple: the OTK within the Docker container is configured to not require SSL! 
This is certainly only valid during development ... and for this tutorial.

**2. Configure your own service-key**

The service-key was generated by IFTTT earlier. This needs to be used now:

- open *Policy Manager* using *admin/password*
- open *Tasks -> Global Settings -> Manage Cluster-Wide Properties*
- Select *ifttt.service.key* and click *Edit*
- Paste your service key (replace 'CONFIGURE_YOUR_OWN_VALUE')
- Click *OK* and close the dialog.

**3. Configure IFTTT's redirect_uri**

IFTTT has provided a redirect_uri earlier. This needs to be used now:

- open a browser and go to [OAuth Manager](https://otk-ifttt.tutorial.com/oauth/manager)
- Login using *admin/password*
- Find the client named 'IFTTT' and select *List Keys* at the right end of the row
- Click *Edit* in the opening dialog
- Replace the callback URL *https://otk-ifttt.tutorial.com/oauth/v2/client/bcp?auth=done* with the value provided by IFTTT earlier
- Click *Save*

**4. Run the test**

To run the endpoint test, simply click the button **Begin test**. If you configured everything as described, there should be no issues. 
This message should be displayed: **Success! All endpoint tests passed**

**Connection test**

Nothing else to do here then clicking *Begin test*. When you get redirected to your authorization servers page, use *admin/password* 
or *mr_ifttt/Mr_ift_@234pas$word* to login. This message should be displayed: **Connection tests successful.**

## IFTTT Application

working on it ...