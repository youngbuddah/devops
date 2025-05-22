# 🚀 Kubernetes Deployment & Service: A Practical Example

This project demonstrates how to deploy and expose a containerized application (e.g.,**NGINX**) using **Kubernetes Deployment** and **Service** objects.

---

### 📦 What is a Deployment?

A **Deployment** is the recommended way to manage your application in Kubernetes. It provides:

> - 🔄 **Declarative updates** - Define desired state, Kubernetes handles it.
> - 🚀 **Rolling updates** – Seamless, zero-downtime updates.
> - 🛡️ **Self-healing** – Replaces failed pods automatically.
> - 🧾 **Version control** – Rollbacks, history, and consistency.

---

### 📁 Files Overview

| File             | Description                                    |
| ---------------- | ---------------------------------------------- |
| `deployment.yml` | Manages pod replicas using a Deployment object |
| `service.yml`    | Exposes Deployment Pods via a NodePort Service |

---

### 📄 `deployment.yml` – Define & Manage Pods

#### 📌 Key Fields

| Field                      | Description                                                        |
| -------------------------- | ------------------------------------------------------------------ |
| `apiVersion: apps/v1`      | Deployment API version                                             |
| `kind: Deployment`         | Resource type                                                      |
| `metadata`                 | Metadata about the Deployment object.                              |
| `metadata.name`            | Name of the Deployment                                             |
| `metadata.labels`          | Labels for the Deployment (used for selection, organization, etc.) |
| `spec`                     | This is where you define the **desired state** of the Deployment.  |
| `spec.replicas`            | Number of pod replicas.                                            |
| `spec.replicas: 3`         | Ensures 3 Pods are running at all times                            |
| `selector`                 | Identifies the set of Pods the Deployment manages                  |
| `template`                 | Blueprint for the Pods (metadata + spec)                           |
| `template.metadata.labels` | Labels applied to pods being created                               |
| `template.spec.containers` | The actual container(s) specification                              |
| `image`                    | The container image (e.g., NGINX)                                  |
| `containerPort`            | Port exposed by the container                                      |

**▶️ `selector.matchLabels`**

```bash
selector:
  matchLabels:
    app: my-label
```

> - This tells the Deployment which Pods to manage.
> - It must match the labels inside template.metadata.labels.

**▶️ `containers`**

```bash
containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
      - containerPort: 80
```

| Key             | Description                                                |
| --------------- | ---------------------------------------------------------- |
| `name`          | Container name (unique within the Pod)                     |
| `image`         | Docker image to use (e.g., `nginx:1.14.2`)                 |
| `containerPort` | Port exposed by container (used by Services, probes, etc.) |

You can also add other optional fields here like:

> - `env`: environment variables
> - `resources`: CPU/memory limits
> - `volumeMounts`: mount volumes
> - `livenessProbe`, `readinessProbe`: health checks

---

#### 🔁 Deployment Strategy

Defines how updates to the Deployment should happen.

```bash
strategy:
  type: RollingUpdate   # or Recreate
  rollingUpdate:
    maxSurge: 1
    maxUnavailable: 1
```

**type:**

> - RollingUpdate (default): updates Pods one-by-one.
> - Recreate: deletes old Pods, then creates new ones.

**rollingUpdate.maxSurge:**

> - Max number of extra Pods during update.
> - 1 means one more than desired replicas can be created.

**rollingUpdate.maxUnavailable:**

> - Max number of Pods that can be unavailable during update.
> - 1 means only 2 will serve traffic while the 3rd updates.

**🧠 Other Useful Fields**

| Field                     | Description                                                            |
| ------------------------- | ---------------------------------------------------------------------- |
| `minReadySeconds`         | Minimum time a pod should be ready before it's considered "available". |
| `revisionHistoryLimit`    | How many old ReplicaSets to retain for rollback.                       |
| `progressDeadlineSeconds` | Timeout for Deployment to be considered progressing.                   |

```bash
spec:
  revisionHistoryLimit: 10
  progressDeadlineSeconds: 600
```

---

#### ⚠️ Important Notes

> - **selector.matchLabels must match** `template.metadata.labels` — otherwise Deployment won’t manage Pods.
> - Use `kubectl rollout` commands to monitor, pause, resume, and rollback Deployments.
> - Recommended to use **Deployment** over RC/RS in production.

---

### 🌐 `service.yml` – Expose Pods Outside the Cluster

A **Service** in Kubernetes exposes your application to the outside world (if needed).

#### 📌 Key Fields

| Field            | Description                                 |
| ---------------- | ------------------------------------------- |
| `type: NodePort` | Exposes service on each Node’s IP at a port |
| `selector`       | Matches pods with a specific label.         |
| `port`           | Port on which the service is exposed        |
| `targetPort`     | Port on the container to forward traffic to |

---

### 🚀 Deploy & Manage

#### ✅ Apply Deployment

```bash
kubectl apply -f deployment.yml
```

#### ✅ Apply Service

```bash
kubectl apply -f service.yml
```

#### 🔍 Check Status

```bash
kubectl get deployments
```

```bash
kubectl get pods
```

```bash
kubectl rollout status deployment deployment
```

#### ✏️ Update Deployment

Change the image in the deployment.yml file:

```bash
image: nginx:1.21.6
```

Apply changes:

```bash
kubectl apply -f deployment.yml
```

Kubernetes will trigger a rolling update.

#### 🔄 Rollback a Deployment

```bash
kubectl rollout undo deployment deployment
```

---

### 🌐 Access the Application

> - Get **Node IP**

```bash
kubectl get nodes -o wide
```

**Output:**

| NAME                                        | STATUS | ROLES  | AGE  | VERSION             | INTERNAL-IP  | EXTERNAL-IP        | OS-IMAGE                     | KERNEL-VERSION                  | CONTAINER-RUNTIME   |
| ------------------------------------------- | ------ | ------ | ---- | ------------------- | ------------ | ------------------ | ---------------------------- | ------------------------------- | ------------------- |
| ip-172-31-34-18.ap-south-1.compute.internal | Ready  | <none> | 100m | v1.32.3-eks-473151a | 172.31.34.18 | **13.233.106.220** | Amazon Linux 2023.7.20250512 | 6.1.134-152.225.amzn2023.x86_64 | containerd://1.7.27 |

> - Get the **Service Port**

```bash
kubectl get svc service
```

**Output:**

| NAME    | TYPE     | CLUSTER-IP     | EXTERNAL-IP | PORTS(S)         | AGE |
| ------- | -------- | -------------- | ----------- | ---------------- | --- |
| service | NodePort | 10.100.185.113 | <none>      | 80:**30960**/TCP | 59m |

**Now visit:**

```bash
http://< node/external ip >:< service port >
```

eg:

```bash
http://13.233.106.220:30960
```

**📌 Note:** Make sure **service port** i.e **30960** is allowed in your **Security Group (inbound rules)**.

---

### 🧹 Cleanup

```bash
kubectl delete deployment deployment
```

```bash
kubectl delete service service
```

---

### 👨‍💻 Author

Maintained by **[Krunal Bhandekar](https://www.linkedin.com/in/krunal-bhandekar/)**

---
