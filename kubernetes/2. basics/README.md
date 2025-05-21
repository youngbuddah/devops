# 🧰 Basic Kubernetes Commands

This guide includes essential Kubernetes commands for interacting with an EKS cluster using AWS CloudShell and `kubectl`.

---

### ✅ Connect to Kubernetes Cluster using AWS CloudShell

```bash
aws eks update-kubeconfig --region <region name> --name <cluster name>
```

**Description:**
Configures your local kubeconfig to connect to an EKS (Elastic Kubernetes Service) cluster using AWS CLI.

**Replace:**

> - `<region-name>` (e.g., ap-south-1)
> - `<cluster-name>` with your EKS cluster's name.

---

### 🚣 Create a Pod Using a Docker Image

```bash
kubectl run <pod-name> --image=<image-name> --restart=Never
```

**Example:**

```bash
kubectl run nginx-pod --image=nginx --restart=Never
```

**Description:**

> - Creates a single pod running a specified Docker image.
> - `--restart=Never` is used to create a standalone pod, not a deployment.

---

### 📦 Get All Pods in Current Namespace

```bash
kubectl get pods
```

**Description:**

> - Lists all pods in the default namespace.
> - To see pods in all namespaces:

```bash
kubectl get pods --all-namespaces
```

---

### ℹ️ Detailed Info About All Pods

```bash
kubectl get pods -o wide
```

**Description:**
Shows detailed information about pods, including:

> - IPs
> - Node they're running on
> - Containers

---

### 📄 Pod Description

```bash
kubectl describe pod <pod-name>
```

**Description:**
Gives detailed, human-readable information about the specified pod, including:

> - Events
> - Conditions
> - Container details
> - Mounted volumes

---

### ❌ Delete a Pod

```bash
kubectl delete pod <pod-name>
```

**Description:**
Deletes the specified pod from the current namespace.

---

### 👥 Get All Nodes

```bash
kubectl get nodes
```

**Description:**

> - Lists all the worker nodes in your Kubernetes cluster.
> - Useful to verify node health and status.

---

### ℹ️ Detailed Info About All Nodes

```bash
kubectl get nodes -o wide
```

**Description:**
Provides additional node details such as:

> - Internal/external IPs
> - OS image
> - Kernel version
> - Container runtime

---

### 🧾 Node Description

```bash
kubectl describe node <node-name>
```

**Description:**
Provides in-depth info about a specific node, such as:

> - Resource allocation
> - Labels
> - System info
> - Running pods

---

### ❌ Delete a Node

```bash
kubectl delete node <node-name>
```

**Description:**
Removes the specified node from the cluster.

**Note:** Draining the node is usually recommended before deletion.

---

### ➕ Create a Namespace

```bash
kubectl create namespace <namespace-name>
```

**Example:**

```bash
kubectl create namespace dev
```

**Description:**

> - Creates a new namespace for organizing your resources (pods, services, etc.).

---

### 🌐 List All Namespaces

```bash
kubectl get namespaces
```

**Description:**

> - Displays all namespaces in the cluster.
> - Namespaces are used for logical separation of resources.

---

### 🛠️ Create a Service (Expose a Pod)

```bash
kubectl expose pod <pod-name> --type=<service-type> --port=<port> --target-port=<target-port>
```

**Example:**

```bash
kubectl expose pod nginx-pod --type=NodePort --port=80 --target-port=80
```

**Description:**
Creates a service to expose the pod to internal or external traffic.

> - `--port`: The port that the service will expose.
> - `--target-port`: The port on the container that the traffic will be forwarded to.

**Types of services:**

> - `ClusteIP`: Default; accessible only within the cluster.
> - `NodePort`: Exposes service on each Node’s IP at a static port.
> - `LoadBalancer`: Creates an external load balancer in supported cloud providers.

---

### 🔍 Get All Services

```bash
kubectl get services
```

**Description:**

> - Lists all services in the default namespace.
> - To get services in all namespaces:

```bash
kubectl get services --all-namespaces
```

Shows service names, types (ClusterIP, NodePort, LoadBalancer), cluster IP, and external IPs if any.

---

### ❌ Delete a Service

```bash
kubectl delete service <service-name>
```

**Description:**
Deletes the specified service from the current namespace.

---
