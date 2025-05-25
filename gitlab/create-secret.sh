kubectl create secret generic gitlab-keycloak-oauth2 \
  --from-file=provider=provider-keycloak.yaml \
  --namespace=gitlab \
  --dry-run=client -o yaml > gitlab-keycloak-oauth2.yaml

kubeseal --controller-namespace kube-system \
         --controller-name sealed-secrets-controller \
         --format yaml \
         --namespace gitlab \
         < gitlab-keycloak-oauth2.yaml > sealed-gitlab-keycloak-oauth2.yaml
