# Basic Operations #

This guide describes basic CRUD operations on objects in the JSS with this framework.
Before you can start working with JSS objects you need to configure an API connection.

At the time of writing there are 2 API types: The older XML API, and the newer (but incomplete) json UAPI.

This example uses the older XML API.

## Constructing the API connection object ##

Construct an API object using your credentials:

    // First construct a URL containing the location of the JSS API
    let url = URL(string: "https://localhost:8443")!
    
    // Next, construct a URLCredential object to store the HTTP Plain authentication credentials.
    let credential = URLCredential(user: "admin", password: "secret", persistence: .forSession)
    
    // Finally, create an API connection object using the URL and credentials
    let api = try API(url: url, credential: credential)

## Using the GenericStore to work with JSS Objects ##

The **GenericStore** object contains methods to perform all the basic Create, Read, Update, and Delete
operations for all objects that inherit from JSSResource.

In this example we will use the **Building** object from the JSS, since it has the least number of properties.

First, construct an api connection object as above.
Second, construct a generic store like so:

    let buildingStore = GenericStore<Building>(api: api, paths: Building.resourcePaths)

The second paths parameter lets the GenericStore know which kinds of operations are supported for this object.

Now that you have a store constructed, you can use to to perform all kinds of operations with that object, for example:

**Finding a building by its ID**:

    buildingStore.find(id: 1) {
        (building, error) in

        ...
    }

**Creating a building:**

    let building = Building()
    building.name = "Headquarters"

    buildingStore.create(building) {
        (buildingId, error) in  
        ...
    }

