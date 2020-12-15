This provides a LWC to display a map component based on custom field valyes

To use this component, edit a record page and drag-and-drop the customMapComponent.
The component will ask for the following parameters:
objectName: the object to retrieve the fields from
api names: the field api names to retrieve the information from.
Make sure to bind all of the values. The only optionals are Title and Description.

There is also a refresh button, since the component does not auto-reload
when the record values change.

![config](https://github.com/Nimacloud/LWCResources/blob/custom-map-component/custom-map-component/config.png)

![example](https://github.com/Nimacloud/LWCResources/blob/custom-map-component/custom-map-component/example.png)

<a href="https://githubsfdeploy.herokuapp.com?owner=Nimacloud&amp;repo=LWCResources&amp;ref=custom-map-component" rel="nofollow">
  <img alt="Deploy to Salesforce" src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png" style="max-width:100%;">
</a>
