module "vpc" {
  source = "../modules/vpc"

  // Variables
  region = var.region
  vpc_cidr_block         = var.vpc_cidr_block
  public_subnet_cidr_block  = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  availability_zone = var.availability_zone
  
}


module "igw" {
  depends_on = [
     module.vpc
   ]
  source = "../modules/igw"

  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_ids
  public_subnet_cidr_block  = var.public_subnet_cidr_block
}


module "nat" {
  depends_on = [ module.vpc,module.igw ]

  source = "../modules/nat"

  vpc_id = module.vpc.vpc_id
  private_subnet_id = module.vpc.public_subnet_ids
  public_subnet_id = module.vpc.public_subnet_ids[0]
  public_subnet_cidr_block  = var.public_subnet_cidr_block
  
}



module "securitygroup" {
  depends_on = [
    module.vpc
  ]
  source = "../modules/securitygroup"

  // Variables
  vpc_id = module.vpc.vpc_id
  frontend_instance_sg = var.frontend_instance_sg
  backend_instance_sg = var.backend_instance_sg

}

module "ec2" {
  depends_on = [
    module.vpc, module.securitygroup
  ]
  source = "../modules/ec2"

  // Variables
  frontend_instance_ami = var.frontend_instance_ami
  backend_instance_ami  = var.backend_instance_ami
  instance_type         = var.instance_type
  key_name = var.key_name
  public_subnet_ids       = module.vpc.public_subnet_ids
  private_subnet_ids    = module.vpc.private_subnet_ids
  security_grp_frontend = module.securitygroup.frontend_sg_id
  security_grp_backend = module.securitygroup.backend_sg_id
  subnet_id = var.subnet_id

  
}

module "elb" {
  source = "../modules/elb"
  depends_on = [
    module.vpc
  ]

  // Variables
  
  public_subnet_ids = module.vpc.public_subnet_ids
  security_grp_frontend = module.securitygroup.frontend_sg_id
  security_grp_backend = module.securitygroup.backend_sg_id
  vpc_id = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  public_instance_ids = module.ec2.frontend_instance_ids
  private_instance_ids = module.ec2.backend_instance_ids

}
