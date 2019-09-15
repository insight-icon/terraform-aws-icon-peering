# terraform-aws-icon-peering-mgmt

- Simple peering module with variables exposed to hook up through terragrunt 
- Right now there is no provider given so this will only work in one region 


### TTD 

- Have peering module work in multiple regions 
- Determine if n*(n-1)/2 number of peering connections is realistic to manage 
    - Multi-region will need a peering connection per vpc 
