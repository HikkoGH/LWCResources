# LWCResources

This repository's objective is to store useful LWC resources.

To add a resource follow these steps:

1. Checkout master and create a new branch with the resource name. Suppose the branch's name is XXX.
2. Add a new folder with the resource name XXX.
3. Add the resources in there (the classes folder, LWC folder, etc)
4. Create a README.md (the readme.md should be at the same level as your classes, LWC folders).
4.1 Jot down useful information regarding the added resource. Consider useful screenshots or videos.
4.2 At the bottom of the readme, add the following HTML tag:

<a href="https://githubsfdeploy.herokuapp.com?owner=Nimacloud&repo=LWCResources&ref=XXX" rel="nofollow">
  <img alt="Deploy to Salesforce" src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png" style="max-width:100%;">
</a>

Make sure you replace XXX by the branch's name.

7. Push your changes and create a PR to master