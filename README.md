![pipeline](https://gitlab.com/eliasjpr/slim/badges/master/pipeline.svg?style=flat-square)

# Slim - A Subscription Management API

Handle your customer subscription billing life cycle from end to end. Automate recurring billing, manage subscriptions, send professional tax-compliant invoices, and get paid on time, every time.

## Getting Started

This subcription management API is built using the Crystal Language a statically type checked, compiled language with null reference checks, built in type inference.

### Prerequisites

This project uses the following tools

- Crystal programming language 
- Docker as container
- Postgres DB as database
- Kubernetes for deployments

#### MacOS Installation

```
brew install crystal
brew install kubernetes-cli kubectl
brew install postgres
brew install docker
brew install doctl
```

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
shards install
make build run
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

To run project tests

```
crystal spec
```

### And coding style tests

For code formatting this project uses Crystal built-in code formatter

```
crystal tool format
./bin/ameba
```

### Crystal Ameba

A static code analysis tool for Crystal

```
crystal tool format
./bin/ameba
```

## Deployment

Deployement is performed using GitLab CI/CD. Deployment scripts are available under the `./deploy` directory

1. Setup a Kubenetes Cluster on Digital Ocean
2. Download the Certificate file using `doctl` with `doctl kubernetes cluster kubeconfig save slim-cluster`
3. Add new Kubernetes cluster in GitLab `https://gitlab.com/eliasjpr/slim/clusters` following these instructions `https://docs.gitlab.com/ee/user/project/clusters/add_remove_clusters.html`
4. Install `Helm Tiller` and `GitLab Runner`
5. Run the pipeline

Run `kubectl apply -f deploy` to apply changes to the kubernetes cluster from local machine.

## Built With

* [Crystal](https://crystal-lang.org/) - The web framework used
* [Crystal Shards](https://github.com/crystal-lang/shards) - Dependency Management

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://gitlab.com/eliasjpr/slim/-/tags). 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

