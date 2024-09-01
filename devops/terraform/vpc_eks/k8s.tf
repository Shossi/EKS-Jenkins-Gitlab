module "k8s" {
  source = "../modules/eks"

  cluster_name = "k8s-cluster"
  subnet_ids   = [module.prod_network.private_subnets[0], module.prod_network.private_subnets[1]]
  vpc_id       = module.prod_network.vpc_id
  node_groups = {
    system = {
      desired_size = 1
      min_size     = 1
      max_size     = 3
      labels = {
        role = "system"
      }
      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
    }
  }

  fargate_profiles = {
    default = {
      name = "default"
      selectors = [
        {
          namespace = "default"
        },
        {
          namespace = "weather"
        }
      ]
    }
  }

  eks_tags = {
    Environment = "dev"
    Project     = "my-project"
  }

}

module "argocd" {
  source     = "../modules/helm"
  depends_on = [module.k8s]
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  vers       = "4.5.2"
  namespace  = "argocd"

  #  set = {
  #    "server.service.type" = "LoadBalancer"
  #    "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type" = "nlb"
  #  }
}


module "ingress_controller" {
  source     = "../modules/helm"
  depends_on = [module.k8s, module.iam_role_ingress]
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  vers       = "1.5.3"
  namespace  = "kube-system"
  set = {
    "clusterName"           = module.k8s.cluster_name
    "awsRegion"             = "eu-west-3"
    "serviceAccount.create" = "true"
    "serviceAccount.name"   = "yossi-ingress"
    "vpcId"                 = module.prod_network.vpc_id
    "image.repository"      = "602401143452.dkr.ecr.eu-west-3.amazonaws.com/amazon/aws-load-balancer-controller"
  }
}

module "iam_role_ingress" {
  source            = "../modules/iam_role_ingress"
  depends_on        = [module.k8s]
  cluster_name      = module.k8s.cluster_name
  env_name          = "eks"
  main-region       = "eu-west-3"
  oidc_provider_arn = module.k8s.oidc_provider_arn
}

module "cluster_autoscaler_service_account" {
  source           = "../modules/cluster-autoscaler"
  cluster_name     = module.k8s.cluster_name
  namespace        = "kube-system"
  oidc_provider_url = module.k8s.cluster_oidc_issuer_url
  policy_name      = "cluster-autoscaler-policy"
  role_name        = "cluster-autoscaler-role"
}

module "cluster_autoscaler" {
  source     = "../modules/helm"
  depends_on = [module.cluster_autoscaler_service_account]
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  vers       = "9.10.9"
  namespace  = "kube-system"
  set = {
    "autoDiscovery.clusterName"                     = module.k8s.cluster_name
    "awsRegion"                                     = "eu-west-3"
    "rbac.create"                                   = "false"
    "serviceAccount.name"                           = module.cluster_autoscaler_service_account.service_account_name
    "extraArgs.balance-similar-node-groups"         = "true"
    "extraArgs.expander"                            = "least-waste"
    "serviceAccount.annotations.eks.amazonaws.com/role-arn" = module.cluster_autoscaler_service_account.iam_role_arn
  }
}

#module "metrics_server" {
#  depends_on = [module.k8s]
#  source     = "../helm"
#  name       = "metrics-server"
#  chart      = "metrics-server"
#  namespace  = "kube-system"
#  repository = "https://kubernetes-sigs.github.io/metrics-server"
#  vers       = "3.7.0"
#  set = {
#    "cluster.enabled" = "true"
#    "metrics.enable"  = "true"
#  }
#
#}

