locals {
   public_subnets = {
    "subnet1" = "10.1.0.0/24",
    "subnet2" = "10.1.1.0/24"
  }

  private_subnets = {
    "subnet3" = "10.1.2.0/24",
    "subnet4" = "10.1.3.0/24"
  }
}