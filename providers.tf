terraform {
  # compatible with TF 0.15.x code.
  required_version = ">= 0.13"

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}


provider "kubernetes" {
  config_path = "~/.kube/config"  
  config_context = "minikube2"
}

provider "kubectl" {
  config_path = "~/.kube/config"  
  config_context = "minikube2"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  
    config_context = "minikube2"
  }
  
}

