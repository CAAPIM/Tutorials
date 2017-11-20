# What is this?
At CA World 2017 we have shown our new CA APIM OAuth Toolkit 4.1 (OTK-4.1). To do that we have used a SOAPUI project.

We are now pleased to share that project with you.

# Pre-Requisite
In order to use this project a running OTK-4.1 is required. The idea is to run the project against OTK-4.1 to get an idea how certain APIs behave. It should also help you as a starting point if your test tool is SOAPUI.

# Using the project
Using this is pretty straight forward:
- Install the open source version of SOAPUI ( [SOAPUI](https://www.soapui.org/downloads/soapui.html) )
- Import the project
- Select the project "CA_World_2017_OTK-4.1"
- Configure the "Custom Properties" to your needs (mainly 'host_iss', 'resource_owner', 'resource_owner_password')
- Now double-click the TestSuite "OpenID-Config-Registration" and hit the green "Run" arrow

That's it! The project will now run against your OTK and should end with retrieving details from /userinfo. Each step has a description; please check those for details per step.

After downloading the tutorial please open "index.html" first.

# Disclaimer
Although we are happy to help you getting started, please note that we are not able to help you with support on SOAPUI itself. For that please refer to official channels for that.