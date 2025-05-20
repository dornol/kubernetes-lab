#!/bin/bash

NAMESPACE=$1

if [[ -z "$NAMESPACE" ]]; then
  echo "❌ 사용법: $0 <namespace>"
  exit 1
fi

if ! kubectl get ns "$NAMESPACE" &> /dev/null; then
  echo "❌ 존재하지 않는 네임스페이스입니다: $NAMESPACE"
  exit 1
fi

echo "📦 네임스페이스 [$NAMESPACE] 모든 리소스 조회 중..."

RESOURCE_LIST=$(kubectl api-resources --verbs=list --namespaced -o name)

for RESOURCE in $RESOURCE_LIST; do
  RESULT=$(kubectl get "$RESOURCE" -n "$NAMESPACE" 2>/dev/null)
  if [[ -n "$RESULT" && "$RESULT" != "No resources found" ]]; then
    echo ""
    echo "📄 $RESOURCE"
    echo "$RESULT"
  fi
done