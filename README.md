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
5. Create a deploy token `https://gitlab.com/eliasjpr/slim/-/settings/repository`
6. Create a database url secret in kubernetes `kubectl create secret generic databaseurl --from-literal=DATABASE_URL="{CONNECTION_STIRNG_HERE}"`
7. Create a private docker registry secret in kubernetes with deploy token info 
`create secret docker-registry regcred --docker-server=$CI_REGISTRY --docker-username='$CI_DEPLOY_USER' --docker-password='$CI_DEPLOY_PASSWORD' --docker-email='$GITLAB_USER_EMAIL --dry-run=true -o yaml | kubectl apply -f -`
8. Run the pipeline

Run `kubectl apply -f deploy` to apply changes to the kubernetes cluster from local machine.

# Gitlab AutoDevops on DigitalOcean k8s

## Creating k8s cluster on DigitalOcean

1. Create a k8s cluster <https://cloud.digitalocean.com/kubernetes/clusters>
2. Install kubectl <https://kubernetes.io/docs/tasks/tools/install-kubectl/>
3. Download config file from cluster page to `~/.kube/config`

## Adding k8s cluster to Gitlab project

More info here: <https://gitlab.com/help/user/project/clusters/index#adding-an-existing-kubernetes-cluster>

Go to the group and add Kubernetes cluster <https://gitlab.com/groups/urbica/-/clusters/>

1. Create a gitlab service account in the default namespace:

```shell
kubectl create -f - <<EOF
  apiVersion: v1
  kind: ServiceAccount
  metadata:
    name: gitlab
    namespace: default
EOF
```

2. Create a cluster role binding to give the gitlab service account
   cluster-admin privileges:

```shell
kubectl create -f - <<EOF
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: gitlab-cluster-admin
subjects:
- kind: ServiceAccount
  name: gitlab
  namespace: default
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
EOF
```

To determine the `API URL`, run

```shell
kubectl cluster-info | grep 'Kubernetes master' | awk '/http/ {print $NF}'
```

To determine the `Token`, list the secrets by running:

```shell
kubectl get secrets
```

Note the name of the secret you need the token for. Get the token for the appropriate secret by running:

```shell
kubectl get secret <SECRET_NAME> -o jsonpath="{['data']['token']}" | base64 -D
```

To determine the `CA certificate`, run:

```shell
kubectl get secret <SECRET_NAME> -o jsonpath="{['data']['ca\.crt']}" | base64 -D
```

Don't forget to enable `RBAC`.

On the cluster settings page install:

- Helm Tiller
- Ingress
- Cert Manager

After installing Ingress, check that external ip is set and pointing to the right load balancer <https://gitlab.com/help/user/project/clusters/index.md#getting-the-external-ip-address>

## Built With

* [Crystal](https://crystal-lang.org/) - The web framework used
* [Crystal Shards](https://github.com/crystal-lang/shards) - Dependency Management

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://gitlab.com/eliasjpr/slim/-/tags). 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

