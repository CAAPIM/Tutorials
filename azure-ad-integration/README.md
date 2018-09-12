# CA API Gateway and Azure Active Directory (Azure AD)

## Disclaimer

This is a tutorial, not a production ready software. As I would say in Germany: "Es ist, wie es ist!" - "It is, as it is!".

However, I have tried to enable interested users to get going fast and easy.

In any case, enjoy!

## Azure AD Tutorial - Part 01

This is a multipart tutorial. The goal is to integrate OTK (CA API Management OAuth Toolkit) and Azure AD. At the end of 
this first part the gateway and Azure AD are integrated. Nothing else, very simple!

However, you will learn how to:
- create and app that can authenticate users using Azure AD
- validate JWT (JSON Web Token) in an efficient and secure way
- use OpenID Connect features such as openid-connect configuration APIs
- use encapsulated assertions
- add comments to policies in a useful manner

**What is included?**
1. A docker-compose file. Launching this brings up a gateway that includes Azure AD policies. No need for manual installations!

**Dependencies**
1. A CA API Gateway license. This can be requested [here](https://transform.ca.com/API-Management-Trial.html)
  - Name your license file 'license.xml' and place it here: **./docker/license.xml**
2. A CA API Gateway policy manager (for gateway 9.3)
3. Docker. The system runs in docker which gets you started fast

### Docker

**NOTE:** These instructions are made to run on a MacBook. If you are a Windows user you may have to adjust commands to your needs.

Using docker gets you started very fast. When using the provided docker-compose file, these ports will be occupied:

- 443: for https connections
- 8443: for https connections (policy manager)

Follow these steps:

- **sudo vi /etc/hosts**, add **127.0.0.1 azure.tutorial.com** // add the hostname azure.tutorial.com
- **[user]$ cd ./docker**
- **[user]$ docker-compose up** // launches the gateway with Azure AD policies
- **[user]$ /path/to/java/bin/java -jar /path/to/policy/manager/Manager.jar** // launches the policy manager
- Use **admin/password** to login // these credentials are configured in the docker-compose.yml file
  - Use **azure.tutorial.com** as hostname

Now, that you know you system it is up and running, let's get going with Azure.

### Azure Active Directory

First of all, I am not a Azure expert! However, these instructions should get you going.

The first step is to create an Azure account. The page below prompts for credentials. If you do not have any, create an account:
- https://portal.azure.com

Once you are logged in, do the following:
- left hand side, click **Azure Active Directory**
  - you will be prompted to create an instance
- once done, select it and click on **Properties** in the 'Manage' menu on the left hand side
  - copy the value for **Directory ID** and paste it into a text editor. You will need it later
- click on **App registrations** in the same 'Manage' column
  - this is where you can create a new app. Follow the on-screen instructions
- Once you have created an app, select it
  - the screen will display a few details about your app
  - copy the value for **Application ID** and paste it into a text editor. You will need it later
- click on **Settings**
  - click on **Reply URLs**
  - add a new one using this value: **https://azure.tutorial.com/azure/ad/authorize/redirect**
  
That's it! Optionally you can add users in the **Users** menu.

### Policy Manager

The next step is to configure the policies to work with your Azure AD account.

**TIP 01:** Always turn on 'Show Comments' and 'Show Assertion Numbers' to see additional information in the policies

**TIP 02:** The api **/azure/ad/authorize/redirect** is the one doing the most interesting things including JWT validation

Have a look what has been installed, browse a little bit:

- In the lower left window you can find the folder **Azure Active Directory Integration**
- Tasks -> Certificates, Keys and Secrets -> Manage Certificates
  - The SSL certificate for Azure has been imported as trusted certificate
- Tasks -> Global Settings -> Manage Cluster-Wide Properties
  - properties named 'azure.'

The only thing you have to do is to configure the cluster wide properties. Update them as follows:
- **azure.applicationId:** The Application ID noted earlier
- **azure.tenant:** The Directory ID noted earlier
- **azure.redirect_uri:** The Reply URL you have configured in Azure. If you followed my instruction it is **https://azure.tutorial.com/azure/ad/authorize/redirect**
- **azure.tenant.displayName:**	A name, that tells a user which AD has been configured

**TIP:** If you are not afraid of XML, update this file to your needs:
- ./docker/bundles/azure_config_template.bundle

Within that file, search for the names of the cluster properties and update them. once completed, run this command:
- curl -k -u admin:password -X PUT -H "Content-Type: application/xml" "https://localhost:8443/restman/1.0/bundle" -d @azure_config_template.bundle

All properties will be updated! You can create multiple copies of that file and apply whichever you want. That makes it easy to try different Azure AD configurations.

### Browser

This tutorial comes with a sexy website. Open this location: [Sexy Website](https://azure.tutorial.com/azure/ad/web).
- if the Safari browser does not open, try Chrome. There may be a certificate issue
- this is the location: https://azure.tutorial.com/azure/ad/web

The page displays your configured **azure.tenant.displayName**. Hit the login button and see what happens.

In the end the selected username will be displayed on the same website!

## That's it

This ends part 1 of the Azure AD tutorial. Have a look at the policies to see how they function. Let me know how it works for you, what is difficult to follow, what you liked 
and what you did not like!

## Additional info

Checkout my blog post about this tutorial:
- https://communities.ca.com/blogs/oauth/2018/09/12/azure-ad-integration

If you have trouble with policies, here are instructions for debugging them:
- https://communities.ca.com/blogs/oauth/2017/03/06/tip-of-the-week-tracing-policy