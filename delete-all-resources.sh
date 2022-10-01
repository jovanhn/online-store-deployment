#!/bin/sh
kubectl delete svc bff-store-service -n mini-dev
# service "bff-store-service" deleted

kubectl delete deployment bff-store -n mini-dev
# deployment.apps "bff-store" deleted

kubectl delete cm bff-store-properties-dev  -n mini-dev
# configmap "bff-store-properties-dev" deleted

kubectl delete ingress mini-ingress -n mini-dev
# ingress.networking.k8s.io "mini-ingress" deleted
