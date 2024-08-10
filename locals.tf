locals {
    all_subnets = {
        "subnet-public-1" = "10.1.0.0/24",
        "subnet-public-2" = "10.1.1.0/24",
        "subnet-private-1" = "10.1.2.0/24",
        "subnet-private-1" = "10.1.3.0/24"
    }
    public_subnets   = [for k, v in local.all_subnets: v if length(regexall(".*public.*", k)) > 0]
    private_subnets  = [for k, v in local.all_subnets : v if(length(regexall(".*priv.*", k)) > 0 || length(regexall(".*compute.*", k)) > 0)]
}