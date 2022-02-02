source environments/local/$1.sh

./infrastructure/local//switch_context.sh $1

kubectl delete pod --field-selector="status.phase==Failed"