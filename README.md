## README
[![CircleCI](https://circleci.com/gh/ministryofjustice/legal-framework-api.svg?style=shield)](https://circleci.com/gh/ministryofjustice/legal-framework-api/tree/main)

# Ministry of Justice

## Legal Aid Legal Framework API

An API for checking the required information for legal aid applications

## Documentation

The API is documented at /api-docs.

The documentation is generated with swagger for ruby [RSWAG](https://github.com/rswag/rswag#readme) from specs
in the `spec/requests` folder and allows real requests to be made.

If changes are made to files in this directory, regenerate the swagger documentation by executing `NOCOVERAGE=true rake rswag`.


### Further reading
* Developer looking to use the API? - [Click here](docs/development.md)


### Usage
`/merits_tasks`
A client will create a request by posting a payload to the `merits_tasks` endpoint, which will respond with the information required by the LAA to assess the
merits and means of the client for their specific proceeding type.

`/proceeding_types/searches`
A client will create a payload with some search terms and the API will respond with an array of relevant proceeding types, which include those search terms in their name, description or meaning

`/proceeding_types/threshold_waivers`
A client will create a payload which will include an array of proceeding types, the API will respond with the threshold waivers for each given proceeding type

## Generation of API documentation
If changes are made to files in this directory, regenerate the swagger documentation by executing `rake swag`.


## Running tests

The full rspec test suite can be run with
```
bundle exec rspec
```

## Deployment

The deployment is triggered on all builds in [CircleCI](https://circleci.com/gh/ministryofjustice/legal-framework-api) but requires approval to the desired environment.

A build is only triggered by Circle CI when a pull request is opened in GitHub, this also applies to `Draft` pull requests.

**NOTE:** **git-crypt** is required to store secrets required for **uat**, **staging** and **production** environments.
To be able to modify those secrets, **git-crypt** needs to be set up according to the following
[guide](https://user-guide.cloud-platform.service.justice.gov.uk/tasks.html#git-crypt).

* For more information on howto setup **Helm** in your local environment refer to the following [guide](https://ministryofjustice.github.io/cloud-platform-user-docs/02-deploying-an-app/002-app-deploy-helm/#installing-and-configuring-helm-and-tiller).

### UAT Deployments

UAT deployments are automatically created and deleted as part of the Circle CI process. Once a pull request has been created on GitHub, Circle CI will create a deployment under the new branch name.
Once the branch has been merged with `main` the UAT deployment is deleted as part of the Circle CI process to deploy production.

In some cases a deployed branch will not be merged with `main` in which case the following commands can be used to manually delete the UAT deployment:

```
# list the availables releases:
helm list --namespace=legal-framework-api-uat --debug --all

# delete a specific release
helm delete --namespace=legal-framework-api-uat <name-of-the-release>
```

## Architecture Diagram

View the [architecture diagram](https://structurizr.com/share/55246/diagrams#apply-container) for this project.
It's defined as code and [can be edited](https://github.com/ministryofjustice/laa-architecture-as-code/blob/main/src/main/kotlin/model/Apply.kt) by anyone.

## CCMS

The API obtains details of organisations from CCMS using the GetCommonOrg web service (API). This is one of several web services exposed by “CCMS SOA” via a ”CCMS gateway”. You can configure your local machine to communicate with a specific environment’s web service by populating your .env.development (or equivalent) with the Connection to CCMS SOA details given in .env.sample.
