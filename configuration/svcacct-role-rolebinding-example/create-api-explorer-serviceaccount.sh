# --------------------------------------------------------- #
# create-api-explorer-account.sh                            #
#                                                           #
# create a service account that can be used to explore      #
# the kubernetes API.                                       #
# --------------------------------------------------------- #

namespace=""
[[ x$_KCDFNS != x ]] && { namespace=$_KCDFNS; plain=$(echo $_KCDFNS | sed -e 's/-n //g'); }

while [[ "${1}" =~ ^-.* ]]
do
    case "${1}" in
        -h|--help) echo "$(basename ${0}) [-h] [-list] [-delete]"
                   exit 0
                   ;;
        -l|-list)  shift
                   kubectl ${namespace} get serviceaccount api-explorer $@
                   kubectl              get clusterrole/log-reader $@
                   kubectl ${namespace} get rolebindings.rbac.authorization.k8s.io/api-explorer:log-reader $@
                   exit 0
                   ;;
        -d|-delete)
                  kubectl ${namespace} delete rolebindings.rbac.authorization.k8s.io/api-explorer:log-reader
                  kubectl ${namespace} delete serviceaccount api-explorer
                  kubectl              delete clusterrole/log-reader
                  exit 0
                  ;;
        -n|-ns)   shift
                  namespace="-n $2"
		  plain=${2}
                  exit 0
                  ;;
    esac
    shift
done

# 1. Serviceaccount
kubectl ${namespace} create serviceaccount api-explorer

# 2. Cluster Role
kubectl              apply -f - << EOT
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1 
metadata:
  name: log-reader
rules:
- apiGroups: [""]  # "" indicates the core API group
  resources: ["*"] # resources: ["pods", "pods/log"]
  verbs: ["get", "watch", "list"]
EOT

# 3. Bind Cluster Role to Service Account

kubectl ${namespace} create rolebinding api-explorer:log-reader --clusterrole log-reader --serviceaccount ${plain}:api-explorer

exit 0

