# Create cookie secret literal
openssl rand -base64 32

kubectl create secret generic oauth2-proxy-secret \
--namespace oauth2-proxy \
--from-literal=client-id="my-client-id" \
--from-literal=client-secret="my-oauth2-secret" \
--from-literal=cookie-secret="my-cookie-secret" \
--dry-run=client -o yaml > oauth2-proxy-secret.yaml

kubeseal --controller-namespace kube-system \
         --controller-name sealed-secrets-controller \
         --format yaml \
         --namespace oauth2-proxy \
         < oauth2-proxy-secret.yaml > sealed-oauth2-proxy-secret.yaml
         