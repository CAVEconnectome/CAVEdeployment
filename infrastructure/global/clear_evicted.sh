source environments/global/$1.sh

./infrastructure/global/switch_context.sh $1

kubectl delete pod --field-selector="status.phase==Failed"