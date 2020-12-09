# Send Custom Notifications flow

Use this flow to send custom notifications from everywhere, specially from PBs.

## Before this flow
You were able to use a custom notification from process builder.
When setting the recipient to Group for example and providing the name, 
when deploying to production, the sandbox group id was hardcoded by SF and
throws an error.

## Using this flow
You can specify the notification recipient = group, queue or user
specify the recipient developer name (group or queue developer name, or username)
title
body
related objetct

<a href="https://githubsfdeploy.herokuapp.com?owner=Nimacloud&repo=LWCResources&ref=send-custom-notifications-flow">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>
