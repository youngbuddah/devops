# 🧱 Kubernetes Namespaces with YAML Files

This section covers how to apply Kubernetes resources (`pod.yml`, `rc.yml`, `rs.yml` and `deployment.yml`) to specific namespaces using two methods.

---

### 📄 `pod.yml`

#### ✅ Option 1: Add `namespace` in the YAML

Create a file like `pod.yml`
Apply it:

```bash
kubectl apply -f pod.yml
```

> - Make sure the namespace (`my-pod-namespace`) already exists, or create it first with:

```bash
kubectl create namespace my-pod-namespace
```

#### ✅ Option 2: Use `kubectl` with `-n` flag

If your YAML does not specify the namespace, you can still apply it like this:

```bash
kubectl apply -f pod.yml -n my-pod-namespace
```

This overrides the default namespace and places the pod in `my-pod-namespace`.

#### 🔍 Verify

```bash
kubectl get pods -n my-pod-namespace
```

---

### 📄 `rc.yml`

#### ✅ Option 1: Specify `namespace` in the YAML

Create a file like `rc.yml`
Apply it:

```bash
kubectl apply -f rc.yml
```

> - Make sure the namespace (`my-rc-namespace`) already exists, or create it first with:

```bash
kubectl create namespace my-rc-namespace
```

#### ✅ Option 2: Use `kubectl` with `-n` flag

If your YAML does not specify the namespace, you can still apply it like this:

```bash
kubectl apply -f rc.yml -n my-rc-namespace
```

#### 🔍 Verify

```bash
kubectl get rc -n my-rc-namespace
```

---

### 📄 `rs.yml`

#### ✅ Option 1: Specify `namespace` in the YAML

Create a file like `rs.yml`
Apply it:

```bash
kubectl apply -f rs.yml
```

> - Make sure the namespace (`my-rs-namespace`) already exists, or create it first with:

```bash
kubectl create namespace my-rs-namespace
```

#### ✅ Option 2: Use `kubectl` with `-n` flag

If your YAML does not specify the namespace, you can still apply it like this:

```bash
kubectl apply -f rs.yml -n my-rs-namespace
```

#### 🔍 Verify

```bash
kubectl get rs -n my-rs-namespace
```

---

### 📄 `deployment.yml`

#### ✅ Option 1: Specify `namespace` in the YAML

Create a file like `deployment.yml`
Apply it:

```bash
kubectl apply -f deployment.yml
```

> - Make sure the namespace (`my-deployment-namespace`) already exists, or create it first with:

```bash
kubectl create namespace my-deployment-namespace
```

#### ✅ Option 2: Use `kubectl` with `-n` flag

If your YAML does not specify the namespace, you can still apply it like this:

```bash
kubectl apply -f deployment.yml -n my-deployment-namespace
```

#### 🔍 Verify

```bash
kubectl get deployments -n my-deployment-namespace
```

---

### 👨‍💻 Author

Maintained by **[Krunal Bhandekar](https://www.linkedin.com/in/krunal-bhandekar/)**

---
