# Local kubernetes development stack

# What's included

* kind cluster https://kind.sigs.k8s.io/:
    * [LoadBalancer](https://kind.sigs.k8s.io/docs/user/loadbalancer/) setup
    * [Calico networking and network policy](https://docs.tigera.io/calico/latest/getting-started/kubernetes/self-managed-onprem/onpremises) for [network policy](https://kubernetes.io/docs/concepts/services-networking/network-policies/) testing
* Helm Charts:
    * [external secrets](https://external-secrets.io/latest/)
    * [vault](https://github.com/hashicorp/vault-helm)
* Vault integrated with kubernetes
